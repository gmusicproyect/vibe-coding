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
- **Nunca usar notación LaTeX** (`$\rightarrow$`, `$\times$`, etc.) — GitHub no la renderiza y queda como texto crudo. Para flechas en rutas de menú usar el carácter simple `→`; para el resto, texto plano

### Paso 4 — Verificar replicabilidad antes de entregar

El objetivo no es "no perder nada" de la transcripción — es que el video ya no haga falta para replicar lo enseñado. Antes de dar la clase por terminada, revisar contra la fuente:

- Todo paso práctico, demo o acción en pantalla que el instructor haya mostrado (comandos exactos, clicks, configuración, nombres de archivos/botones) tiene que quedar **literal** en el contenido o en el Ejercicio práctico — no resumido de forma tan genérica que se vuelva irreproducible.
- Si la fuente muestra una secuencia de pasos concretos (ej. "abrí esto, hice clic acá, escribí este comando"), esa secuencia va como lista numerada o bloque de código, no como una frase narrativa tipo "el instructor configuró la herramienta".
- Preguntarse: *¿un alumno que solo lee este archivo, sin haber visto el video, puede ejecutar el mismo procedimiento y llegar al mismo resultado?* Si la respuesta es no en algún paso clave, ese paso está mal sintetizado — hay que ampliarlo, no dejarlo implícito.
- Esto no contradice el límite de 70-110 líneas ni la regla de "sin relleno": lo que se recorta es la verborrea y las repeticiones, nunca el detalle operativo de un paso que el alumno necesita para reproducirlo.

### Paso 5 — Verificar que el ejercicio prueba el propósito de la clase

No basta con que el ejercicio sea replicable — tiene que probar específicamente el concepto que la clase más enfatiza, no un concepto adyacente más fácil de ejercitar.

1. Identifica cuál es la afirmación central que se repite entre la Idea central, el Tip y el Error común (es la que el instructor insiste más en la fuente).
2. Verifica que el Ejercicio 1 ejercite exactamente esa afirmación, no una tarea relacionada pero más superficial. Ejemplo real de este curso: una clase insistía en que los hooks son "paredes infranqueables" en las que hay que confiar más que en instrucciones de texto, pero el ejercicio solo pedía cambiar una configuración de texto — nunca construir un hook. Eso es un ejercicio que no prueba el propósito, aunque sea replicable.
3. Si el ejercicio no ejercita la afirmación central, reescríbelo para que sí lo haga — aunque eso signifique que sea más largo o más técnico que el resto.

### Paso 5.5 — Autoverificación obligatoria antes de entregar (no delegar esto a Claude)

Este paso reemplaza la corrección manual que antes hacía Claude sobre cada clase entregada. A partir de ahora, quien procesa la transcripción (Google/Antigravity) tiene que dejar el archivo ya corregido — Claude solo aprueba o rechaza, no reescribe.

**A. Checklist estructural — compara literalmente contra este esqueleto antes de guardar:**
- [ ] Título usa `—` (em dash), no `:` — `# Clase NN — Título`
- [ ] Tiene la línea `**Tags:**` con 2-4 tags
- [ ] Tiene la línea `**Conecta con:**` con 1-3 clases relacionadas (revisar `curso-vibe-coding/clases/` para encontrar conexiones reales por tema, no inventar)
- [ ] El encabezado del ejercicio es exactamente `## 🎯 Ejercicio práctico` (con emoji)
- [ ] El encabezado del tip es exactamente `## 💡 Tip` (con emoji, nunca "Tip pro" ni variantes)
- [ ] El encabezado del error es exactamente `## ⚠️ Error común` (con emoji)
- [ ] Cada sección de nivel `##` está separada por `---`
- [ ] Ningún bloque de código presenta como literal (import exacto, nombre de paquete, parámetros exactos) algo que la fuente solo describió de palabra sin mostrarlo en pantalla — si no se vio el código, se describe en prosa o se marca `[PENDIENTE: confirmar sintaxis exacta]`

Si un solo ítem de esta lista falla, el archivo no está listo — corregirlo antes de entregar, no después.

**B. Autoverificación de exactitud factual — antes de escribir cualquier comparación, tabla o cifra, vuelve a la transcripción y confirma:**
- Si hay una tabla comparando dos cosas (dos modelos, dos configuraciones, dos variantes de una herramienta), **cada celda tiene que estar atada a la variante correcta**. Error real que ya pasó: una clase comparaba "Modelo A" vs "Modelo B" y la fila de velocidad decía que B fue más rápido en general, cuando en realidad solo una de las dos sub-variantes de B fue más rápida — la otra fue la más lenta de todas. No agrupar ni promediar variantes distintas en una sola celda si la fuente las trató por separado.
- No atribuir a un elemento un mérito o defecto que en la fuente lo tuvieron ambos por igual (ej. decir "solo A validó X" cuando la transcripción muestra que A y B validaron X correctamente).
- Cifras, nombres técnicos y resultados de pruebas en vivo (tiempos, tokens, cantidad de pruebas, cantidad de personas/países en un caso real) deben copiarse tal cual aparecen en la fuente, no redondear ni inventar para que suene mejor.
- Si un término suena a jerga de marketing o industria (ej. "money shots", "primeros 3 segundos") pero no se pronunció literalmente en la fuente, no presentarlo como si el instructor lo hubiera dicho — usar una descripción neutra del mismo concepto o marcarlo como interpretación propia.

### Paso 6 — Actualizar los índices

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
| Índice no actualizado | Se creó el archivo pero no se tocó el README | Repetir el Paso 6 |
| Paso práctico narrado en vez de detallado (ej. "configuró el proyecto" sin decir cómo) | Se priorizó la síntesis por encima de la replicabilidad | Volver a la fuente y extraer el comando/click/configuración exacta que se mostró |
| Ejercicio replicable pero que no prueba lo central de la clase | Se eligió la tarea más fácil de ejercitar en vez de la que el instructor más enfatizó | Aplicar el Paso 5: identificar la afirmación que se repite en Idea central/Tip/Error común y asegurarse de que el ejercicio la ejercite directamente |
| Título con `:` en vez de `—`, faltan Tags/Conecta con, o encabezados sin emoji | No se comparó el archivo final contra el esqueleto exacto del Paso 3 | Aplicar el checklist del Paso 5.5.A antes de guardar, no después |
| Tabla comparativa atribuye un resultado a la variante equivocada (ej. "Fable fue más rápido" cuando solo una de sus dos sub-variantes lo fue) | Se promedió o agrupó información que la fuente trató por separado | Releer la transcripción por cada celda de la tabla; nunca generalizar de una sub-variante a la categoría completa |
| Código o sintaxis exacta (imports, nombres de parámetros) presentada como si fuera literal de la fuente, cuando el instructor solo lo describió de palabra | Se completó el hueco con una reconstrucción plausible en vez de marcarla como tal | Aplicar el Paso 5.5.A: si no se vio en pantalla, describir en prosa o usar `[PENDIENTE: confirmar sintaxis exacta]` |
| Detalle o cifra que suena verosímil pero no aparece en la transcripción (ej. un término de marketing, un porcentaje, un límite técnico) | Se rellenó con conocimiento general del tema en vez de ceñirse a lo dicho en la fuente | Aplicar el Paso 5.5.B: cada cifra y término técnico se coteja contra la transcripción antes de escribirlo |

---

*Creado: 2026-09-04*
