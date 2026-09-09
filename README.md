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
