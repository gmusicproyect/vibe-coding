# Schema reference — `dashboard-data.json`

Spec campo por campo. El dashboard ignora claves desconocidas (puedes dejar `_meta`).

## Top-level

| Clave | Tipo | Requerido | Notas |
|-------|------|-----------|-------|
| `_meta` | string | opcional | Nota libre para humanos. El HTML la ignora. |
| `project` | object | **sí** | Metadatos del proyecto (cabecera). |
| `tools` | object | opcional | Registro de herramientas → color + icono (para chips). |
| `statusLabels` | object | **sí** (fijo) | Esquema de estados. **No modificar.** |
| `blockers` | array | **sí** (puede ir `[]`) | Bloqueadores con dueño y tareas afectadas. |
| `fundamentals` | object | opcional | Trabajo de base agrupado. Omitir oculta la sección. |
| `phases` | array | **sí** | Las fases del proyecto (el corazón del tablero). |
| `crosscutting` | object | opcional | Tareas que sirven a varias fases. Omitir oculta la sección. |

Validación mínima del importador: `project` presente + `phases` es array. Todo lo demás degrada con guardas.

---

## `project`

```jsonc
{
  "name": "Cliente — Proyecto",   // string · REQUERIDO. El texto tras " — " se colorea con acento.
  "client": "Cliente S.A.",       // string · recomendado
  "deal": "Descripción del deal", // string · opcional
  "dealAmount": "$10,000 USD",    // string · recomendado (se muestra en la meta)
  "kickoff": "2026-01-10",        // YYYY-MM-DD · recomendado
  "estimatedWeeks": 12,           // number · recomendado (se muestra "N módulos · W semanas")
  "lastUpdate": "2026-02-15",     // YYYY-MM-DD · recomendado (changelog; Export lo auto-actualiza)
  "slug": "acme",                 // string · OPCIONAL. Key de LocalStorage. Si falta → se deriva de name.
  "eyebrow": "Dashboard · Cliente"// string · OPCIONAL. Texto del eyebrow. Si falta → "Dashboard maestro".
}
```

- **`slug`** namespacea el estado en LocalStorage (`dashboard-state-{slug}-v1`). Sin él, se deriva del `name` (lowercase, sin acentos, kebab). Da un `slug` explícito si dos proyectos pudieran compartir derivación.
- **`name`**: el HTML hace `name.replace(' — ', ...)` para colorear la segunda mitad. Usa el em-dash ` — ` si quieres ese efecto; si no, el nombre entero va sin acento de color.

---

## `tools`

Diccionario opcional para que los chips de herramienta tengan color/icono consistentes. Las herramientas referenciadas en `phase.tools`/`task.tools` que **no** estén aquí igual se muestran como chip de texto plano.

```jsonc
"tools": {
  "Airtable":  { "color": "#fbbf24", "icon": "🗂️" },
  "n8n":       { "color": "#ef4444", "icon": "⚙️" },
  "Supabase":  { "color": "#10b981", "icon": "🗃️" },
  "Next.js":   { "color": "#60a5fa", "icon": "▲" }
}
```

> Nota: en la versión actual del HTML los chips se renderizan como texto; `color`/`icon` quedan como registro semántico y para futuras iteraciones del tema. Mantenerlo es buena práctica.

---

## `statusLabels` — FIJO, no modificar

```jsonc
"statusLabels": {
  "done":        { "label": "Completado",  "color": "#10b981", "icon": "✅" },
  "in_progress": { "label": "En progreso", "color": "#fbbf24", "icon": "🟡" },
  "pending":     { "label": "Pendiente",   "color": "#6b7280", "icon": "⏳" },
  "blocked":     { "label": "Bloqueado",   "color": "#ef4444", "icon": "🔴" }
}
```

Son los 4 únicos valores válidos de `task.status`. El HTML los usa para iconos, columnas Kanban y conteos.

---

## `blockers[]`

```jsonc
{
  "id": "BLK-001",              // string · REQUERIDO · patrón BLK-NNN · único
  "title": "Título corto",      // string · REQUERIDO
  "owner": "Cliente",           // string · REQUERIDO · quién lo resuelve = a quién le pides la acción
  "since": "2026-01-20",        // YYYY-MM-DD · REQUERIDO
  "severity": "high",           // enum · REQUERIDO · ver tabla abajo
  "description": "Qué bloquea",  // string · REQUERIDO
  "affects": ["M1-T01"],        // string[] · REQUERIDO · IDs de tareas que paraliza
  "resolvedAt": "2026-06-02"     // YYYY-MM-DD · OPCIONAL · fecha de resolución (con severity:"resolved")
}
```

### `severity` (enum con estilo CSS)

| Valor | Badge | Cuándo |
|-------|-------|--------|
| `critical` | rojo | detiene el proyecto / la fase |
| `high` | amarillo | detiene un entregable importante |
| `medium` | púrpura | molesto pero hay workaround |
| `low` | azul | menor |
| `resolved` | verde | ya resuelto (acompañar con `resolvedAt`) |

