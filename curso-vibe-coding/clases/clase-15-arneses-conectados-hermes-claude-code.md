# Clase 15 — Arneses Conectados: Hermes + Claude Code en Vivo

**Tags:** `HarnessEngineering` `Hermes` `AgentsSDK` `ACP`
**Conecta con:** [Clase 02](clase-02-tunear-claude-code.md) · [Clase 14](clase-14-tu-agente-programa-solo-duermes.md)

---

## Idea central

Un modelo de lenguaje (LLM) es solo un cerebro en un frasco; el arnés (*harness*) es la infraestructura (bash, file system, sandbox, bucle agéntico, MCPs y memoria en markdown) que le da manos para operar en el mundo real. Comprender Claude Code como un arnés desacoplado del modelo permite intercambiar motores (Opus, DeepSeek, Qwen) para reducir costos, incrustar el agente en aplicaciones web mediante el Agents SDK y conectar agentes autónomos entre sí (como Hermes orquestando Claude Code desde Discord o Telegram).

---

## Anatomía de un arnés: las 5 piezas clave

Todo arnés agéntico moderno (Claude Code, Open Code, Hermes) se compone de 5 piezas fundamentales:

| Componente | Función en el arnés | Caso de uso práctico |
|------------|---------------------|----------------------|
| **Bash Tool** | Ejecutar comandos en terminal del sistema | Correr linters, tests, builds, git |
| **File System** | Lectura, escritura y búsqueda en el workspace | Inspección con glob/grep y edición de código |
| **Sandbox + Permisos** | Aislamiento y control de compuertas | Auto Mode, bypass permissions o confirmación |
| **Agent Loop** | Ciclo continuo: Gather Context → Act → Verify | Reintentos automáticos hasta resolver la tarea |
| **Skills & MCPs** | Capacidades y herramientas extensibles | Conexión con Supabase, Notion, Playwright |

> **Principio de persistencia:** La memoria crítica del proyecto (PRD, blueprints, arquitectura) debe vivir en archivos Markdown dentro del arnés, nunca en la memoria efímera del LLM.

---

## Comunicación entre arneses: Hermes + Claude Code

Para comandar Claude Code desde el celular vía Discord o Telegram mediante un agente orquestador (Hermes):

```
[Usuario en Discord/Telegram]
              │
              ▼
    [Orquestador Hermes]
              │
    ┌─────────┴──────────┐
    │ Modalidades CLI    │
    ▼                    ▼
[Print Mode]          [Tmux / PTY]
claude -p "..."       Sesión interactiva
(Robusto, headless)   (Tiempo real, prompts)
              │
              ▼
   [Claude Code en Mac Mini/VPS]
```

- **Print Mode (`claude -p "[prompt]"`):** Modo headless no interactivo. Hermes ejecuta el comando bash, captura el JSON/texto de salida y lo devuelve al chat.
- **Tmux / Terminal interactiva:** Envuelve Claude Code en un multiplexor para que el orquestador responda preguntas o confirme acciones interactivas.
- **ACP (Agent Client Protocol):** Estándar abierto emergente (Zed) para interconectar agentes de forma nativa (análogo a MCP, pero de agente a agente).

---

## Claude Agents SDK: El arnés en aplicaciones web

El Agents SDK permite invocar Claude Code programáticamente como subproceso desde cualquier backend Node/TypeScript, sin que viva únicamente en tu terminal. Expone principalmente:
- **Queries:** el prompt que le mandas al arnés, igual que escribirías en el chat de Claude Code.
- **Options (Claude Code options):** configuración de qué herramientas puede o no ejecutar (solo lectura vs. lectura+escritura) y cuántos turnos del agent loop puede consumir antes de detenerse.
- **MCPs conectados:** Jira, Slack, Supabase, etc., igual que en la terminal.

`[PENDIENTE: confirmar sintaxis exacta del paquete/import — la sesión mostró la demo en vivo sobre el proyecto Núcleo pero no proyectó el código fuente]`

Esto habilita dashboards web y bots internos que aprovechan todo el `CLAUDE.md`, las skills y los MCPs del proyecto sin abrir una terminal manual.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Ejecutar Claude Code en modo headless no interactivo (Print Mode). Desde tu terminal, corre:
```bash
claude -p "Revisa el archivo README.md y lista en 3 viñetas qué mejoras de documentación se pueden hacer sin tocar ningún archivo."
```
Verifica que la salida se imprima directamente en la consola sin abrir la interfaz interactiva. Este es el comando exacto que ejecutan orquestadores como Hermes desde Discord o Telegram para automatizar tareas remotas.

**Ejercicio 2 (avanzado):** Investiga cómo configurar un proxy de arnés (Open Code o similar) para que Claude Code enrute sus peticiones hacia un modelo alternativo de bajo costo (DeepSeek V4 Pro, GLM, Kimi) en vez de a Anthropic. Verifica que tus skills, tu `CLAUDE.md` y tu configuración del arnés sigan funcionando exactamente igual — solo cambió el motor, no la carrocería.

---

## 💡 Tip

Si tu presupuesto de tokens en Anthropic es ajustado, utiliza proxies de arnés (como Open Code o Deep Cloud) para enrutar las peticiones de Claude Code hacia modelos alternativos de bajo costo (como DeepSeek V4 Pro o GLM) manteniendo tu misma interfaz de terminal, tus `CLAUDE.md` y tus skills intactos.

---

## ⚠️ Error común

Creer que estás limitado a usar únicamente el modelo con el que viene tu arnés por defecto (Opus/Sonnet en Claude Code). Si Anthropic sube precios, reduce límites de consumo o quita Claude Code de un plan, el que no desacopló su arnés del modelo se queda bloqueado: su negocio depende de un proveedor que no controla. El arnés y el modelo son piezas independientes — cambia el motor, no la carrocería.
