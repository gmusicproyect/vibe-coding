# Clase 11 — Cómo gestionar clientes y contexto con Claude Code

**Tags:** `Gestión de Clientes` `Contexto Multi-Proyecto` `Kanban Dashboard` `Contratos entre Sesiones`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 03](clase-03-segundo-cerebro.md) · [Clase 09](clase-09-claude-code-desde-cero.md) · [Clase 10](clase-10-agente-5usd-cloudflare.md)

---

## Idea central

Manejar múltiples clientes y desarrollos simultáneos con IA sin perder el control exige tres pilares: una estrategia comercial de confianza progresiva (Metodología 3-3-3), una arquitectura de carpetas que aísle el contexto evitando contaminaciones cruzadas, y contratos explícitos entre sesiones paralelas. Complementar esto con un tablero de control desacoplado (`project-kanban-dashboard`), donde los datos viven en un `dashboard-data.json` vivo y la visualización en un HTML interactivo sin dependencias, permite que Claude Code razone sobre dependencias y prioridades mientras desarrollador y cliente mantienen visibilidad total del avance.

---

## Metodología 3-3-3 y monetización de servicios

Para romper la barrera de adquirir los primeros clientes sin experiencia previa comprobable:

| Tramo | Condición comercial | Objetivo y entregable a cambio |
| :--- | :--- | :--- |
| **Clientes 1 a 3** | **100% Bonificado ($0 USD)** | Testimonio en video + feedback riguroso del proceso. |
| **Clientes 4 a 6** | **A costo directo** (licencias/software) | Validación de flujo operativo + segundo lote de testimonios. |
| **Clientes 7 a 9** | **50% de descuento** sobre tarifa meta | Refinamiento de tiempos de entrega y casos de estudio. |
| **Cliente 10+** | **100% tarifa regular** | 9 testimonios previos respaldando la metodología. |

> **Principio de venta ("El cliente no sabe lo que no sabe"):** Nunca cotices únicamente la petición superficial del cliente (ej. un formulario de $250 o $800 USD). Escucha sus dolores operativos estructurales (moras, fraudes, llamadas manuales) para diseñar alcances integrales por módulos (ej. sistemas de $5,000+ USD con hitos de pago: 40% inicio, 30% primer lote, 30% entrega + retainer de soporte).

---

## Aislamiento de contexto y sesiones paralelas

Para evitar que Claude Code mezcle datos entre clientes o desborde la ventana de contexto:

1. **Jerarquía estricta de carpetas:**
   ```
   developer/clients/[cliente]/
   ├── CLAUDE.md              → Comportamiento específico y reglas de actualización
   ├── context/               → Fichas de negocio por área (ventas, backoffice, créditos)
   ├── memory/                → Hechos verificados, esquemas de BD y workflows
   ├── dashboard-data.json    → Fuente de verdad viva del estado del proyecto
   └── [proyecto-a]/          → Subproyecto aislado (ej. backend / n8n / Supabase)
   ```
2. **Contratos entre sesiones (Sesión A y Sesión B):** Si el frontend corre en Next.js y el backend en n8n/Supabase, se operan en terminales separadas. Se comunican mediante un archivo Markdown de contrato: la Sesión A documenta y firma la entrega de un endpoint o webhook; la Sesión B valida la firma, implementa el consumo en UI y sella el contrato.
3. **Cierre de bucle obligatorio:** Si Claude Code propone una solución, nunca cierres la terminal sin reportar el resultado de la reunión o del cliente. Alimentar la respuesta del cliente a la memoria mantiene el contexto alineado con la realidad.

---

## El Dashboard Maestro de Proyecto (`project-kanban-dashboard`)

Separar la visualización del almacenamiento de estado resuelve la coordinación del proyecto:

```
[ dashboard-data.json ]   ──(Fuente de verdad canónica)──►   [ Claude Code ]
          │                                                         │
       (Merge)                                             (Actualiza tareas/notas)
          ▼                                                         │
   [ dashboard.html ]    ◄──(Renderiza interfaz)────────────────────┘
```

- **`dashboard-data.json`:** Estructura pura en JSON (fases, tareas, bloqueadores, fundamentos). Es lo que Claude Code lee y actualiza con mínimo consumo de tokens al terminar cada hito.
- **`dashboard.html`:** SPA standalone offline (CSS y JS embebidos, cero build, sin dependencias de Node). Corre directamente con `python3 -m http.server` o `serve-dashboard.sh`.
- **Bloqueadores (`blockers`):** Cada bloqueador tiene dueño (`owner`) y tareas afectadas (`affects`). Se auto-oculta del banner al resolverse (`severity: "resolved"`).

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Descarga la plantilla de `skills/project-kanban-dashboard/`, inicializa un `dashboard-data.json` para uno de tus proyectos definiendo al menos 2 fases con 3 tareas cada una, un bloqueador asignado a un responsable y el slug correspondiente. Levanta el servidor local con `./serve-dashboard.sh` y verifica el renderizado en tu navegador.

**Ejercicio 2 (avanzado):** Configura en el `CLAUDE.md` de tu proyecto una regla explícita que obligue al agente a actualizar `dashboard-data.json` (marcando `status: "done"` y añadiendo timestamp en `notes`) inmediatamente después de validar un cambio en el código.

**Ejercicio 3 (los otros dos pilares):** Para un cliente ficticio, escribe en `propuesta-cliente-01.md` a qué tramo de la Metodología 3-3-3 correspondería (justifica con el número de cliente y el entregable que pedirías a cambio) y arma la jerarquía de carpetas `developer/clients/[cliente]/` con `CLAUDE.md`, `context/` y `memory/` vacíos pero presentes. Si tu proyecto tiene frontend y backend separados, crea además `contrato-sesion-a-b.md` documentando un endpoint que la Sesión A le "entrega" a la Sesión B.

---

## 💡 Tip

Cuando necesites que un cliente valide requerimientos ambiguos, no envíes correos largos con preguntas que ignorará. Pídele a Claude Code que genere un HTML interactivo mínimo con casillas de verificación (`checkboxes`), súbelo en 5 segundos arrastrándolo a **Vercel Drop** (`vercel.com/drop`) y envíale el enlace. El cliente marca sus elecciones y un botón *"Copiar para WhatsApp"* formatea las respuestas estructuradas en Markdown listas para que continúes el desarrollo.

---

## ⚠️ Error común

Editar el archivo `dashboard.html` a mano para actualizar textos o estados. El HTML está diseñado para ser agnóstico y auto-configurado: toma el nombre, fases, tareas y colores exclusivamente de `dashboard-data.json`. Cualquier edición manual en el HTML se sobreescribe o rompe la sincronización con el agente.
