# Guía de modelado — descomponer un proyecto para el dashboard

Cómo pasar de una propuesta, scope o conversación desordenada con el cliente a una estructura limpia de **fases**, **tareas**, **bloqueadores**, **fundamentos** y **transversales** en `dashboard-data.json`.

---

## Principios de modelado

1. **La fuente manda:** Si existe un documento de alcance (Scope PDF) o cotización aprobada, las fases del dashboard deben mapear 1:1 a los módulos prometidos.
2. **"El cliente no sabe lo que no sabe":** Los clientes suelen pedir funciones aisladas ("quiero un formulario"). Modelar el proyecto como un sistema integral con valor de negocio (Captura → Scoring/Procesamiento → Notificación/Recuperación).
3. **Foco en entregables verificables:** Una tarea no es "trabajar en el backend"; es "Diseñar esquema en Supabase con RLS activo y migraciones versionadas".

---

## Anatomía de descomposición

### 1. Metadatos del proyecto (`project`)
- **`name`:** Usar la convención `Cliente — Proyecto` con em-dash ` — ` para permitir el estilizado de acento en `dashboard.html`.
- **`dealAmount`:** Reflejar el valor monetario acordado para mantener presente la escala del compromiso.
- **`estimatedWeeks`:** Duración global estimada desde el kickoff hasta la entrega final.
- **`slug`:** Identificador único en kebab-case para namespacing en LocalStorage (`dashboard-state-{slug}-v1`).

---

### 2. Fundamentos (`fundamentals`) — Opcional
El trabajo de base que habilita el arranque de los módulos. No es visible para el cliente como funcionalidad final, pero es indispensable para el equipo técnico:
- Repositorio GitHub y branches protegidas.
- Variables de entorno y llaves de acceso (OpenRouter, Supabase, n8n).
- Servidor de base de datos o cuentas cloud configuradas.

> *Regla:* Si el proyecto parte sobre una base ya instalada, omitir esta sección en `dashboard-data.json`.

---

### 3. Fases (`phases[]`) — El corazón del tablero
Un proyecto saludable tiene entre **3 y 6 fases**. Más de 6 indica que el proyecto debe partirse en contratos o versiones separadas.

Para cada fase:
- **`id`:** Prefijo corto y estable (`M1`, `M2`, `M3`...).
- **`name`:** Nombre descriptivo del módulo (ej. `Módulo 1: Inteligencia de Cartera`).
- **`subtitle`:** Tagline conciso de valor de negocio (ej. `Detección temprana de moras`).
- **`color`:** Código hexadecimal que identifique la fase (`#3b82f6`, `#10b981`, `#f59e0b`, `#ef4444`, `#a78bfa`).
- **`hoursEstimated`:** Suma realista de las horas estimadas de sus tareas.
- **`deliverables`:** Lista de 2 a 4 entregables tangibles que el cliente podrá probar.
- **`tasks`:** Lista de tareas que componen la fase.

---

### 4. Tareas (`tasks[]`)
Cada tarea debe cumplir la regla de granularidad:
- **Duración ideal:** Entre 2 y 8 horas. Si una tarea supera las 12 horas, está escondiendo subtareas y debe dividirse.
- **ID canónico:** `{phaseId}-T{NN}` (ej. `M1-T01`, `M1-T02`).
- **Descripción:** Texto explicativo claro visible en el modal interactivo.
- **Tools:** Chips con tecnologías asociadas (`Supabase`, `Next.js`, `n8n`, etc.).
- **Notes:** Bitácora acumulativa (`append-only`) con timestamps de validación.

---

### 5. Bloqueadores (`blockers[]`)
El banner de bloqueadores es la herramienta más poderosa para evitar parálisis de proyecto:
- **Dueño claro (`owner`):** Siempre debe señalar a una persona o entidad concreta (`Cliente`, `Dev`, `Tercero / Proveedor API`). Nunca dejar bloqueadores huérfanos.
- **Relación bidireccional:** Todo bloqueador lista en `affects[]` los IDs de las tareas paralizadas, y cada tarea paralizada apunta a `blocker: "BLK-001"`.
- **Severidad:**
  - `critical`: Paraliza todo el proyecto o la fase actual.
  - `high`: Detiene un entregable clave.
  - `medium`: Inconveniente con workaround disponible.
  - `low`: Detalle menor no bloqueante.
  - `resolved`: Bloqueador resuelto (se auto-archiva del banner inmediatamente).

---

### 6. Tareas transversales (`crosscutting`) — Opcional
Actividades que impactan a todas las fases y no pertenecen a un módulo aislado:
- Documentación técnica y handoff para el cliente.
- Pruebas E2E / auditoría de seguridad y penetración.
- Capacitación del equipo o staff del cliente.
- Despliegue a producción y configuración de dominio.

---

## Checklist de validación del modelo

Antes de servir el dashboard:
- [ ] ¿Los nombres y entregables coinciden con el Scope acordado con el cliente?
- [ ] ¿Cada bloqueador activo tiene un `owner` identificado y tareas asignadas?
- [ ] ¿Los IDs de tareas siguen la convención estricta (`M1-T01`, `BLK-001`)?
- [ ] ¿El archivo parsea sin errores de sintaxis JSON?
- [ ] ¿Se levantó el dashboard en local con `serve-dashboard.sh` y carga los datos correctamente?
