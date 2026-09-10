# Clase 24 — Claude Code vs. OpenClaw: Agentes y Subagentes

**Tags:** `Agentes` `OpenClaw` `Remote SSH` `Subagentes`
**Conecta con:** [Clase 17](clase-17-hermes-vs-openclaw-skills.md) · [Clase 18](clase-18-estructurar-sesiones-agentes.md) · [Clase 23](clase-23-estructura-proyectos-skills.md)

---

## Idea central

La orquestación multiagente presenta dos paradigmas complementarios: Claude Code gestiona agentes especializados dentro del ciclo de desarrollo (`.claude/agents/` con comando interactivo `/agents`), mientras que OpenClaw orquesta agentes y subagentes autónomos persistentes en un VPS (`~/.openclaw/`). La clave para supervisar y personalizar agentes remotos es prescindir de comandos ciegos de consola y conectar Antigravity vía Remote SSH hacia el servidor para auditar visualmente archivos de configuración (`openclaw.json`), perfiles cognitivos (`SOUL.md`, `USER.md`) y validar la existencia real de subagentes.

---

## 1. Agentes en Claude Code vs. Subagentes en OpenClaw

Comprender la diferencia arquitectónica entre ambos sistemas evita confusiones operativas:

| Parámetro | Agentes en Claude Code | Agentes y Subagentes en OpenClaw |
| :--- | :--- | :--- |
| **Entorno de Vida** | Local/CLI dentro del proyecto (`.claude/agents/`) | Servidor VPS o hardware dedicado (`~/.openclaw/`) |
| **Ciclo de Ejecución** | Efímero: se activan por tarea y reportan al main agent | Persistente: escuchan 24/7 (Telegram, webhooks, cron) |
| **Orquestación** | El agente principal delega según keywords del prompt | El agente raíz ("Amigo" / "Trooper") distribuye a subagentes |
| **Modelos Asignados** | Selección por agente (Sonet recomendado para copy/SEO; Opus reservado a pocos casos) | Multi-LLM vía OpenRouter / OpenAI / DeepSeek |
| **Creación** | Comando interactivo `/agents` o archivos Markdown | Edición en `openclaw.json` y carpetas `agents/` |

---

## 2. Configuración de Agentes en Claude Code con `/agents`

Claude Code incluye un asistente interactivo para crear y afinar agentes:

1. **Invocación:** Ejecutar `/agents` en la consola para listar agentes disponibles o inicializar uno nuevo.
2. **Alcance (Scope):**
   - *Proyecto:* `.claude/agents/<nombre>.md` (aislado al repositorio).
   - *Personal / Global:* `~/.claude/agents/<nombre>.md` (disponible en todos los proyectos del sistema).
3. **Asignación económica de modelos:** Evitar dejar todos los agentes en `inherit` (Opus). Un subagente de SEO o copywriting opera a máxima velocidad y mínimo costo bajo **Sonet** o **Haiku**.
4. **Delegación automática:** No es necesario invocar al subagente manualmente con comandos; el agente orquestador analiza la semántica del mensaje del usuario y transfiere la tarea al especialista adecuado.

---

## 3. Inspección Remota de OpenClaw con Antigravity (Remote SSH)

Gestionar un agente en VPS mediante terminal cruda es propenso a errores. Usar Antigravity con Remote SSH permite edición visual completa:

1. **Habilitar Marketplace de Microsoft en Antigravity:** En `Settings`, configurar los endpoints de Visual Studio Gallery para instalar la extensión oficial `Remote - SSH`:
   - `serviceUrl: https://marketplace.visualstudio.com/_apis/public/gallery`
   - `itemUrl: https://marketplace.visualstudio.com/items`
2. **Conexión SSH:** Conectarse al usuario aislado del agente:
   ```bash
   ssh openclaw@<IP_DEL_VPS>
   ```
3. **Anatomía del Agente en `/home/openclaw/.openclaw/`:**
   - `openclaw.json`: Configuración del servidor, modelos y lista real de agentes.
   - `workspace/SOUL.md`: El "alma" del agente (tono, principios, toma de decisiones, manejo de errores).
   - `workspace/USER.md`: Contexto sobre el usuario, objetivos y preferencias.
   - **Auditoría de existencia:** Nunca asumir que un agente tiene subagentes solo porque lo afirma en el chat; verificar en `openclaw.json` o en Telegram con `/subagents`.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Crea un subagente especializado en Claude Code y audita su asignación:
1. Abre tu terminal en un proyecto y escribe:
   ```text
   /agents
   ```
2. Selecciona "Create new agent", asigna el alcance a nivel de proyecto y define un rol de `code-reviewer` con modelo `Sonet`.
3. Pide a Claude Code: "Revisa la seguridad y estándares de este componente". Verifica en el log que la tarea haya sido delegada al nuevo agente.

**Ejercicio 2 (avanzado):** Configura la extensión `Remote - SSH` en Antigravity, conéctate a tu VPS y edita visualmente el archivo `SOUL.md` de tu agente para definir una regla estricta de mitigación de alucinaciones.

---

## 💡 Tip

> **Auditoría real de subagentes en OpenClaw:** Si tu agente en Telegram asegura haber distribuido una tarea entre varios "subagentes", no des por sentada su existencia. Abre el archivo `openclaw.json` en tu VPS o envía el comando `/subagents` en Telegram para comprobar si los subagentes están verdaderamente instanciados o si el modelo simplemente simuló la delegación en su respuesta.

---

## ⚠️ Error común

> **Instalar múltiples servicios bajo el usuario del agente:** Ejecutar scripts ajenos (scrapers, bases de datos, APIs) en el mismo usuario Linux de OpenClaw (`/home/openclaw`) impide desinstalar o resetear el agente de forma limpia sin riesgo de borrar herramientas de producción. Crea siempre usuarios de sistema independientes para cada servicio.
