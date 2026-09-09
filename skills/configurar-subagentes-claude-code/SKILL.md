# SKILL: Configurar Subagentes Especializados en Claude Code

> Guarda este archivo en `/skills/configurar-subagentes-claude-code/SKILL.md`
> y referencíalo en tu CLAUDE.md para que Claude Code lo use.

---

## Cuándo usar este skill

Cuando un proyecto de desarrollo crezca en complejidad y requiera dividir responsabilidades entre roles especializados (arquitectura, frontend, auditoría de seguridad, tests) mediante subagentes en `.claude/agents/`, o cuando se necesite optimizar costos asignando modelos más económicos (`sonet`, `haiku`) a tareas específicas.

---

## Prerequisitos

- [ ] Claude Code CLI o extensión IDE activa
- [ ] Proyecto inicializado con estructura de directorio `.claude/`
- [ ] Definición clara de roles, herramientas requeridas y restricciones de seguridad por agente

---

## Pasos

### Paso 1 — Crear el directorio de agentes locales

Crea la carpeta de agentes dentro del entorno de configuración del proyecto:

```bash
mkdir -p .claude/agents
```

### Paso 2 — Definir el archivo del subagente con Frontmatter YAML

Cada subagente reside en un archivo Markdown independiente (`.claude/agents/<nombre-agente>.md`). El frontmatter superior determina su comportamiento:

```markdown
---
name: [nombre-unico-en-minusculas]
description: [Descripción precisa de cuándo y para qué debe invocarse este agente]
tools: [read, write, bash, grep, glob]
model: [inherit | opus | sonet | haiku]
---

# Rol y Directivas de [Nombre]

Eres el especialista en [área]. Tu responsabilidad exclusiva es [misión].

## Reglas de Ejecución:
1. [Regla 1: ej. No modificar archivos fuera de /src/components]
2. [Regla 2: ej. Siempre validar tipos con tsc antes de reportar tarea concluida]
```

### Paso 3 — Configurar la asignación o herencia de modelos

Optimiza el presupuesto y la velocidad configurando el campo `model`:

- `model: inherit` (o ausente): El subagente hereda el modelo activo de la sesión padre (ej. si usas Opus en el chat principal, el agente ejecutará con Opus).
- `model: sonet`: Ideal para implementación de código estándar, creación de componentes y pruebas unitarias.
- `model: haiku`: Ideal para tareas rápidas de solo lectura, formateo, verificación de enlaces o búsquedas de texto.

### Paso 4 — Vincular los subagentes en el CLAUDE.md maestro

Para evitar que `CLAUDE.md` crezca por encima de 250 líneas, no copies los prompts de los agentes allí. Añade únicamente una tabla de delegación:

```markdown
## Subagentes Disponibles
- `@director`: Coordina la arquitectura global y desglosa tareas complejas.
- `@frontend-dev`: Implementa vistas y componentes respetando el Design System.
- `@auditor`: Revisa seguridad, secretos y permisos en modo solo lectura.
```

### Paso 5 — Invocar y verificar la ejecución delegada

Pide a Claude Code que delegue una tarea al subagente correspondiente:

```bash
claude -p "Delega a @auditor la revisión de las rutas de autenticación en busca de variables expuestas o errores de CORS."
```

---

## Outputs esperados

Al terminar este skill, el resultado debe ser:
- Directorio `.claude/agents/` poblado con archivos de agentes modulares y bien delimitados.
- Subagentes con permisos de herramientas estrictos (`tools`) y modelos asignados conscientemente.
- `CLAUDE.md` limpio y conciso (< 250 líneas) con referencias ejecutivas a los agentes disponibles.

---

## Errores comunes

| Error | Causa probable | Solución |
| :--- | :--- | :--- |
| **Gasto excesivo en subagentes** | `model` omitido mientras la sesión padre usa Opus en modo extendido | Define explícitamente `model: sonet` o `model: haiku` en los subagentes operativos. |
| **Subagente modifica archivos indebidos** | Permiso `tools: write, bash` concedido a agentes de solo auditoría | Restringe las herramientas a `read, grep, glob` en el frontmatter del agente. |
| **CLAUDE.md supera las 250 líneas** | Se duplicó la descripción completa de los agentes dentro del archivo principal | Mantén las instrucciones dentro de `.claude/agents/<agente>.md` y deja solo una línea de índice en `CLAUDE.md`. |
| **El subagente no se activa** | Nombre de archivo o campo `name` con mayúsculas o caracteres inválidos | Usa nombres en minúsculas separados por guiones (ej. `code-reviewer.md`). |

---

## Variaciones

**Variación A — Subagentes a nivel usuario (`~/.claude/agents/`):**
Aloja agentes de propósito universal (ej. un auditor de seguridad o un generador de tests) en tu directorio global de usuario para que estén disponibles en cualquier repositorio sin reconfigurarlos.

**Variación B — Subagente orquestador tipo Director:**
Configura un agente principal (`director.md`) cuya única función sea descomponer el requerimiento en un checklist y disparar subagentes especializados en paralelo.
