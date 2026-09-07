# SKILL: Crear Agente Imperio (Cloudflare Workers + OpenRouter)

> Guarda este archivo en `/skills/crear-agente-imperio/SKILL.md`
> Repositorio oficial: [Carlos-Dominguez-faber/crear-agente-imperio](https://github.com/Carlos-Dominguez-faber/crear-agente-imperio)
> Comando de instalación 1-liner:
> ```bash
> curl -fsSL https://raw.githubusercontent.com/Carlos-Dominguez-faber/crear-agente-imperio/main/install.sh | bash
> ```
> Windows (PowerShell):
> ```powershell
> irm https://raw.githubusercontent.com/Carlos-Dominguez-faber/crear-agente-imperio/main/install.ps1 | iex
> ```
> Trigger en Claude Code: `/crear-agente` o `/crear-agente-imperio`

---

## Cuándo usar este skill

Cuando una persona (incluso sin conocimientos previos de programación) quiera construir, probar en local y publicar en producción un agente autónomo de IA que viva en Cloudflare Workers y utilice OpenRouter para ejecutar tareas continuas por ~$5 USD/mes.

Forma parte de **La Forja**, metodología de desarrollo agéntico enseñada por Carlos Domínguez en **Imperio Agéntico**.

---

## El SOP visual de 3 fases

Antes de escribir código, se define el agente completando este mapa conceptual:

```
   ┌──────────────┐      ┌─────────────────────────┐      ┌──────────────┐
   │   ENTRADA    │  →   │     PROCESAMIENTO       │  →   │    SALIDA    │
   │ (disparador  │      │  (Cloudflare Agent)     │      │  (acciones)  │
   │  + fuente)   │      │                         │      │              │
   └──────────────┘      └─────────────────────────┘      └──────────────┘

  ¿QUÉ LO DESPIERTA?     ¿QUÉ HACE CON LA INFO?         ¿QUÉ ENTREGA?
  ──────────────────     ────────────────────────       ─────────────────
  • Cron (agendado)      • LLM (OpenRouter):            • Guardar datos:
  • Webhook (evento)       - Resume                        - Supabase
                           - Clasifica / sentimiento       - Notion
  ¿DE DÓNDE SACA INFO?     - Genera contenido              - Google Sheets
  ──────────────────       - Decide                     • Avisar:
  • NewsAPI / RSS        • Memoria (Durable Object):       - Pushover (push)
  • Sitios web / Scrape    - Recuerda lo visto             - Slack / Email
  • Apify (X / Redes)      - Evita duplicados           • Reporte:
  • Email / API / Form   • Lógica propia (umbrales)        - JSON / Dashboard
```

---

## Protocolo de 8 fases para guiar al usuario

1. **Fase 0 — Detección de entorno:** Verificar OS (Mac/Linux/Windows), Node.js (≥ 20.x), npm y Wrangler.
2. **Fase 1 — Entrevista conversacional:** Identificar la necesidad sin tecnicismos y mapearla a un patrón arquitectónico (Trend Watcher, Lead Triage, Daily Brief, etc.).
3. **Fase 2 — Dibujo de la arquitectura:** Confirmar las 3 cajas (Entrada → Procesamiento → Salida) antes de programar.
4. **Fase 3 — Configuración de cuentas y llaves:** Guiar la obtención de credenciales necesarias:
   - Cloudflare (`dash.cloudflare.com`) + subdominio `*.workers.dev`.
   - OpenRouter (`openrouter.ai`) con saldo inicial y tope de gasto.
   - Fuentes externas autenticadas (NewsAPI, Apify, Pushover, Notion según aplique).
5. **Fase 4 — Generación del código:** Ensamblar el worker utilizando los blueprints (`worker-skeleton.ts`, `wrangler-template.jsonc`) y fragments especializados (`llm-classify.ts`, `scrape-newsapi.ts`, etc.).
6. **Fase 5 — Prueba local obligatoria:** Ejecutar `npx wrangler dev`, levantar en `http://localhost:8787` y validar respuestas con payloads de prueba.
7. **Fase 6 — Publicación en producción:**
   - Iniciar sesión: `npx wrangler login`.
   - Compilar y desplegar: `npx wrangler deploy`.
   - Inyectar credenciales encriptadas: `npx wrangler secret put OPENROUTER_API_KEY`.
8. **Fase 7 — Verificación y monitoreo:** Validar URL en vivo (`https://agente.[subdominio].workers.dev`) y confirmar que los logs registren ejecuciones sin errores.

---

## Regla de oro para fuentes de datos (Límite del edge)

- **Local (`wrangler dev`):** Scraping libre (Google News, GDELT) funciona porque corre bajo IP residencial.
- **Producción (`wrangler deploy`):** Las peticiones anónimas fallan con `503 Service Unavailable` o `429 Too Many Requests` porque Cloudflare utiliza IPs de datacenter compartidas que son bloqueadas.
- **Solución mandataria:** En producción, utilizar siempre fuentes con **API Key** (NewsAPI free con 100 llamadas/día, Bing News o Apify).
