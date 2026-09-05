# Instrucciones para agentes que trabajan en este repo

> Equivalente a `CLAUDE.md` para cualquier agente que no sea Claude Code (Antigravity/Google incluido).
> Si tu agente lee automáticamente un archivo de instrucciones raíz, esto se carga solo.

---

## Qué es este repo

`vibe-coding` es la base de conocimiento del curso Vibe Coding de Imperio Digital: clases y skills reutilizables. Mismo criterio de calidad que su repo hermano [imperioagentico](https://github.com/gmusicproyect/imperioagentico) (curso Claude Code).

---

## Instrucción por defecto para transcripciones nuevas

Cuando recibas una transcripción cruda para integrarla a este repo:

**Aplica siempre `skills/procesar-transcripcion/SKILL.md`.**

Ese skill contiene la estructura de clase a seguir, qué índice actualizar, y el protocolo de entrega: no hagas commit ni push, y no repegues el contenido completo de los archivos en tu respuesta — reportale a Claude en 1-2 líneas por archivo qué creaste o modificaste, verificado contra `git status`, sin excepciones.

---

## Quién aprueba

Claude revisa cada entrega con `git diff` antes de que algo se suba a GitHub. Tu trabajo termina en dejar los archivos correctos en el working tree.

---

## Regla de autonomía total (Cero preguntas intermedias)

- **Nunca preguntes si debes aplicar los cambios al proyecto, si creas un skill o si procedes.**
- Si recibes una transcripción, instrucción o tarea, **aplica directamente todos los cambios y creaciones en los archivos correspondientes**.
- Trabaja de principio a fin de forma completamente autónoma y entrega de una sola vez el reporte verificado contra `git status`.
