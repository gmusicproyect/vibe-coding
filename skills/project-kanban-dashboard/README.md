# project-kanban-dashboard

> Skill de Claude Code que genera un **dashboard maestro de proyecto**: un tablero Kanban interactivo, autocontenido y offline, para visualizar el avance de un proyecto multi-fase con bloqueadores, fundamentos y tareas transversales.

Material de **Imperio Agéntico** · [carlosdominguez.com.mx](https://carlosdominguez.com.mx). Pensado para distribuirse y enseñarse.

---

## Qué genera

Tres archivos en la carpeta de tu proyecto:

```
dashboard.html        ← SPA standalone (CSS + JS embebido, sin build, sin dependencias)
dashboard-data.json   ← la fuente de verdad: fases, tareas, bloqueadores, fundamentos
serve-dashboard.sh    ← levanta un servidor local y abre el navegador
```

El dashboard muestra:
- **Avance total** del proyecto (barra + stats: total / done / in-progress / blocked).
- **Banner de bloqueadores** con dueño y severidad — se auto-oculta cuando se resuelven.
- **Cards de fase** con progreso, que expanden un **Kanban de 4 columnas** (Pendiente / En progreso / Completado / Bloqueado).
- **Modal de tarea** para cambiar estado y notas.
- Secciones de **Fundamentos** y **Tareas transversales** (se ocultan si no aplican).
- **Export / Import JSON** + persistencia en LocalStorage (namespaced por proyecto).

Cero backend. Cero cuenta. Cero build. Corre desde un `python3 -m http.server`.

---

## Por qué (el problema que resuelve)

En proyectos largos con un cliente que bloquea, la pregunta constante es: *¿qué está hecho, qué falta y de quién depende lo que falta?* Este dashboard responde eso en una pantalla, y separa **datos** (`dashboard-data.json`) de **presentación** (`dashboard.html`): la misma fuente sirve para que el agente razone sobre prioridades, para que el cliente vea avance, y para archivar snapshots fechados.

---

## Instalación

La skill es una carpeta. Cópiala a uno de estos lugares:

```bash
# Global (todos tus proyectos):
cp -R project-kanban-dashboard ~/.claude/skills/

# Por proyecto (solo este repo):
cp -R project-kanban-dashboard <tu-proyecto>/.claude/skills/
```

No necesita configuración: no hay `meta.json` ni manifest. Claude Code la descubre por el frontmatter de `SKILL.md`.

---

## Uso

Pídeselo a Claude Code en lenguaje natural:

- "Genérame un **dashboard de proyecto** para [cliente]"
- "Hazme un **kanban maestro** de estas fases…"
- "Quiero una **vista maestra del avance** del proyecto"

O invócala directo: `/project-kanban-dashboard`.

El agente recopila la info (o la lee de tus documentos), genera el `dashboard-data.json`, copia el HTML y el script, y lo sirve. Luego lo mantiene al día entre sesiones.

---

## Estructura de la skill

```
project-kanban-dashboard/
├── SKILL.md                 # instrucciones para el agente (frontmatter + FASES)
├── README.md                # este archivo (para humanos)
├── references/
│   ├── schema.md            # spec campo por campo del dashboard-data.json
│   ├── modelado.md          # cómo descomponer un proyecto (metodología)
│   └── mantenimiento.md     # cómo actualizar el JSON entre sesiones
└── templates/
    ├── dashboard.html       # plantilla de cero ediciones (todo sale del JSON)
    ├── dashboard-data.json  # plantilla de datos a personalizar
    └── serve-dashboard.sh   # servidor local
```

La plantilla `dashboard.html` se copia **tal cual**: el nombre del proyecto, el eyebrow, las secciones presentes y la key de LocalStorage se personalizan solos desde `dashboard-data.json`. No se edita el HTML a mano.

---

## Requisitos

- **Python 3** (para el servidor local; viene en macOS/Linux).
- Un navegador moderno.
- No requiere Node, ni instalar paquetes, ni conexión a internet.

---

## Limitaciones

- Sin sync multi-dispositivo (LocalStorage es por navegador → usar Export/Import).
- Sin drag-and-drop (cambios de estado por modal; decisión consciente).
- Sin autenticación (no exponer en internet sin proteger).
- Sin historial de cambios (usar `notes` como bitácora).

---

## Créditos y licencia

Hecho por **Carlos Domínguez** para **Imperio Agéntico**.
🌐 [carlosdominguez.com.mx](https://carlosdominguez.com.mx)

Destilado de un dashboard maestro real de un proyecto de automatización.

Licencia **MIT** (ajústala a tu gusto antes de distribuir):

```
MIT License — © 2026 Carlos Domínguez · Imperio Agéntico
Se concede permiso para usar, copiar, modificar y distribuir este software
sin restricción, conservando este aviso. Sin garantía.
```
