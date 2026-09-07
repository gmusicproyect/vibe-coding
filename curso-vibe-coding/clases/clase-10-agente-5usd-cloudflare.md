# Clase 10 — El Agente de 5 USD que reemplaza tu flujo entero

**Tags:** `Cloudflare Workers` `Agents as a Service` `OpenRouter` `Wrangler CLI`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 08](clase-08-ux-seguridad.md) · [Clase 09](clase-09-claude-code-desde-cero.md)

---

## Idea central

Los flujos visuales en N8N o Make sufren de fragilidad, mantenimiento manual y dependencia de servidores dedicados (VPS) costosos y difíciles de escalar. La arquitectura moderna de agentes para producción en 2026 traslada la ejecución a Cloudflare Workers por $5 USD al mes: Claude Code actúa como el ingeniero que escribe, prueba y despliega el código, OpenRouter suministra inteligencia multimodal a fracciones de centavo, y Durable Objects aporta memoria persistente sin requerir una base de datos externa. Esta tríada habilita el modelo *Agents as a Service* (AaaS), permitiendo monetizar automatizaciones resilientes bajo suscripción recurrente.

---

## Comparativa de arquitecturas: N8N vs. Managed Agents vs. Cloudflare Workers

| Criterio | N8N / Make | Managed Agents (Anthropic) | Claude Code + Cloudflare Workers |
| :--- | :--- | :--- | :--- |
| **Construcción** | Nodos visuales arrastrables | Código desde cero en SDK | Lenguaje natural interpretado por Claude Code |
| **Mantenimiento** | Manual; cacería de nodos rotos | Manual a nivel de código | Claude Code lee logs vía CLI y repara errores |
| **Costo base** | VPS ($10–$25/mes) o licencias | Alto (consumo directo API Anthropic) | $0 a $5/mes en Cloudflare + centavos de LLM |
| **Memoria** | Requiere PostgreSQL externo | En contexto / arnés de sesión | Nativa con Durable Objects de Cloudflare |
| **Cuándo brilla** | Prototipado rápido y no técnicos | Ecosistemas cerrados de Anthropic | Producción escalable, bajo costo y multi-tenant |

---

## Anatomía de un agente autónomo: Las 3 cajas

Cualquier agente en producción se compone de tres bloques desacoplados:

```
[ Entrada ]               [ Procesamiento ]                 [ Salida ]
- Cron (proactivo)    →   - Cerebro: LLM (OpenRouter)   →   - Notifica (Telegram, Discord, Resend)
- Webhook (reactivo)  →   - Memoria: Durable Objects    →   - Actualiza CRM / Base de datos
- Formulario HTTP     →   - Bucle de decisión y tools   →   - Respuesta JSON estructurada
```

1. **Entrada (Triggers):** Tareas programadas en el tiempo (`Cron`), eventos disparados por pasarelas o formularios (`Webhooks`), o peticiones HTTP directas.
2. **Procesamiento:** El LLM evalúa contexto, decide si invocar herramientas y consulta o persiste estado en Durable Objects sin latencia de red externa.
3. **Salida:** Dispara acciones en el mundo real (envío de emails con Resend, alertas de mensajería o actualización de estados).

---

## Flujo de desarrollo y despliegue con Wrangler CLI

El ciclo completo se orquesta desde la terminal o el arnés de Claude Code sin tocar el panel web:

```bash
# 1. Instalación del skill oficial de Carlos Domínguez (La Forja / Imperio Agéntico)
curl -fsSL https://raw.githubusercontent.com/Carlos-Dominguez-faber/crear-agente-imperio/main/install.sh | bash
# Invocar en Claude Code: /crear-agente (guía paso a paso de 8 fases)

# 2. Navegar al directorio y probar en servidor local (puerto 8787)
cd demo-triash-leads
npx wrangler dev

# 3. Autenticación contra Cloudflare y despliegue al edge global
npx wrangler login
npx wrangler deploy

# 4. Inyectar secretos encriptados (nunca en código ni wrangler.toml)
npx wrangler secret put OPENROUTER_API_KEY
```

---

## Blindaje y seguridad en agentes expuestos a la web

Cuando un worker expone endpoints públicos o formularios, es mandatorio aplicar tres capas de defensa:

1. **Rate Limiting estricto:** Integrar herramientas como Upstash Redis o el Rate Limiting nativo de Cloudflare (ej. máximo 3 peticiones diarias para usuarios anónimos y 20 para usuarios autenticados).
2. **Anti-Prompt Injection y acotamiento de negocio:** El System Prompt debe definir taxativamente los límites de operación del negocio. Si el usuario intenta desviar al agente (ej. pedirle código de programación o resúmenes ajenos), debe retornar una negativa determinista.
3. **Límites de gasto de API:** Configurar techos de consumo mensuales (ej. $10 USD) en el panel de OpenRouter para neutralizar costos imprevistos si se vulnera una barrera de frontend.
4. **Fuentes autenticadas en producción (Límite del edge):** El scraping gratuito (Google News RSS / GDELT) funciona en local desde IP residencial pero falla en producción con `503` o `429` por IPs compartidas de datacenter en Cloudflare. Para agentes en producción confiables, usar fuentes con API Key (NewsAPI con 100 requests/día gratis o Apify).

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Crea una carpeta local `agente-triage`, inicializa un worker con `npm init cloudflare@latest` seleccionando TypeScript/JavaScript básico, e implementa un endpoint `POST /triage` que reciba `{ "mensaje": string }` y devuelva mediante OpenRouter una clasificación en JSON (`temperatura`: caliente/tibio/frío, `urgencia`: 1-10 y `respuesta_sugerida`). Pruébalo en local con `npx wrangler dev` y `curl`.

**Ejercicio 2 (avanzado):** Despliega el worker a tu subdominio de Cloudflare (`npx wrangler deploy`), guarda tu clave con `npx wrangler secret put OPENROUTER_API_KEY`, y añade una regla de validación de entrada que descarte peticiones sin mensaje o mayores a 500 caracteres antes de invocar el LLM.

---

## 💡 Tip

Para iterar rápidamente en la fase de descubrimiento de modelos, usa modelos de bajo costo y alta velocidad a través de OpenRouter (como `anthropic/claude-3-haiku` o `deepseek/deepseek-chat`). El costo por ejecución ronda los $0.005 USD, lo que permite realizar miles de pruebas de triage y clasificación sin superar el presupuesto de café de un día.

---

## ⚠️ Error común

Subir la API Key de OpenRouter directamente en el archivo `wrangler.toml` o en constantes del código fuente y subirlo a GitHub. La clave queda indexada y expuesta a scraping en segundos. La única forma segura de suministrar credenciales a un worker es mediante el comando interactivo `npx wrangler secret put NOMBRE_SECRETO`.
