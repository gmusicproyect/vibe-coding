# Clase 17 — Hermes vs OpenClaw + Skills en Claude Code

**Tags:** `Agentes 24/7` `Hermes` `OpenClaw` `Skills`
**Conecta con:** Clase 02 · Clase 09 · Clase 15

---

## Idea central

La orquestación agéntica moderna se divide entre agentes autónomos 24/7 (Hermes y OpenClaw) y motores especializados de programación (Claude Code). Mientras Hermes supera a OpenClaw en velocidad inicial, memoria persistente con automejora y permisos interactivos, el éxito del sistema radica en gobernar los skills dividiéndolos estrictamente entre usuario y proyecto para evitar que el prompt caching devore la ventana de contexto.

---

## 1. Comparativa: Hermes vs. OpenClaw

| Dimensión | OpenClaw | Hermes (Nous Research) |
| :--- | :--- | :--- |
| **Origen y base** | Peter Steinberger (Codex 5.3) | Evolución con plugins de memoria dedicados |
| **Sistema de memoria** | No nativa por defecto; requiere configuración manual | Persistente nativa y automejora continua de skills |
| **Ejecución y permisos** | Edición manual de archivos JSON de configuración | Alertas interactivas en chat (aceptar, siempre, rechazar) |
| **Interfaz y control** | Mission Control propio o desarrollado desde cero | Dashboard visual dedicado y aplicación nativa de escritorio |
| **Stack de modelos** | MiniMax M2.7 (~$20/mes) | DeepSeek V4 Pro vía OpenCode ($10/mes plan Go) |

---

## 2. Arquitectura de Skills e Higiene de Contexto

Instalar decenas de skills de forma indiscriminada satura el prompt caching y agota los tokens de sesión en pocas consultas. La estrategia profesional exige segmentar su alcance:

- **Nivel Usuario (`~/.claude/skills/`):** Habilidades transversales presentes en todos los proyectos de tu máquina (ej. `agentation`, `find-skills`).
- **Nivel Proyecto (`.claude/skills/`):** Instrucciones específicas del dominio (ej. `add-login`, `add-payments`, `add-mobile-stack` del proyecto ATS de Carlos), activas únicamente al operar dentro de ese directorio.
- **Catálogo bajo demanda:** Mantener un índice de referencia externo (Markdown o NotebookLM) e importar a `.claude/skills/` solo los archivos requeridos para el sprint actual.
- **Desactivación de MCPs:** Desactivar herramientas MCP no utilizadas desde la configuración en vez de borrarlas, eliminándolas del conteo de input tokens.

---

## 3. Infraestructura Local y Troubleshooting desde Raíz

Para correr agentes en un servidor local (Mac Mini o PC con Ubuntu):
1. **Configuración eléctrica:** Habilitar arranque automático tras corte eléctrico en ajustes de energía (o Wake-on-LAN en PC).
2. **Red privada:** Conectar vía Tailscale y configurar el gateway en modo `bind: "loopback"` (`127.0.0.1:18789`) para que solo responda a la red segura.
3. **Depuración directa con Claude Code:** Abrir Claude Code situándote en la raíz del agente (`~/.hermes` o `~/.openclaw`):
   ```bash
   cd ~/.hermes && claude -p "Revisa hermes.json y los logs para identificar por qué el gateway falló al reiniciar tras instalar el skill."
   ```

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Audita tus skills actuales y separa un skill global de uno de proyecto:
1. Abre tu terminal y revisa tu directorio de usuario:
   ```bash
   ls -la ~/.claude/skills/
   ```
2. Mueve un skill específico de un cliente o funcionalidad hacia el directorio local de ese proyecto:
   ```bash
   mkdir -p ./proyecto/.claude/skills/
   mv ~/.claude/skills/skill-especifico.md ./proyecto/.claude/skills/SKILL.md
   ```
3. Inicia Claude Code en el proyecto y valida que el skill local sea visible sin contaminar el resto de tus proyectos.

**Ejercicio 2 (avanzado):** Configura un archivo `catalogo-skills.md` con descripciones de tus skills de reserva y pídele a Claude Code que consulte ese catálogo e instale en `.claude/skills/` solo el skill pertinente para la tarea que le indiques.

---

## 💡 Tip

> **Conecta tus agentes 24/7 a Claude Code vía MCP local:** No intentes que Hermes u OpenClaw programen aplicaciones complejas. Configura un servidor MCP local en tu máquina para que Hermes invoque agentes especializados en Claude Code CLI cuando requiera escribir o auditar código de producción.

---

## ⚠️ Error común

> **Instalar cientos de skills y MCPs activos permanentemente:** Creer que más skills equivalen a un agente más inteligente es el camino más rápido para agotar los límites semanales. Claude Code lee las cabeceras de todos los skills disponibles al iniciar sesión; si el catálogo es gigante, el prompt caching consumirá decenas de miles de tokens en cada turno conversacional.
