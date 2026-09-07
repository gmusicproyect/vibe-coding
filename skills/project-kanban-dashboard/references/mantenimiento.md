# Playbook de actualización — mantener el dashboard al día entre sesiones

El `dashboard-data.json` es un **documento vivo**, no un artefacto de una sola vez. Su valor está en que refleje el estado real en cualquier momento. Este playbook es cómo el agente lo mantiene.

---

## Quién edita qué: JSON vs LocalStorage

Hay dos lugares donde "vive" el estado. No confundirlos:

| | `dashboard-data.json` | LocalStorage (overrides) |
|---|----------------------|---------------------------|
| Es | **la fuente de verdad** | cambios temporales del navegador |
| Lo edita | **el agente (tú)**, en disco | el usuario, haciendo click en el modal |
| Persiste | sí, en el repo/carpeta | solo en ese navegador |
| Para qué | el estado canónico del proyecto | que el cliente juegue/marque sin tocar el archivo |

El HTML hace **merge**: lee el JSON base y le aplica los overrides de LocalStorage encima (`getTaskState`). El puente entre ambos es **Export/Import**:

```
Usuario marca tareas en el navegador  ──Export JSON──►  archivo con overrides aplicados
                                                              │
                          el agente lo recibe, lo hace canónico, edita y devuelve
                                                              │
JSON canónico actualizado en disco  ◄──(reemplaza dashboard-data.json)──┘
```

> **Regla:** si el usuario te pasa un JSON exportado, ese es el nuevo estado base. Intégralo al `dashboard-data.json` del repo. No mantengas dos verdades.

---

## Operaciones de actualización

### Cerrar una tarea
```jsonc
"status": "done",
"completedAt": "2026-02-15",
"notes": "… · validado E2E exec 1042"   // log append-only, ver abajo
```
Esto actualiza el % global, el % de la fase, y (si era la última tarea de un bloqueador) auto-archiva ese bloqueador del banner.

### Arrancar una tarea
`status: "in_progress"`. Mantén pocas a la vez (1-2). Demasiadas `in_progress` = el tablero no comunica foco.

### Bloquear una tarea
```jsonc
"status": "blocked",
"blocker": "BLK-007"
```
Y asegúrate de que `BLK-007` exista y liste esta tarea en su `affects[]`.

### Resolver un bloqueador (NO borrar)
```jsonc
{
  "id": "BLK-001",
  "severity": "resolved",       // ← cambia de critical/high/... a resolved
  "resolvedAt": "2026-06-02",    // ← añade la fecha
  ...                            // deja title/owner/since/description/affects intactos
}
```
Además, desbloquea las tareas que dependían de él (a `in_progress`/`pending`/`done` según corresponda). Marcar `severity:"resolved"` lo saca del banner **de inmediato**, sin esperar a que esas tareas estén `done`. Queda en el array como histórico.

---

## `notes` = log append-only

`notes` no es un campo de "descripción": es la **bitácora** de la tarea. Acumula, no reemplaces. Cada entrada con fecha y dato verificable:

```
"notes": "Workflow wf_8sK2qD creado 2026-01-10. · Test E2E 2026-01-12 exec 1042 OK. · Cutover 2026-01-18, validado exec 1187 status read."
```

Así cada tarea *es* su propia historia. Cuando retomas el proyecto semanas después, las `notes` te dicen exactamente qué pasó.

---

## `project.lastUpdate` = changelog de la sesión

Actualízalo **siempre** que edites el JSON a mano (YYYY-MM-DD). Úsalo como mini-changelog de qué cerró la sesión — puede ser una frase rica, no solo la fecha:

```jsonc
"lastUpdate": "2026-01-18 (cerrado M2 en producción; bloqueador BLK-003 resuelto; falta deploy a producción)"
```

> Si el usuario hace **Export** desde el navegador, el script ya pone `lastUpdate` en la fecha de hoy automáticamente. Al integrar ese export, enriquécelo con el changelog.

---

## Al retomar un dashboard existente (checklist)

1. **Lee el `dashboard-data.json` actual** — es el estado canónico.
2. ¿El usuario hizo cambios en el navegador? Pídele un **Export** y conviértelo en la base.
3. Aplica las operaciones de la sesión: cerrar tareas (`done`+`completedAt`), resolver bloqueadores (`resolved`+`resolvedAt`), abrir nuevas tareas/bloqueadores si surgieron.
4. Acumula en `notes`; no sobreescribas la bitácora.
5. Actualiza `project.lastUpdate` con el changelog de la sesión.
6. Verifica integridad: cada `task.blocker` existe y está en el `affects[]` del bloqueador; cada `affects[]` apunta a un `task.id` real.
7. Si cambió la estructura (nueva fase, IDs renombrados), arrastra los IDs en `affects[]`.

---

## Integridad referencial (qué revisar antes de cerrar la sesión)

- [ ] Todo `task.blocker` → existe un `blockers[].id` igual.
- [ ] Todo `blockers[].affects[]` → apunta a un `task.id` que existe.
- [ ] Toda tarea `status:"blocked"` → tiene `blocker` y ese bloqueador NO está `resolved`.
- [ ] Todo bloqueador `resolved` → lleva `resolvedAt` y sus tareas afectadas ya no están `blocked` (sale del banner por estar `resolved`, sin importar el estado de sus tareas).
- [ ] `project.lastUpdate` refleja hoy.
- [ ] El JSON parsea (`python3 -c "import json;json.load(open('dashboard-data.json'))"`).
