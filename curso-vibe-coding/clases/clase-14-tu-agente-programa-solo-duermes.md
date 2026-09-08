# Clase 14 — Tu agente programa solo mientras duermes

**Tags:** `Agentes24/7` `Hermes` `GitBranching` `AutoFix`
**Conecta con:** [Clase 02](clase-02-tunear-claude-code.md) · [Clase 11](clase-11-gestionar-clientes-contexto.md) · [Clase 15](clase-15-arneses-conectados-hermes-claude-code.md)

---

## Idea central

Un agente de desarrollo 24/7 desacopla la orquestación de la ejecución: un servicio liviano siempre activo (Hermes u OpenClaw en VPS o Mac Mini) recibe eventos por mensajería o webhooks y delega tareas a Claude Code CLI en local. La regla de oro para operar desatendido mientras duermes es el aislamiento estricto en ramas de Git (`feature/*` o `fix/*`): el agente jamás toca `main` directamente y todo merge requiere compuerta de aprobación humana.

---

## Arquitectura de desarrollo desatendido

El flujo divide responsabilidades para evitar alucinaciones destructivas en producción:

```
[Telegram / Sentry Webhook] 
           │
           ▼
[Orquestador 24/7 (Hermes/VPS)] ──(Prompt de tarea)──► [Claude Code CLI]
           ▲                                                   │
           │                                          (git checkout -b fix/...)
           │                                          (Edición + Tests locales)
           │                                          (git commit + git push)
           │                                                   │
           └────────────(Notificación con PR URL)──────────────┘
```

1. **Ingreso:** Un mensaje de Telegram o un webhook de error (ej. Sentry con stack trace) despierta al orquestador.
2. **Aislamiento:** Claude Code crea una rama temporal independiente (`git checkout -b fix/issue-123`).
3. **Ejecución y Verificación:** Claude Code analiza los logs, edita los archivos y ejecuta tests y linters del proyecto.
4. **Compuerta de seguridad:** Sube la rama y abre un Pull Request en GitHub. Notifica el link al usuario y espera aprobación para el merge.

---

## Transición arquitectónica: N8N vs Código Puro

Cuando las automatizaciones agénticas crecen en volumen o atienden múltiples clientes (multitenant):

| Criterio | N8N / No-Code | Código Puro (Next.js / Node / Agent SDK) |
|----------|---------------|------------------------------------------|
| **Curva de entrada** | Rápida y visual mediante canvas | Requiere setup inicial de proyecto |
| **Escalabilidad** | Limitada por RAM y workers dedicados | Alta, stateless en serverless o contenedores |
| **Control de estado** | Depende de la base interna de N8N | Total con Supabase Realtime / PostgreSQL |
| **Mantenimiento** | Engorroso al encadenar decenas de nodos | Modular, refactorizable con Claude Code |
| **Control de versiones** | Export de JSON propenso a conflictos | Flujo nativo de Git, PRs y CI/CD |

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Configurar una compuerta de trabajo autónomo en Claude Code para tareas desatendidas. En tu proyecto, define una instrucción en `CLAUDE.md` o ejecuta un prompt donde obligues a Claude Code a trabajar en una rama aislada:
```bash
# Instrucción para ejecución autónoma segura
"Crea una rama git llamada 'refactor/optimizar-logging'. Revisa los endpoints de la API, agrega logs estructurados en formato JSON sin alterar la lógica de negocio, corre la suite de pruebas del proyecto y crea un commit con mensaje convencional. No hagas checkout ni merge a main."
```
Verifica con `git status` y `git branch` que los cambios quedaron exclusivamente en la rama creada y que `main` se mantiene intacto. Este ejercicio te deja lista la compuerta de seguridad para delegar tareas a agentes nocturnos sin riesgo de romper producción.

**Ejercicio 2 (avanzado):** Simula un flujo de auto-fixing: toma un stack trace de error de consola, pásalo a Claude Code con la instrucción de aislar la causa raíz en una rama `fix/error-demo`, aplicar el parche y reportar el diff exacto para revisión humana antes de cualquier integración.

---

## 💡 Tip

Limita los tokens de acceso personal (PAT) de GitHub que entregas al entorno 24/7: configúralos con permisos exclusivos de lectura de repositorio y escritura de pull requests, desactivando privilegios administrativos y de push directo a ramas protegidas.

---

## ⚠️ Error común

Permitir que un agente autónomo trabaje directamente sobre la rama `main` o tenga permisos de auto-merge. Ante un fallo en una API externa o una alucinación en bucle, el agente puede sobreescribir archivos críticos o introducir regresiones masivas mientras no estás supervisándolo.
