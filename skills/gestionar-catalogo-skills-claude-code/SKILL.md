# SKILL: Gestionar Catálogo de Skills y Contexto en Claude Code

> Guarda este archivo en `/skills/gestionar-catalogo-skills-claude-code/SKILL.md`
> y referencíalo en tu CLAUDE.md para que Claude Code lo use.

---

## Cuándo usar este skill

Cuando se requiera organizar, auditar o escalar un catálogo amplio de skills y servidores MCP en Claude Code sin agotar la ventana de contexto ni disparar el consumo de tokens por lectura innecesaria en el prompt caching (`cache prompting`).

---

## Prerequisitos

- [ ] Claude Code CLI instalado y configurado en el sistema
- [ ] Comprensión de los alcances de configuración (directorio global `~/.claude/` y local `.claude/`)
- [ ] Archivo `CLAUDE.md` configurado en el proyecto activo
- [ ] Catálogo o repositorio local/remoto donde residen las definiciones de skills

---

## Pasos

### Paso 1 — Clasificar el alcance del skill (Usuario vs. Proyecto)

Determina el nivel de visibilidad antes de instalar cualquier archivo:

1. **A nivel Usuario (`~/.claude/skills/`):** Reserva este directorio únicamente para utilidades transversales que utilizas en cualquier proyecto tecnológico (ej. `agentation`, `find-skills`, `revisar-datos-personales`).
2. **A nivel Proyecto (`.claude/skills/`):** Aloja aquí los skills con reglas, terminología o dependencias propias de ese cliente, negocio o stack específico (ej. `ghl-snapshot`, `ats-workflow`, `tailwind-tokens`).

### Paso 2 — Construir un índice centralizado fuera del contexto activo

En lugar de copiar 50 o 100 skills en tu entorno de trabajo, crea un archivo de índice liviano (ej. `recursos/catalogo-skills.md` o en NotebookLM) con una tabla de referencia:

```markdown
# Catálogo Maestro de Skills

| Skill | Categoría | Trigger / Cuándo usar | Ubicación fuente |
| :--- | :--- | :--- | :--- |
| `analisis-financiero` | Finanzas | Auditoría de statements bancarios y métricas | `~/repo-skills/finanzas/SKILL.md` |
| `landing-page-nextjs` | Frontend | Creación de landing pages con Next.js | `~/repo-skills/frontend/SKILL.md` |
| `ghl-snapshot` | Marketing | Configuración de cuentas y subcuentas GHL | `~/repo-skills/marketing/SKILL.md` |
```

### Paso 3 — Instalar skills bajo demanda para el sprint

Cuando inicies una tarea específica, pide a Claude Code que consulte el índice e instale solo el skill requerido:

```bash
claude -p "Consulta recursos/catalogo-skills.md. Para la tarea de crear una landing page, copia únicamente el skill correspondiente dentro de .claude/skills/."
```

### Paso 4 — Auditar y desactivar MCPs inactivos sin eliminarlos

Tener múltiples MCPs conectados incrementa el volumen de tokens de entrada (`input tokens`) en cada petición:

1. Abre la configuración de Claude Code en tu proyecto o usuario.
2. Desactiva los interruptores de los servidores MCP que no apliquen a la sesión actual (ej. desconectar el MCP de base de datos relacional si solo estás retocando CSS).
3. Mantén la configuración persistente en el archivo JSON sin necesidad de volver a ingresar credenciales en el futuro.

### Paso 5 — Personalizar skills genéricos a tu estilo de trabajo

Nunca utilices un skill descargado sin adaptarlo a tus reglas:
1. Pídele a Claude Code que analice el skill:
   ```bash
   claude -p "Analiza .claude/skills/mi-skill/SKILL.md y explícame qué hace y qué supuestos asume."
   ```
2. Adapta los pasos a tus convenciones de nombres, estructura de carpetas y comandos habituales.

---

## Outputs esperados

Al terminar este skill, el resultado debe ser:
- Directorio de usuario (`~/.claude/skills/`) depurado con menos de 5-10 herramientas universales.
- Directorio de proyecto (`.claude/skills/`) con únicamente los skills necesarios para los requerimientos en curso.
- Reducción drástica del tamaño de tokens consumidos por sesión en el prompt cache.
- Servidores MCP inactivos apagados sin pérdida de configuración.

---

## Errores comunes

| Error | Causa probable | Solución |
| :--- | :--- | :--- |
| **Agotamiento prematuro de límites** | Decenas de skills instalados a nivel usuario | Mueve los skills especializados a carpetas de proyectos específicos o al catálogo de reserva. |
| **Conflicto de invocación entre skills** | Dos skills tienen descripciones o triggers casi idénticos | Renombra los comandos o aclara el contexto específico en la descripción YAML de cada uno. |
| **Pérdida de configuración de MCPs** | Borrar MCPs para ahorrar tokens | Desactívalos desde la configuración en vez de eliminarlos de `claude.json`. |
| **Skill no detectado por Claude Code** | Nombre de archivo incorrecto | Asegúrate de que el archivo se llame exactamente `SKILL.md` en mayúsculas dentro de su subcarpeta. |

---

## Variaciones

**Variación A — Búsqueda automatizada con skill `find-skills`:**
Utiliza un buscador semántico o el skill `find-skills` para rastrear repositorios públicos o comunitarios e instalar solo el archivo Markdown necesario.

**Variación B — Documentación viva con sincronización Markdown-HTML:**
Para equipos que comparten guías operativas, mantén un hook que sincronice automáticamente el archivo `SKILL.md` con un visor HTML interactivo con live preview.
