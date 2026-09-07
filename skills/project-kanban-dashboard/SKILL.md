---
name: project-kanban-dashboard
description: Genera y mantiene un dashboard maestro de proyecto interactivo, autocontenido y offline tipo Kanban, separando la fuente de verdad estructurada (dashboard-data.json) de la visualización (dashboard.html). Úsalo cuando el usuario diga "dashboard de proyecto", "kanban de avance", "vista maestra de fases", "seguimiento de entregables", o ejecute /project-kanban-dashboard.
---

# SKILL: Project Kanban Dashboard

> Guarda este archivo en `/skills/project-kanban-dashboard/SKILL.md`
> Diseñado por **Carlos Domínguez** para **Imperio Agéntico** (Clase 11 de Vibe Coding).
> Referencia en tu CLAUDE.md: `- /skills/project-kanban-dashboard/SKILL.md → para generar y mantener el tablero Kanban maestro del proyecto offline con dashboard-data.json y dashboard.html`

---

## Cuándo usar este skill

Cuando el usuario requiera:
1. Una vista maestra interactiva de avance multi-fase con control de bloqueadores, tareas por estado y notas de auditoría.
2. Desacoplar el estado del proyecto para que la IA razone sobre un JSON ligero (`dashboard-data.json`) sin lidiar con código HTML de presentación.
3. Compartir avances transparentes con clientes o equipos sin depender de plataformas SaaS externas (Jira, Trello, Notion).

---

## Estructura de archivos generados

En la raíz del proyecto o carpeta de cliente, este skill genera tres archivos:

```
[proyecto]/
├── dashboard.html        ← SPA standalone (CSS + JS embebido, sin dependencias, sin build)
├── dashboard-data.json   ← Fuente de verdad canónica (fases, tareas, blockers, fundamentals)
└── serve-dashboard.sh    ← Script para iniciar el servidor local y abrir el navegador
```

---

## Protocolo de Ejecución

### Fase 1 — Recopilar o inferir el estado del proyecto

1. Leer los documentos existentes (`CLAUDE.md`, propuestas, scopes, notas de reuniones o esquemas).
2. Extraer:
   - **Metadatos del proyecto:** Nombre comercial, cliente, monto/deal, fecha de inicio (`kickoff`), estimación en semanas, `slug` identificador.
   - **Fases del proyecto:** Módulos principales con entregables específicos (`deliverables`), horas estimadas y herramientas usadas.
   - **Tareas por fase:** Lista de tareas iniciales con su ID canónico (`M1-T01`, `M2-T01`), título, descripción y estado (`pending`, `in_progress`, `done`, `blocked`).
   - **Bloqueadores activos:** Obstáculos que detienen tareas (`BLK-001`), asignando responsable (`owner`: Cliente / Dev / Tercero), severidad y tareas afectadas (`affects`).
   - **Fundamentos y transversales:** Tareas de base (esquema inicial, setups) y transversales (testing, despliegue, entrega).

---

### Fase 2 — Generar `dashboard-data.json`

Crear `dashboard-data.json` respetando estrictamente la especificación de `references/schema.md`:

```jsonc
{
  "_meta": "Generado por project-kanban-dashboard",
  "project": {
    "name": "Cliente — Sistema Integral",
    "client": "Cliente S.A.",
    "deal": "Desarrollo modular de automatización y scoring",
    "dealAmount": "$5,000 USD",
    "kickoff": "2026-03-01",
    "estimatedWeeks": 6,
    "lastUpdate": "2026-03-01 (kickoff inicial y arquitectura definida)",
    "slug": "cliente-sistema",
    "eyebrow": "Dashboard Maestro · Cliente S.A."
  },
  "statusLabels": {
    "done": { "label": "Completado", "color": "#10b981", "icon": "✅" },
    "in_progress": { "label": "En progreso", "color": "#fbbf24", "icon": "🟡" },
    "pending": { "label": "Pendiente", "color": "#6b7280", "icon": "⏳" },
    "blocked": { "label": "Bloqueado", "color": "#ef4444", "icon": "🔴" }
  },
  "blockers": [],
  "phases": [
    {
      "id": "M1",
      "number": 1,
      "name": "Módulo 1: Ingesta y Base de Datos",
      "subtitle": "Estructuración y captura",
      "color": "#3b82f6",
      "description": "Configuración de esquema en Supabase y webhooks de entrada.",
      "tools": ["Supabase", "n8n"],
      "hoursEstimated": 20,
      "deliverables": ["Esquema validado", "Endpoint webhook operativo"],
      "tasks": [
        {
          "id": "M1-T01",
          "title": "Diseño de tablas en Supabase",
          "description": "Modelado de datos y políticas RLS iniciales.",
          "tools": ["Supabase"],
          "hoursEstimated": 6,
          "status": "in_progress",
          "notes": "Iniciado setup de migraciones SQL."
        }
      ]
    }
  ]
}
```

---

### Fase 3 — Desplegar `serve-dashboard.sh` y visualizador

1. Generar el script local `serve-dashboard.sh`:
   ```bash
   #!/usr/bin/env bash
   PORT=${1:-8000}
   echo "Sirviendo dashboard en http://localhost:$PORT/dashboard.html"
   python3 -m http.server $PORT
   ```
2. Otorgar permisos de ejecución: `chmod +x serve-dashboard.sh`.
3. Iniciar el servicio y abrir el navegador para validar la carga de datos.

---

### Fase 4 — Mantenimiento continuo entre sesiones

Seguir rigurosamente el playbook de `references/mantenimiento.md`:
1. **Regla de oro de la bitácora:** El campo `notes` en cada tarea es acumulativo (`append-only`). No sobreescribir el historial; añadir timestamp y evidencia de validación (ej. `"2026-03-05: Webhook validado con payload real exitoso."`).
2. **Resolución de bloqueadores:** Nunca eliminar un bloqueador resuelto del array. Marcar `"severity": "resolved"` y registrar `"resolvedAt": "YYYY-MM-DD"`.
3. **Changelog activo:** En cada sesión que modifique el estado del proyecto, actualizar `project.lastUpdate` con una síntesis concisa de los avances cerrados.
4. **Verificación de integridad:** Confirmar que todo `task.blocker` apunte a un `blockers[].id` válido y viceversa.
