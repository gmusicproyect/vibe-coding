# Clase 03 — Cómo dejar de empezar de cero cada mañana

**Tags:** `Obsidian` `LLM Wiki` `Memoria` `Grafos`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 02](clase-02-tunear-claude-code.md)

---

## Idea central

Un agente sin memoria externa pierde todo el contexto al cerrar la sesión. Implementar un segundo cerebro basado en la arquitectura LLM Wiki (Andrej Karpathy) con Obsidian permite organizar la información en tres capas: caja de entrada cruda, expediente estructurado con enlaces e instrucciones de navegación. Automatizar la ingesta y desambiguar entidades convierte a la IA en un socio que recuerda acuerdos, detecta contradicciones y descubre oportunidades ocultas entre proyectos.

---

## La arquitectura de los 3 cajones (Karpathy)

| Capa | Directorio | Contenido y regla | Función para el agente |
|------|------------|-------------------|------------------------|
| **Caja de entrada** | `raw/` | Transcripciones de audio, notas sueltas, chats. **Regla de oro: nunca se edita ni se borra.** | Fuente de verdad inmutable para auditar o verificar el original. |
| **Expediente** | `wiki/` | Archivos Markdown limpios por cliente, proyecto y persona, conectados con `[[wikilinks]]`. | Es lo único que el agente lee y actualiza en cada sesión. |
| **Instrucciones** | `CLAUDE.md` + `index.md` | Contrato de operaciones (`INGEST`, `QUERY`, `LINT`, `CLEAN`) y mapa inicial de entidades. | Punto de entrada que el agente consulta primero antes de cualquier tarea. |

---

## Desambiguación con archivo de entidades (`entidades.md`)

Para evitar que el agente cree notas duplicadas cuando una misma persona aparece nombrada de formas distintas (ej. *"Renata"*, *"Rena"*, *"Renata Quintal"*, *"Zoom con Renata"*), se mantiene un archivo `entidades.md`. Este documento registra el nombre canónico y una lista de apodos y relaciones contextuales (cliente, empresa, rol). El agente valida las menciones contra este archivo antes de crear una hoja nueva.

---

## Ingesta automatizada: Daily Harvest

En lugar de procesar notas manualmente o gastar tokens innecesarios, un script local (`daily_harvest.sh`) automatiza el flujo nocturno:

1. **Transcripción local a costo \$0:** Procesa grabaciones de reuniones con Whisper (o MLX Whisper en Apple Silicon) sin usar APIs de pago.
2. **Extracción de sesiones de Claude Code:** Lee los archivos `.jsonl` del día (historial crudo de la terminal), extrayendo decisiones, tareas y compromisos.
3. **Indexación relacional:** Inserta los hallazgos en las páginas correspondientes de `wiki/` y actualiza el diario del día.

---

## Expediente vs. Mapa de Grafos

- **Expediente (`wiki/`):** Preciso y determinista. Sabe exactamente qué se prometió, a quién y cuándo en base a lo ya clasificado.
- **Mapa de grafos (Graphify / visualizador):** Analiza transversalmente todo el material (incluyendo notas huérfanas en `raw/`). Al cruzar menciones, permite descubrir patrones no evidentes (por ejemplo, tres clientes de giros distintos que mencionan el mismo dolor operativo, revelando una oportunidad de nuevo producto).

---

## Las cuatro operaciones del LLM Wiki

| Operación | Objetivo | Acción del agente |
|-----------|----------|-------------------|
| **INGEST** | Procesar fuentes de `raw/` | Extrae conceptos, actualiza entidades y crea `[[wikilinks]]`. |
| **QUERY** | Consultar el segundo cerebro | Lee primero `index.md` y navega conexiones sin quemar tokens. |
| **LINT** | Auditar salud del grafo | Detecta enlaces rotos, páginas huérfanas y notas sin mover en 90 días. |
| **CLEAN** | Resolver contradicciones | Fusiona duplicados y archiva información obsoleta con confirmación humana. |

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Crea la estructura base de un segundo cerebro en una carpeta (`raw/`, `wiki/`, `index.md`, `CLAUDE.md` y `entidades.md`). Escribe en `raw/reunion-01.txt` las notas de una reunión ficticia y pídele a tu agente que ejecute la operación `INGEST`: debe crear la nota en `wiki/` con al menos dos enlaces `[[...]]` y registrar los nombres y apodos en `entidades.md`.

**Ejercicio 2 (avanzado):** Agrega un script o prompt de `LINT` que analice la carpeta `wiki/` y reporte si existen notas huérfanas (sin enlaces entrantes ni salientes) o enlaces rotos.

---

## 💡 Tip

Mantén las notas del expediente cortas y modulares (idealmente menos de 200-250 líneas por archivo Markdown). Si una nota se hace demasiado extensa, el modelo comenzará a leerla por fragmentos o degradará su atención; es mejor dividirla en subtópicos y conectarla mediante `[[wikilinks]]`.

---

## ⚠️ Error común

Permitir que el agente escriba o modifique archivos dentro de la carpeta `raw/`. La caja de entrada debe ser de solo lectura para la IA; si el agente sobrescribe las fuentes crudas, se pierde la trazabilidad del original cuando surjan contradicciones o alucinaciones.
