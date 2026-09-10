# Clase 25 — Antigravity, Claude Code y OpenClaw

**Tags:** `Vibe Coding` `Antigravity` `Claude Code` `OpenClaw`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 17](clase-17-hermes-vs-openclaw-skills.md) · [Clase 24](clase-24-claude-code-vs-openclaw-agentes.md)

---

## Idea central

El Vibe Coding reemplaza la escritura manual de código por la orquestación en lenguaje natural, guiando al agente mediante logs y capturas sin abrir archivos para declarar variables. Para escalar este flujo sin fricciones, la arquitectura combina Antigravity como entorno visual de desarrollo, Claude Code como motor de codificación y OpenClaw como agente autónomo 24/7 en VPS, sincronizando el contexto del proyecto a través de documentación viva en lugar de confiar en la memoria volátil de la sesión.

---

## 1. El Ecosistema Vibe Coding: Roles y Especialización

Cada herramienta cumple una función específica dentro del flujo de desarrollo asistido:

| Herramienta | Naturaleza | Función Principal | Modelo / Cerebro |
| :--- | :--- | :--- | :--- |
| **Antigravity** | Fork de VS Code (Google) | IDE visual, lectura de árbol de archivos y orquestación multi-extensión | Gemini (nativo gratuito) + Claude / Codex vía extensiones |
| **Claude Code** | Agente CLI / Extensión | Generación de código, refactorización y resolución de errores mediante terminal | Familia Claude (Opus / Sonnet / Haiku) |
| **Kilo** | Extensión para IDE | Auditoría externa y segunda opinión técnica en modo lectura | Codex / GPT 5.3 (OpenAI) |
| **OpenClaw** | Agente autónomo en VPS | Automatizaciones persistentes 24/7, bots de mensajería y flujos desatendidos | Multi-LLM (Minimax M2.5, Blockrun, Grok, Opus) |

---

## 2. Auditoría Multi-Modelo sin Conflictos en Antigravity

Antigravity permite cohabitar múltiples motores de inteligencia artificial dentro de un mismo espacio de trabajo:

1. **Un solo escritor activo:** Nunca ejecutes dos agentes con permisos de escritura al mismo tiempo en el mismo repositorio; generarán condiciones de carrera y sobrescribirán el código mutuamente.
2. **Triangulación de auditoría:**
   - Asigna a Claude Code la creación y modificación del código.
   - Abre la extensión Kilo (Codex) con la instrucción explícita: *"Revisa lo que hizo Claude Code y dame tu opinión técnica, pero no modifiques ningún archivo."*
   - Consulta a Gemini 3.1 para obtener un desempate arquitectónico sobre la recomendación de Codex.
3. **Aislamiento de contexto:** Recuerda que Antigravity lee el sistema de archivos del proyecto, pero no tiene acceso al historial de conversación que tuviste en el chat de Claude Code; para que otro modelo audite una propuesta, pídele a Claude Code que guarde su plan en un archivo Markdown.

---

## 3. Visibilidad de Skills y Persistencia entre Máquinas

Para evitar perder contexto o corromper configuraciones al operar con agentes y skills:

- **Alcance de Skills (Scope):** Si creas una skill con Claude Code y se almacena en su ruta de usuario (`~/.claude/skills/`), Antigravity no la reconocerá. Ubica las skills en la raíz del proyecto para que todos los modelos del IDE las lean.
- **Creación y Versionado de Skills:** Utiliza `skill creator` alimentándolo con investigaciones de Perplexity o documentación externa en Markdown. Guarda borradores iterativos (`skill_v1.md`, `skill_v2.md`) y renombra únicamente la versión final estable a `SKILL.md` para evitar regresiones.
- **Higiene del Prompt Cache:** Mantener cientos de skills activas degrada el caché y encarece la sesión. Mantén un máximo recomendado de 70 a 80 skills habilitadas simultáneamente; apaga las innecesarias en lugar de borrarlas.
- **Cambio seguro de modelos en OpenClaw:** Nunca pidas al agente de OpenClaw por chat que edite su archivo JSON de configuración para cambiar de modelo, ya que un error de sintaxis romperá el bot. Utiliza el comando interactivo `/models` en Telegram para alternar entre Minimax, Grok u Opus de forma segura.
- **Continuidad multidispositivo:** Las sesiones de consola se compactan y olvidan contexto. Mantén archivos `CLAUDE.md`, `plan.md` y `tasks.md` en el repositorio para que cualquier máquina o sesión nueva retome el proyecto exactamente donde quedó. Alternativa directa: activa el modo remoto (Remote Control) desde tu Claude Code de escritorio para continuar la misma sesión desde el celular sin cambiar de equipo.

---

## 🎯 Ejercicio práctico

Configurar un entorno de auditoría cruzada en Antigravity y documentar el aprendizaje del agente para garantizar continuidad entre sesiones.

**Ejercicio 1:** Abre un proyecto en Antigravity con la extensión de Claude Code y un segundo modelo (Gemini o Kilo). Pide a Claude Code que implemente una función y genere un archivo `docs/review.md` con su propuesta. Luego, solicita al segundo modelo que audite dicho archivo bajo la regla de no modificar el código. Finalmente, pide a Claude Code que incorpore las correcciones válidas y registre la regla aprendida en el `CLAUDE.md` del repositorio.

**Ejercicio 2 (avanzado, opcional):** Conéctate vía Telegram a tu bot de OpenClaw y utiliza el comando `/models` para cambiar el modelo activo de forma interactiva, verificando que la respuesta se aplique sin alterar manualmente el archivo de configuración del servidor.

---

## 💡 Tip

Cuando enseñes a tu agente a solucionar un bug recurrente o un patrón de diseño propio, indícale: *"Agrega esta regla al final de CLAUDE.md para que no vuelvas a cometer este error en futuras sesiones"*. Así la memoria del proyecto persiste entre diferentes computadoras sin depender del historial del chat.

---

## ⚠️ Error común

Pedirle al agente de OpenClaw vía chat libre que modifique su propio modelo o credenciales en el archivo de configuración. Si el agente comete un error de puntuación (una coma o comilla faltante en el JSON), el proceso fallará por completo y el bot dejará de responder, obligándote a ingresar manualmente al servidor por SSH para reparar el archivo.
