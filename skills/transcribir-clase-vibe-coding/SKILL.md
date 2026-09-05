# SKILL: Transcribir y estructurar clase del curso Vibe Coding

> Guarda este archivo en `/skills/transcribir-clase-vibe-coding/SKILL.md`
> Adaptado de `transcribir-clase-curso` del repo `imperioagentico` — misma lógica, aplicada a este curso.

---

## Cuándo usar este skill

Cuando hay una clase nueva (grabación, audio, video o transcripción) del curso "Vibe Coding — Imperio Digital" que hay que convertir en un archivo Markdown consistente con las clases ya existentes en `curso-vibe-coding/clases/`.

---

## Prerequisitos

- [ ] Transcripción de la clase (texto plano, generada con `faster-whisper` u otra herramienta)
- [ ] Número de clase correspondiente (el siguiente disponible en `curso-vibe-coding/clases/`)
- [ ] Acceso de escritura al repo `vibe-coding`

---

## Pasos

### Paso 1 — Extraer la idea central

Lee la transcripción completa. Identifica en 2-4 frases cuál es el concepto único que esa clase enseña. Todo lo demás en el archivo sirve a esa idea, no al revés.

### Paso 2 — Definir el nombre de archivo

Formato: `clase-NN-slug.md`
- `NN`: número de clase con dos dígitos (`01`, `02`...)
- `slug`: 1-3 palabras clave del tema, minúsculas, sin tildes, separadas por guiones

### Paso 3 — Escribir el archivo con esta estructura exacta

```markdown
# Clase NN — [Título corto y descriptivo]

**Tags:** `Tag1` `Tag2` `Tag3` (2 a 4 tags, sustantivos concretos)
**Conecta con:** Clase X · Clase Y (1-3 clases relacionadas por tema)

---

## Idea central

[1 párrafo de 2-4 frases. La idea única de la clase, sin rodeos.]

---

## [Sección de contenido 1 — nombre descriptivo, no genérico]

[Tabla, lista o bloque de código: tablas para comparaciones,
código para configuración/comandos/prompts de ejemplo,
listas para pasos o conceptos enumerados.]

---

## [Sección de contenido 2 si aplica]

...

---

## 🎯 Ejercicio práctico

[Un solo consejo accionable y específico, aplicable la próxima vez que se use lo enseñado.]

**Ejercicio 1:** [Consigna concreta y acotada — 15-30 min, resultado verificable, usa solo lo visto hasta esa clase.]

**Ejercicio 2 (avanzado, opcional):** [Extiende el ejercicio 1.]

---

## 💡 Tip

[Un solo consejo accionable y específico.]

---

## ⚠️ Error común

[Un error real y específico, no una advertencia vaga: qué se hace mal + qué pasa como consecuencia.]
```

**Reglas de formato:**
- `---` separa cada sección de nivel `##` — nunca se omite
- Máximo 70-110 líneas por archivo. Si es más largo, está cubriendo dos temas y debería dividirse en dos clases
- Tablas de máximo 5-6 filas — más que eso, es una lista o hay que resumir
- Sin relleno: cada línea aporta información nueva, no repite lo de arriba con otras palabras
- Tono directo, español neutro, sin muletillas ni "en este video vamos a..."
- El **Ejercicio práctico es obligatorio**, no opcional como el Tip o el Error común
- El ejercicio nunca requiere una herramienta o concepto que no se haya visto todavía en el curso
- No inventar contenido que no esté en la fuente. Si algo no quedó claro, marcar `[PENDIENTE: confirmar con Juan]` en vez de rellenar con una suposición

### Paso 4 — Verificar replicabilidad antes de entregar

El objetivo no es "no perder nada" de la transcripción — es que el video ya no haga falta para replicar lo enseñado. Antes de dar la clase por terminada, revisar contra la fuente:

- Todo paso práctico, demo o acción en pantalla que el instructor haya mostrado (comandos exactos, clicks, configuración, nombres de archivos/botones) tiene que quedar **literal** en el contenido o en el Ejercicio práctico — no resumido de forma tan genérica que se vuelva irreproducible.
- Si la fuente muestra una secuencia de pasos concretos (ej. "abrí esto, hice clic acá, escribí este comando"), esa secuencia va como lista numerada o bloque de código, no como una frase narrativa tipo "el instructor configuró la herramienta".
- Preguntarse: *¿un alumno que solo lee este archivo, sin haber visto el video, puede ejecutar el mismo procedimiento y llegar al mismo resultado?* Si la respuesta es no en algún paso clave, ese paso está mal sintetizado — hay que ampliarlo, no dejarlo implícito.
- Esto no contradice el límite de 70-110 líneas ni la regla de "sin relleno": lo que se recorta es la verborrea y las repeticiones, nunca el detalle operativo de un paso que el alumno necesita para reproducirlo.

### Paso 5 — Actualizar los índices

En el mismo lote de cambios:
1. `README.md` (raíz) → agregar la fila a la tabla de "Clases"

---

## Outputs esperados

- 1 archivo `clase-NN-slug.md` en `curso-vibe-coding/clases/`, con la estructura exacta de arriba
- El índice raíz actualizado con la fila nueva
- Sin secciones extra fuera de la estructura

---

## Errores comunes

| Error | Causa probable | Solución |
|-------|---------------|---------|
| Archivo de 200+ líneas | Se transcribió todo literal en vez de sintetizar | Volver al Paso 1: encontrar la idea central y cortar lo que no la sirve |
| Falta el Ejercicio práctico | Se trató como sección opcional | Es obligatoria |
| Ejercicio requiere algo de una clase futura | No se revisó el orden del curso | Solo usar herramientas/conceptos ya cubiertos hasta esa clase |
| Índice no actualizado | Se creó el archivo pero no se tocó el README | Repetir el Paso 5 |
| Paso práctico narrado en vez de detallado (ej. "configuró el proyecto" sin decir cómo) | Se priorizó la síntesis por encima de la replicabilidad | Volver a la fuente y extraer el comando/click/configuración exacta que se mostró |

---

*Creado: 2026-09-04*
