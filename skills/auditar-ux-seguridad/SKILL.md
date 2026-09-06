# SKILL: Auditoría de UX y Seguridad en Web Apps con IA

> Guarda este archivo en `/skills/auditar-ux-seguridad/SKILL.md`
> Referencia en tu CLAUDE.md: `- /skills/auditar-ux-seguridad/SKILL.md → para auditar los 4 estados obligatorios de UX, robustez de formularios y los pilares de seguridad/RLS en Supabase`

---

## Cuándo usar este skill

Cuando el usuario requiera auditar una aplicación web construida con asistencia de IA para:
1. Detectar omisión de estados de interfaz (pantallas en blanco, loaders infinitos, formularios que borran datos ante error).
2. Verificar la robustez y accesibilidad de formularios y flujos destructivos.
3. Auditar la capa de seguridad en base de datos (Supabase / PostgreSQL) garantizando RLS activo, aislamiento por tenant/usuario y cero exposición de secretos de backend en el cliente.

Basado en las directrices de la **Clase 08 — UX + Seguridad en Web Apps con IA**.

---

## Prerequisitos

- [ ] Acceso al código fuente de frontend (componentes, formularios, hooks de consulta/mutación).
- [ ] Acceso a las migraciones SQL, esquemas de base de datos o políticas RLS en Supabase.
- [ ] Variables de entorno y configuración de clientes (`supabaseClient`, `.env.example`).

---

## Pasos de Auditoría

### Paso 1 — Auditoría de los 4 Estados Obligatorios de UX

Revisar cada vista o componente que interactúe con datos asíncronos (fetch, mutación, tablas, listas):

1. **Empty State:**
   - ¿Qué renderiza cuando la colección viene vacía (`[]`)?
   - Si muestra una pantalla en blanco o solo un contenedor vacío, marcar como fallo.
   - Debe proveer un mensaje contextual y un botón de acción principal claro (ej. "Aún no tienes proyectos. [Crear primer proyecto]").

2. **Loading State:**
   - ¿Hay feedback visual inmediato al disparar la acción (skeletons o spinners)?
   - ¿Se deshabilitan los botones de acción (`disabled={isLoading}`) para evitar disparos múltiples o race conditions?

3. **Error State:**
   - ¿Muestra errores comprensibles para humanos o códigos crudos de base de datos (`PGRST...`)?
   - **Regla crítica de formularios:** Al fallar una mutación/submit, ¿se conservan los datos ya ingresados en los campos o se resetea el formulario obligando al usuario a reescribir todo? Si se borra la información, clasificar como hallazgo de severidad alta.

4. **Success State:**
   - ¿El usuario recibe confirmación visual inequívoca (toast, banner o cambio de estado) tras completar una acción crítica antes de cualquier redirección?

---

### Paso 2 — Auditoría de Formularios y Modales

Revisar los elementos `<form>`, inputs y botones:

1. **Semántica de Inputs y Autocompletado:**
   - Verificar atributos semánticos: `type="email"`, `type="password"`, `type="tel"`, `inputmode="numeric"`.
   - Verificar `autocomplete` nativo (`email`, `current-password`, `new-password`, `tel`).
2. **Protección contra Doble Submit:**
   - Comprobar debounce o bloqueo del botón submit durante la ejecución de la petición.
3. **Ubicación contextual de validaciones:**
   - Los mensajes de error deben aparecer adyacentes al campo respectivo, no únicamente en una alerta global desasociada.
4. **Acciones Destructivas:**
   - En modales de borrado o acciones irreversibles, verificar que no baste un simple click en "Aceptar". Se debe exigir confirmación explícita (p. ej. escribir el nombre del recurso o la palabra "ELIMINAR").

---

### Paso 3 — Auditoría de Seguridad y Row Level Security (RLS)

Analizar las tablas y políticas en Supabase / PostgreSQL:

1. **RLS Habilitado Obligatoriamente:**
   - Verificar que **todas** las tablas públicas tengan ejecutado:
     ```sql
     ALTER TABLE nombre_tabla ENABLE ROW LEVEL SECURITY;
     ```
   - Si una tabla pública carece de RLS, catalogar como **Vulnerabilidad Crítica**.

2. **Granularidad de Políticas:**
   - Descartar políticas genéricas inseguras como `FOR ALL USING (true)`.
   - Separar explícitamente políticas por comando: `SELECT`, `INSERT`, `UPDATE`, `DELETE`.
   - Para políticas de `INSERT` y `UPDATE`, verificar que incluyan cláusula `WITH CHECK (auth.uid() = user_id)` además de `USING`.

3. **Aislamiento de Tenant / Usuario:**
   - Validar que cada query filtre estrictamente por el tenant o ID del usuario autenticado (`auth.uid()`).

---

### Paso 4 — Secretos y Superficie de Ataque

1. **Exposición de Claves:**
   - Buscar en el código de cliente si la clave `SUPABASE_SERVICE_ROLE_KEY` o secrets de backend tienen el prefijo `NEXT_PUBLIC_`, `VITE_`, o si están importados en componentes de cliente.
   - Si la `service_role` está expuesta en el frontend, marcar como **Riesgo Crítico Inmediato**.
2. **Validación en Servidor:**
   - Verificar que los endpoints o Server Actions validen esquemas con Zod u homólogo antes de impactar la base de datos, sin confiar ciegamente en las validaciones de cliente.
3. **Manejo de Secrets:**
   - Confirmar que `.env`, `.env.local` y tokens de API estén debidamente incluidos en el `.gitignore`.

---

## Formato del Reporte de Entrega

El reporte debe ser concreto, priorizado y accionable:

```markdown
# Reporte de Auditoría UX & Seguridad

## Resumen Ejecutivo
- Componentes analizados: X
- Tablas auditadas: Y
- Hallazgos Críticos: N | Altos: N | Medios: N

## Hallazgos de Seguridad (Backend / RLS)
| Severidad | Ubicación / Tabla | Vulnerabilidad | Corrección requerida |
|-----------|-------------------|----------------|----------------------|
| CRÍTICA   | `profiles`        | RLS deshabilitado | `ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;` |

## Hallazgos de UX (Estados y Formularios)
| Severidad | Componente / Archivo | Estado Deficiente | Corrección requerida |
|-----------|----------------------|-------------------|----------------------|
| ALTA      | `CheckoutForm.tsx:45`| Reset en error    | Mantener estado de inputs al fallar la mutación |
```