### Mecánica de "bloqueante activo"

El banner muestra un bloqueador solo si **no** está resuelto **y** alguna de sus `affects[]` no está `done`:

```js
activeBlockers = blockers.filter(b =>
  b.severity !== 'resolved' &&
  b.affects.some(taskId => taskState(taskId) !== 'done'));
```

Dos formas de archivar un bloqueador, **ambas sin borrarlo**:
- **Explícita:** marcar `severity:"resolved"` + `resolvedAt` → sale del banner aunque sus tareas sigan `in_progress`/`pending`.
- **Automática:** cuando la última tarea afectada pasa a `done` → desaparece solo.

Cada tarea bloqueada referencia su `blocker` por ID (ver abajo) → relación bidireccional.

---

## `fundamentals` (OPCIONAL)

Trabajo de base agrupado por categoría. Omitir todo el objeto si no aplica → la sección se oculta.

```jsonc
"fundamentals": {
  "title": "Fundamentos · Infraestructura previa",   // string
  "description": "Trabajo que habilita las fases.",   // string
  "groups": [
    {
      "id": "FUND-AT",                 // string · prefijo de IDs del grupo
      "title": "Base de datos — Esquema inicial",
      "tasks": [ /* ver "Task" abajo, con id tipo FUND-AT-01 */ ]
    }
  ]
}
```

---

## `phases[]` — el corazón del tablero

```jsonc
{
  "id": "M1",                       // string · REQUERIDO · corto y único (M1, P1, F1…)
  "number": 1,                      // number · REQUERIDO · orden de display
  "name": "Módulo de Ingesta",      // string · REQUERIDO
  "subtitle": "Captura + procesamiento",// string · recomendado (tagline)
  "color": "#3b82f6",               // hex · REQUERIDO · color de la card y la barra
  "description": "1-2 líneas.",     // string · recomendado (visible en la card)
  "tools": ["Airtable", "Supabase"],// string[] · recomendado (chips)
  "hoursEstimated": 35,             // number · recomendado (suma de tareas; se muestra en el detalle)
  "deliverables": ["Pipeline de ingesta"],// string[] · recomendado (lista en el panel de detalle)
  "tasks": [ /* ver "Task" abajo */ ]
}
```

Colores sugeridos para diferenciar fases: `#3b82f6` (azul), `#10b981` (verde), `#f59e0b` (ámbar), `#ef4444` (rojo), `#a78bfa` (púrpura), `#60a5fa` (celeste).

---

## `crosscutting` (OPCIONAL)

Tareas que sirven a varias fases (dashboard, alertas, training, entrega). Misma forma que un grupo de tareas. Omitir oculta la sección. En el HTML, las transversales se agrupan **por estado** (no por categoría).

```jsonc
"crosscutting": {
  "title": "Tareas transversales",
  "description": "Sirven a múltiples fases.",
  "tasks": [ /* ver "Task" abajo, con id tipo CC-T01 */ ]
}
```

---

## Objeto `Task` (común a fases, fundamentos y transversales)

```jsonc
{
  "id": "M1-T01",                // string · REQUERIDO · único global · ver convención de IDs
  "title": "Setup Supabase",     // string · REQUERIDO
  "description": "Texto largo.", // string · opcional (visible en el modal)
  "tools": ["Supabase"],         // string[] · opcional (chips)
  "hoursEstimated": 5,           // number · opcional (se muestra en la card)
  "status": "pending",           // enum · REQUERIDO · done|in_progress|pending|blocked
  "notes": "",                   // string · opcional · log append-only (fechas, IDs, execs)
  "completedAt": "2026-05-12",   // YYYY-MM-DD · opcional · poner al pasar a "done"
  "blocker": "BLK-001"           // string · opcional · ID de UN bloqueador (relación inversa a affects[])
}
```

- `description` es lo que se ve en el modal; si falta, cae a `notes`.
- `blocker` enlaza la tarea a un `blockers[].id`. Debe existir en `affects[]` del bloqueador (consistencia bidireccional).
- En fundamentos las tasks no llevan `description`/`hoursEstimated` obligatorios (se listan compactas); en fases sí conviene.

---

## Convención de IDs (obligatoria para que `affects[]` ↔ `blocker` cuadren)

| Tipo | Patrón | Ejemplo |
|------|--------|---------|
| Fase | `M{n}` / `P{n}` / `F{n}` | `M1` |
| Tarea de fase | `{phaseId}-T{NN}` | `M1-T01` |
| Grupo de fundamentos | `FUND-{XX}` | `FUND-AT` |
| Tarea de fundamentos | `{groupId}-{NN}` | `FUND-AT-01` |
| Tarea transversal | `CC-T{NN}` | `CC-T01` |
| Bloqueador | `BLK-{NNN}` | `BLK-001` |

**Regla de oro:** si renombras una fase (`phase.id`), actualiza el prefijo de todos sus `task.id` y cualquier `blocker.affects[]` que los referencie. IDs estables = bloqueadores que no se rompen.
