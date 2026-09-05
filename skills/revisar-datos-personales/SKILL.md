# SKILL: Auditoría de Datos Personales (Ley 21.719 / RGPD)

> Guarda este archivo en `/skills/revisar-datos-personales/SKILL.md`
> Referencia en tu CLAUDE.md: `- /skills/revisar-datos-personales/SKILL.md → para auditar qué datos personales captura el proyecto, su base legal y su ruta de borrado`

---

## Cuándo usar este skill

Cuando el usuario necesite auditar su base de código o esquema de base de datos para identificar qué datos personales captura, si cada uno tiene justificación legal y base de consentimiento, y si existe una ruta real de eliminación (no un flag lógico) — según lo enseñado en la Clase 06 (Ley 21.719 / RGPD).

---

## Prerequisitos

- [ ] Acceso de lectura al esquema de base de datos (`schema.prisma`, migraciones SQL, o el dashboard de Supabase) y a los formularios/endpoints que capturan datos
- [ ] Claridad sobre qué campos son estrictamente necesarios para la operación del producto (el usuario debe poder responder "¿para qué se usa este campo?")

---

## Pasos

### Paso 1 — Inventariar todos los campos que capturan datos personales

1. Leer el esquema completo (tablas de usuarios, clientes, leads, formularios).
2. Listar cada columna/campo, con su tabla y archivo/línea exacta donde se captura (formulario, endpoint de registro, webhook).
3. No limitarse a los campos "obvios" (email, nombre) — incluir IP, geolocalización, RUT/DNI, género, teléfono, metadata de dispositivo.

### Paso 2 — Clasificar cada campo con las 3 preguntas de control

Para cada campo del inventario:
1. **¿Para qué se pide?** — responder con la funcionalidad concreta que lo necesita.
2. **¿Con qué base legal?** — ejecución contractual, consentimiento expreso documentado, u otra base válida.
3. **¿Es indispensable?** — si el producto funciona sin ese dato, marcarlo como candidato a eliminar.

### Paso 3 — Verificar consentimiento y trazabilidad

Confirmar que existe una tabla o registro de logs con `user_id`, `terms_version` y `timestamp` que pruebe cuándo y qué versión de términos aceptó cada usuario. Si no existe, marcarlo como hallazgo crítico.

### Paso 4 — Verificar que el borrado sea real, no lógico

Revisar el endpoint de eliminación de cuenta/datos:
1. Confirmar que ejecuta un `DELETE` (o anonimización irreversible) real en la base de datos.
2. Si solo actualiza un campo `status: deleted` o similar sin borrar el registro, marcarlo como infracción grave (el dato sigue existiendo).
3. Probarlo: crear un usuario de test, invocar el borrado, y consultar directamente la tabla para confirmar que el registro ya no está.

### Paso 5 — Generar el reporte de auditoría

Entregar un inventario estricto (nunca una respuesta genérica de "sí cumple"):

```
| Campo | Archivo:línea | Base legal | ¿Indispensable? | Ruta de borrado |
|-------|---------------|------------|------------------|------------------|
| ...   | ...           | ...        | Sí/No            | Real/Falta/Lógico |
```

Marcar en rojo los campos sin base legal clara, sin ruta de borrado real, o innecesarios para la operación.

---

## Outputs esperados

- Inventario completo de campos con archivo y línea exacta de captura
- Clasificación de cada campo (indispensable / candidato a eliminar) con su base legal
- Confirmación (o hallazgo de falla) de que el borrado es físico y no un flag lógico
- Lista priorizada de correcciones antes de salir a producción

---

## Errores comunes

| Error | Causa probable | Solución |
|-------|---------------|---------|
| El agente confirma "sí cumple" sin evidencia | Se le preguntó de forma genérica ("¿esto cumple la ley?") en vez de pedir el inventario estricto | Exigir siempre archivo:línea, base legal y endpoint de borrado por cada campo |
| Se confunde borrado lógico con borrado real | El endpoint solo cambia un `status` sin tocar la fila | Verificar con una consulta directa a la tabla tras invocar el borrado |
| Se ignoran campos "no obvios" (IP, geolocalización, metadata) | El inventario se limitó a nombre/email | Revisar también logs, headers capturados y metadata de dispositivo |
| El reporte no cita ubicación exacta | Se entregó una lista de conceptos en vez de referencias al código | Pedir explícitamente archivo y número de línea por cada hallazgo |

---

## Variaciones

**Variación A — Auditoría de terceros:** Extender el inventario a los proveedores externos (LLMs, analytics, CRMs) que reciben estos datos, verificando si tienen contrato de tratamiento de datos o si reentrenan modelos con la información enviada.

**Variación B — EIPD (Evaluación de Impacto):** Para flujos con decisiones automatizadas (scoring, filtrado), extender la auditoría a los 5 factores de la EIPD: descripción del flujo, finalidad legítima, juicio de necesidad, matriz de riesgos y controles de mitigación.

---

## Notas adicionales

Este skill no reemplaza asesoría legal — es una auditoría técnica que deja el proyecto listo para que un abogado revise con evidencia concreta en vez de descripciones vagas. El número de campos que arroje el reporte depende del proyecto auditado; no hay un conteo fijo esperado.

---

*Creado: 2026-09-05*
