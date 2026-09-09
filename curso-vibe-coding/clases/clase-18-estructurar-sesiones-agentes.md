# Clase 18 — Cómo estructurar sesiones y agentes en Claude Code

**Tags:** `Sesiones` `Subagentes` `CLAUDE.md` `CLI`
**Conecta con:** Clase 02 · Clase 09 · Clase 17

---

## Idea central

El rendimiento en Claude Code depende de la disciplina de sesión: agrupar el trabajo en sprints continuos para aprovechar la ventana de 5 minutos del prompt cache, modularizar `CLAUDE.md` por debajo de 250 líneas delegando responsabilidades a subagentes en `.claude/agents/`, y alternar estratégicamente entre Opus para la planificación y Sonet para la ejecución técnica.

---

## 1. Ciclo de Vida de una Sesión: Sprints y Comandos CLI

El contexto no debe acumularse indefinidamente. Cada sesión responde a una necesidad puntual:

| Escenario | Decisión de sesión | Mecanismo técnico |
| :--- | :--- | :--- |
| **Misma feature en desarrollo** | Mantener sesión activa | Responder en < 5 min para reutilizar prompt cache |
| **Feature relacionada / siguiente sprint** | Cerrar y transferir contexto | Generar `handoff.md` y abrir sesión nueva con `@handoff.md` |
| **Feature no planificada / nueva idea** | Nueva sesión en modo Plan | Opus diseña el plan; al aprobar, Sonet ejecuta el código |
| **Reanudar terminal cerrada** | Continuar última sesión | Comando CLI `claude --continue` |
| **Recuperar sesión específica** | Reanudar por identificador | Comando CLI `claude --resume <session-id>` |
| **Control remoto móvil** | Continuar desde navegador/app | Flag CLI `claude --remote-control` |

---

## 2. Jerarquía Documental: Cascada Anti-Alucinación

Para evitar que el agente pierda el rumbo entre requerimientos contradictorios:

1. **Blueprint (`blueprint.md`):** La Biblia inmutable del proyecto. Define alcance, arquitectura y criterios de éxito.
2. **Roadmap (`roadmap.md`):** Hitos y fases generales del desarrollo.
3. **Plan (`plan.md`):** Desglose táctico de la fase activa actual.
4. **Tasks (`task.md`):** Lista viva de tareas atómicas con checkboxes que el agente marca al completar.

> **Regla de Sincronización:** El Blueprint siempre manda. Si existe desfase entre el Blueprint, el Plan y las Tasks, el agente empezará a alucinar al no tener claras las prioridades.

---

## 3. Modularización de CLAUDE.md y Subagentes

Un archivo `CLAUDE.md` que supera las 200–250 líneas satura el contexto y degrada el razonamiento. Para mantenerlo limpio:

- **Extraer sprints e histórico:** Mover listas de sprints cerrados hacia un archivo dedicado `sprints.md`.
- **Configurar subagentes en `.claude/agents/`:** Cada agente es un archivo Markdown (`director.md`, `frontend.md`) con frontmatter YAML:
  ```markdown
  ---
  name: director
  description: Orquesta la arquitectura y delega tareas a subagentes
  tools: read, write, bash
  model: inherit
  ---
  ```
  Si no se define `model`, el subagente hereda el modelo de la sesión padre. Si se asigna `sonet` o `haiku`, ejecutará su tarea con ese modelo específico reduciendo costos.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Modulariza un `CLAUDE.md` extenso y crea tu primer subagente especializado:
1. Revisa tu `CLAUDE.md`. Si supera las 250 líneas, extrae el registro de sprints o tareas hacia `sprints.md` e incluye únicamente una referencia de lectura en `CLAUDE.md`.
2. Crea el directorio de agentes locales:
   ```bash
   mkdir -p .claude/agents
   ```
3. Define un subagente de auditoría en `.claude/agents/auditor.md`:
   ```markdown
   ---
   name: auditor
   description: Audita seguridad y consistencia de código sin escribir cambios
   tools: read, grep, glob
   model: sonet
   ---
   Eres un auditor estricto. Revisa vulnerabilidades y secretos expuestos. Reporta hallazgos sin modificar archivos.
   ```
4. Abre Claude Code e invoca al subagente para auditar tu repositorio.

---

## 💡 Tip

> **Estrategia Opus Plan → Sonet Build:** Cuando encares una funcionalidad compleja no documentada en tu Blueprint, inicia en modo plan con Opus (`/model opus`). Deja que Opus razone la arquitectura y las pruebas. En cuanto apruebes el plan, pasa a Sonet para escribir el código con máxima velocidad y una fracción del costo.

---

## ⚠️ Error común

> **Convertir CLAUDE.md en un vertedero de contexto:** Meter cientos de líneas de histórico, logs y documentación de APIs directamente en `CLAUDE.md` obliga a Claude a re-procesar todo ese volumen en cada petición. Mantén `CLAUDE.md` estrictamente como un índice ejecutivo de menos de 250 líneas que apunte a archivos externos.
