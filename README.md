# 🌊 Vibe Coding

Base de conocimiento del curso **Vibe Coding** de Imperio Digital: clases, skills reutilizables y plantillas.

> Mismo enfoque que [imperioagentico](https://github.com/gmusicproyect/imperioagentico) (curso Claude Code): cada clase se transcribe, se sintetiza y se deja lista para estudiar y practicar — no es un volcado de transcripción cruda.

---

## 📁 Estructura del repositorio

```
vibe-coding/
├── curso-vibe-coding/
│   └── clases/                 → Resumen de cada clase en Markdown
├── bonos/                      → Módulos extra (herramientas externas específicas)
│   └── forge-studio/           → Estudio de contenido y carruseles a costo $0
├── skills/                     → Skills reutilizables (.md)
└── recursos/plantillas/        → CLAUDE.md global y por proyecto
```

---

## 🗺️ Clases

| # | Clase | Temas clave |
|---|-------|-------------|
| 01 | [3 preguntas antes de elegir tu stack](curso-vibe-coding/clases/clase-01-stack-vibe-coding.md) | Criterios de stack, IDEs vs. ADEs, Golden Path, Vercel vs. VPS, RLS |
| 02 | [Cómo tunear tu Claude Code](curso-vibe-coding/clases/clase-02-tunear-claude-code.md) | Niveles de control (Sugerencia/Regla/Pared), Output style, Hooks de seguridad, GLM 5.3, multi-sesión |
| 03 | [Cómo dejar de empezar de cero cada mañana](curso-vibe-coding/clases/clase-03-segundo-cerebro.md) | Arquitectura de 3 cajones (Raw/Wiki/CLAUDE.md), entidades y apodos, Daily Harvest, grafos vs. expediente |
| 04 | [El que encuentra el bug no lo arregla](curso-vibe-coding/clases/clase-04-adversarial-review.md) | Principio del autógrafo, plugin de Codex, trampas de auditoría, auditoría visual con browser tools, checkpoints |
| 05 | [El agente nativo de GHL no basta](curso-vibe-coding/clases/clase-05-gohighlevel.md) | Tiers y snapshots, re-billing, MCP multicuenta, webhooks vs IA nativa, aislamiento de datos sensibles |
| 06 | [Nueva Ley de Datos: aplica aunque no vivas en Chile](curso-vibe-coding/clases/clase-06-ley-de-datos.md) | Ley 21.719 (RGPD), minimización técnica, derechos ARCO+, fin de cajas negras, EIPD, skill revisar-datos-personales |
| 07 | [UI que no grita IA: componentes y design tokens](curso-vibe-coding/clases/clase-07-ui-tokens.md) | UI sin AI Slop, Design Tokens en 3 capas, Tailwind v4 @theme, brand.json, Showcase/UI Kit, Criterio CLI, Agentation |
| 08 | [UX + Seguridad en Web Apps con IA](curso-vibe-coding/clases/clase-08-ux-seguridad.md) | Historia B-17 y UX, 4 estados obligatorios, 6 reglas de formularios, RLS en Supabase, prevención service_role en frontend |
| 09 | [Claude Code desde Cero: Skills, MCPs y seguridad](curso-vibe-coding/clases/clase-09-claude-code-desde-cero.md) | Higiene de contexto, Prompt Caching (5 min), subagentes con fork, /insights, SDD/MoSCoW, handoff.md, OWASP y RLS |
| 10 | [El Agente de 5 USD que reemplaza tu flujo entero](curso-vibe-coding/clases/clase-10-agente-5usd-cloudflare.md) | Cloudflare Workers, Agents as a Service (AaaS), OpenRouter, Durable Objects, Wrangler CLI, Rate Limiting |
| 11 | [Cómo gestionar clientes y contexto con Claude Code](curso-vibe-coding/clases/clase-11-gestionar-clientes-contexto.md) | Metodología 3-3-3, aislamiento por carpetas, contratos entre sesiones, Kanban Dashboard maestro, Vercel Drop |
| 12 | [De Vibe Coding a Vibe Marketing](curso-vibe-coding/clases/clase-12-vibe-marketing.md) | Forge Studio, pipeline de 6 fases, carruseles a costo $0, stack híbrido nube/local |
| 13 | [El Golden Path del Vibe Coding: Fable 5 vs Opus 4.8 en Vivo](curso-vibe-coding/clases/clase-13-golden-path-fable-vs-opus.md) | Blueprint único, stack Next.js/Supabase/shadcn, benchmark Fable 5 vs Opus 4.8 |
| 14 | [Tu agente programa solo mientras duermes](curso-vibe-coding/clases/clase-14-tu-agente-programa-solo-duermes.md) | Orquestación 24/7 (Hermes/VPS), compuertas Git en ramas, N8N vs código puro, Sentry auto-fix |
| 15 | [Arneses Conectados: Hermes + Claude Code en Vivo](curso-vibe-coding/clases/clase-15-arneses-conectados-hermes-claude-code.md) | Harness Engineering (5 piezas), Print Mode `claude -p`, Tmux, ACP, Claude Agents SDK |
| 16 | [Domina GitHub como un experto](curso-vibe-coding/clases/clase-16-domina-github-experto.md) | Git vs GitHub, jerarquía Repo-Epics-Issues, ramas protegidas, Actions CI/CD |
| 17 | [Hermes vs OpenClaw + Skills en Claude Code](curso-vibe-coding/clases/clase-17-hermes-vs-openclaw-skills.md) | Hermes vs OpenClaw, memoria y automejora, skills usuario vs proyecto, higiene de contexto |
| 18 | [Cómo estructurar sesiones y agentes en Claude Code](curso-vibe-coding/clases/clase-18-estructurar-sesiones-agentes.md) | Sprints y prompt cache (5 min), cascada Blueprint-Plan-Tasks, modularizar CLAUDE.md, subagentes |
| 19 | [Claude Code + N8N: Kit, MCP y Skills desde 0](curso-vibe-coding/clases/clase-19-claude-code-n8n-kit.md) | n8n-automation-kit, conexión MCP, Playwright persistente, workflows deterministas vs AI, Make a n8n |
| 20 | [Cerramos Núcleo: Deploy, GitHub y pruebas en vivo](curso-vibe-coding/clases/clase-20-cerramos-nucleo-deploy-github.md) | Definition of Done con Playwright MCP, InsForge vs Supabase, Context 7, ramas atómicas y RLS |
| 21 | [Cómo no quemar tokens construyendo una app real](curso-vibe-coding/clases/clase-21-como-no-quemar-tokens.md) | Fast Phase Prompt Caching (<5 min), poda de MCPs, umbrales de saturación, Modo Yunque vs Forja y Blueprint maestro |
| 22 | [Construimos una app desde 0 con Claude Code](curso-vibe-coding/clases/clase-22-construimos-app-desde-cero.md) | Viability Check, PDR y Happy Path, Tech Specs con índices trigram, auditoría cruzada con Codex y El Crisol |
| 23 | [Claude Code: estructura de proyectos y skills](curso-vibe-coding/clases/clase-23-estructura-proyectos-skills.md) | Jerarquía bash-safe, Claude AI vs Cowork vs Code, Remote Control (/rc), scopes de skills y Agentation |
| 24 | [Claude Code vs. OpenClaw: Agentes y Subagentes](curso-vibe-coding/clases/clase-24-claude-code-vs-openclaw-agentes.md) | Agentes en Claude Code (/agents), subagentes en OpenClaw, Remote SSH en Antigravity y auditoría de SOUL.md |
| 25 | [Antigravity, Claude Code y OpenClaw](curso-vibe-coding/clases/clase-25-antigravity-claude-code-openclaw.md) | Vibe Coding, Antigravity multi-modelo (Claude + Kilo/Codex + Gemini), visibilidad de skills y /models en OpenClaw |
| 26 | [Cómo Proteger OpenClaw en un VPS con Tailscale](curso-vibe-coding/clases/clase-26-proteger-openclaw-vps-tailscale.md) | Riesgo de exposición pública (Shodan/Censys), VPN privada con Tailscale, cierre de puerto con UFW |
| 27 | [Vibe Coding con Antigravity: De la Idea al Deploy](curso-vibe-coding/clases/clase-27-vibe-coding-antigravity-de-idea-a-deploy.md) | Vibe Coding, stack MVP (Dribbble/AI Studio/Antigravity/Supabase/Vercel), modos de autonomía y billing en GCP |
| 28 | [Instalación y Configuración de Antigravity](curso-vibe-coding/clases/clase-28-instalacion-configuracion-antigravity.md) | Aprovisionamiento del stack (GitHub/Supabase/AI Studio/Vercel), gobernanza (Review-driven development), Planning vs Fast Mode |
| 29 | [Dominando Google AntiGravity: El Manual del 1%](curso-vibe-coding/clases/clase-29-dominando-antigravity-manual-del-1.md) | 4 pilares (Planificación, Orquestación, Ecosistema, Personalización), Agent Manager, MCPs, Workflows y Reglas |
| 30 | [Supabase y MCP: Conexiones Dinámicas en Antigravity](curso-vibe-coding/clases/clase-30-supabase-mcp-conexiones-antigravity.md) | Supabase como backend relacional, 4 métodos de conexión MCP (GitHub/Supabase/Vercel/n8n), regla de oro de verificación |
| 31 | [Primera Win: Clon de Linktree con Antigravity y Deploy en Vercel](curso-vibe-coding/clases/clase-31-primera-win-clon-linktree-antigravity.md) | Win rápida 0 a 100, deploy en Vercel, QA con navegador |
| 32 | [Mejores Prácticas, Metaprompting y Maquetación del MVP](curso-vibe-coding/clases/clase-32-metaprompting-prd-maquetacion-mvp.md) | Metaprompting, PRD como "biblia", 5 reglas de trabajo por features, flujo Gem→Google AI Studio→GitHub→Antigravity |
| 33 | [Clonar el Repo, Plan de Desarrollo, Localhost y Primeros Fixes](curso-vibe-coding/clases/clase-33-clonar-repo-plan-desarrollo-local-fixes.md) | Clonación GitHub, Planning Mode con PRD, .env.local (AI Studio + Supabase), Vite dev y browser QA para fixes visuales |
| 34 | [Supabase Real: Creación de Tablas SQL, Guardado y Fixes de UI](curso-vibe-coding/clases/clase-34-supabase-tablas-sql-guardado-fixes.md) | Permisos MCP vs SQL Editor, esquema DDL (clients/diagnostics/quotes), fixes de share link y dark mode en wizard |
| 35 | [Arquitectura Híbrida con n8n, Email Composer y Buenas Prácticas con Git](curso-vibe-coding/clases/clase-35-arquitectura-hibrida-n8n-email-composer-git.md) | Modelo híbrido (UI Antigravity + Webhook n8n), Email Composer con IA, API keys n8n y commits atómicos con Git |
| 36 | [Supabase Auth, Verificación por Email y Deploy a Vercel](curso-vibe-coding/clases/clase-36-supabase-auth-email-verification-deploy-vercel.md) | Supabase Auth vs BetterAuth, confirmación forzosa por email, inyección de env vars y deploy a producción en Vercel |
| 37 | [Bonus: Convertir el MVP en una PWA (Progressive Web App)](curso-vibe-coding/clases/clase-37-bonus-convertir-mvp-en-pwa.md) | Web App Manifest, iconografía con IA, layout mobile-first, higiene para repo público e instalación en iPhone/Android |
| 38 | [Qué es OpenClaw (ex Clawdbot / Moltbot): Autonomía, Memoria y Riesgos](curso-vibe-coding/clases/clase-38-que-es-openclaw-autonomia-memoria-riesgos.md) | Agente autónomo vs LLM reactivo, auto-creación de herramientas, memoria persistente, riesgos y blindaje en VPS |
| 39 | [Instalación de OpenClaw en un VPS Limpio: Seguridad, Usuario Aislado y Quickstart](curso-vibe-coding/clases/clase-39-instalacion-openclaw-vps-seguridad.md) | VPS en Hostinger, Ubuntu 24.04 LTS, usuario dedicado sin privilegios de root, instalación oficial y Quick Start |
| 40 | [Configuración de OpenClaw: Modelo, Telegram, Skills y Servicio Persistente](curso-vibe-coding/clases/clase-40-configuracion-openclaw-telegram-systemd.md) | API Key aislada, BotFather, selección de skills, gateway y persistencia con systemd |

### Bonos

| Bono | Descripción |
|------|-------------|
| [Forge Studio Lite](bonos/forge-studio/) | Estudio de contenido automatizado, carruseles a costo $0 y composición HTML/video |

---

## ⚡ Inicio rápido

1. Clona el repo: `git clone https://github.com/gmusicproyect/vibe-coding`
2. Navega a la clase que necesites en `curso-vibe-coding/clases/`
3. Usa las plantillas de `recursos/plantillas/` para nuevos proyectos
4. Copia los skills de `skills/` directamente a tu carpeta de Claude Code

---

*Actualizado: Septiembre 2026 · Imperio Digital*
