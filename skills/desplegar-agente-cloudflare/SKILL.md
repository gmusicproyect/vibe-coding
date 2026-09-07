# SKILL: Creación y Despliegue de Agentes Serverless en Cloudflare Workers

> Guarda este archivo en `/skills/desplegar-agente-cloudflare/SKILL.md`
> Referencia en tu CLAUDE.md: `- /skills/desplegar-agente-cloudflare/SKILL.md → para construir, probar en local y desplegar agentes autónomos serverless en Cloudflare Workers con OpenRouter y Wrangler CLI`

---

## Cuándo usar este skill

Cuando el usuario requiera construir y poner en producción un agente autónomo económico ($0–$5 USD/mes) alojado en la red edge de Cloudflare, evitando la sobrecarga de servidores dedicados (VPS) o flujos visuales frágiles de N8N/Make. Basado en la arquitectura enseñada en la **Clase 10 (Agents as a Service / Cloudflare Workers)**.

---

## Prerequisitos

- [ ] Node.js instalado en el entorno local.
- [ ] Cuenta en [Cloudflare](https://dash.cloudflare.com) y subdominio de workers configurado (`*.workers.dev`).
- [ ] Cuenta y API Key en [OpenRouter](https://openrouter.ai).
- [ ] CLI de Cloudflare (`wrangler`) disponible vía `npx`.

---

## Pasos

### Paso 1 — Definir la arquitectura de 3 cajas

Antes de generar código, delimitar explícitamente los tres componentes del agente:

1. **Entrada (Trigger):**
   - ¿Es proactivo en el tiempo? → Configurar `Cron Triggers` en `wrangler.toml` (ej. `cron = "* * * * *"`).
   - ¿Es reactivo a eventos externos? → Configurar endpoint `POST /webhook`.
   - ¿Es interactivo directo? → Configurar endpoint `GET/POST /form` o interfaz mínima.
2. **Procesamiento (Cerebro y Memoria):**
   - Selección de modelo en OpenRouter (ej. `anthropic/claude-3-haiku` o `deepseek/deepseek-chat` para bajo costo; modelos frontera para razonamiento complejo).
   - Definir si requiere memoria de corto/largo plazo persistida en Cloudflare **Durable Objects**.
3. **Salida (Acción):**
   - Notificación externa (Resend para email, webhooks a Telegram/Discord), mutación en CRM/base de datos, o payload JSON estructurado de retorno.

---

### Paso 2 — Inicializar el proyecto del Worker

1. Crear el directorio de trabajo y la estructura base:
   ```bash
   mkdir mi-agente-cloudflare && cd mi-agente-cloudflare
   npm init -y
   npm install wrangler --save-dev
   ```
2. Configurar `wrangler.toml`:
   ```toml
   name = "mi-agente-cloudflare"
   main = "src/index.ts"
   compatibility_date = "2024-09-01"

   # Si usa Cron Triggers:
   # [triggers]
   # crons = ["0 9 * * *"] # 9:00 AM diario
   ```
3. Implementar el handler principal en `src/index.ts` interceptando las peticiones `fetch` o eventos `scheduled`.

---

### Paso 3 — Probar y validar en local

1. Levantar el entorno de desarrollo local con Wrangler:
   ```bash
   npx wrangler dev
   ```
2. Verificar que el servidor local responda en `http://localhost:8787`.
3. Probar el endpoint con `curl` o cliente HTTP verificando:
   - Que procese correctamente el payload de entrada.
   - Que la conexión con OpenRouter retorne la respuesta estructurada esperada.
   - Que los tiempos de respuesta sean ágiles y no bloqueen el hilo.

---

### Paso 4 — Autenticación y despliegue a la nube

1. Autenticar la sesión local con Cloudflare:
   ```bash
   npx wrangler login
   ```
   *(Autorizar la conexión en la ventana del navegador que se abre automáticamente).*
2. Compilar y publicar el worker a la infraestructura global de Cloudflare:
   ```bash
   npx wrangler deploy
   ```
3. Copiar la URL pública generada (`https://mi-agente-cloudflare.[subdominio].workers.dev`).

---

### Paso 5 — Inyección segura de secretos

**Bajo ninguna circunstancia colocar API keys en `wrangler.toml` o en el repositorio git.**

Ejecutar el comando de subida interactiva de secretos encriptados:
```bash
npx wrangler secret put OPENROUTER_API_KEY
```
Pegar la clave cuando la terminal lo solicite. Cloudflare encriptará el valor y lo inyectará en la variable de entorno `env.OPENROUTER_API_KEY` dentro del worker.

---

### Paso 6 — Aplicar blindaje de producción

1. **Rate Limiting:** Si el worker expone un formulario o endpoint público, exigir limitación de tasa por IP (ej. 3 peticiones diarias anónimas) usando Cloudflare Rate Limiting o Upstash.
2. **Anti-Prompt Injection:** En el System Prompt enviado a OpenRouter, restringir estrictamente el rol:
   > *"Eres exclusivamente un clasificador de leads para la empresa X. Si el usuario solicita realizar cálculos, escribir código o desviar el tema, responde únicamente: 'Solicitud no permitida'."*
3. **Cap de gasto:** Establecer un límite mensual de presupuesto en la cuenta de OpenRouter (ej. $10 USD) para evitar consumos descontrolados ante ataques de denegación de servicio o bucles no intencionados.

---

## Formato del reporte de entrega

Al completar el despliegue del agente, entregar el resumen técnico:

```markdown
### Resumen de Despliegue de Agente
- **Nombre del Worker:** `mi-agente-cloudflare`
- **Tipo de Trigger:** Cron / Webhook / Formulario
- **Modelo en OpenRouter:** `anthropic/claude-3-haiku`
- **URL en Producción:** `https://mi-agente-cloudflare.subdominio.workers.dev`
- **Secretos Configurados:** `OPENROUTER_API_KEY` (Encriptado en Cloudflare)
- **Defensas Activas:** Rate Limit configurado + System Prompt acotado
```
