# SKILL: Procesar una transcripción nueva (instrucción maestra)

> Guarda este archivo en `/skills/procesar-transcripcion/SKILL.md`
> Instrucción de referencia fija para CUALQUIER transcripción nueva del curso Vibe Coding.
> No hace falta pedir una instrucción distinta cada vez — basta con decir "aplica el flujo estándar" y adjuntar la transcripción.
> Adaptado de `procesar-transcripcion` del repo `imperioagentico`.

---

## Cuándo usar este skill

Siempre que llegue una transcripción cruda (grabación, audio, notas) de una clase del curso "Vibe Coding — Imperio Digital" para integrarla al repo `vibe-coding`.

---

## Prerequisitos

- [ ] Transcripción cruda del contenido
- [ ] Acceso de lectura a `curso-vibe-coding/clases/` y `skills/` para no duplicar algo que ya existe
- [ ] Acceso de escritura al repo local (sin permiso de commit/push — ver Paso 2)

---

## Pasos

### Paso 0 — Aplicar la estructura de clase

Usar `skills/transcribir-clase-vibe-coding/SKILL.md` como estructura de referencia. Si en el futuro aparece contenido de una herramienta o integración específica (equivalente a los "bonos" de imperioagentico), avisar explícitamente en el reporte para decidir si se crea una carpeta `bonos/` en este repo — no crearla sin avisar primero.

### Paso 1 — Actualizar el índice

En el mismo lote de cambios, agregar la fila de la clase nueva a la tabla de "Clases" en `README.md` (raíz).

### Paso 2 — No commitear ni hacer push

Dejar todos los archivos nuevos/modificados en el working tree del repo local, sin commit. La responsabilidad de revisar, corregir y aprobar el resultado final antes de subirlo a GitHub es de Claude.

### Paso 3 — Reportar en texto plano, sin repegar contenido

Al terminar, reportar en 1-2 líneas **cada archivo que se creó, modificó, movió o eliminó** — nombre, categoría, y de qué trata. Nunca repegar el contenido completo de los archivos en el chat.

**El reporte tiene que ser exhaustivo, sin excepción**, y es un entregable obligatorio en sí mismo — no basta con dejar los archivos correctos en el working tree. Antes de entregarlo, correr `git status` y verificar que cada línea de salida tenga su fila correspondiente en el reporte.

---

## Outputs esperados

- Archivo(s) de clase nuevos en el repo, siguiendo `transcribir-clase-vibe-coding`
- Índice raíz actualizado en el mismo lote
- Un reporte exhaustivo (no el contenido) listo para que Claude revise con `git diff`
- Cero commits, cero pushes

---

## Errores comunes

| Error | Causa probable | Solución |
|-------|---------------|---------|
| Se hizo commit/push | No se respetó el Paso 2 | Dejar los cambios sin commitear siempre |
| Se repegó el archivo completo en el reporte | No se respetó el Paso 3 | Reportar solo el resumen |
| El reporte omitió archivos que sí se tocaron | No se corrió `git status` antes de reportar | Verificar el reporte contra `git status` línea por línea antes de entregarlo |
| Se creó una carpeta `bonos/` sin avisar | Contenido de herramienta específica tratado como clase normal | Avisar en el reporte y esperar confirmación antes de crear la carpeta |

---

## Notas adicionales

Este skill reemplaza tener que pedir una instrucción distinta cada vez. Es el punto de entrada único para este repo: cualquier transcripción nueva sigue clasificación → estructura → índice → entrega sin commit.

---

*Creado: 2026-09-04*
