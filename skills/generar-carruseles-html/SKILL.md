# SKILL: Generar Carruseles HTML Determinísticos a Costo $0

> Guarda este archivo en `/skills/generar-carruseles-html/SKILL.md`
> y referencíalo en tu CLAUDE.md para que Claude Code lo use en tareas de marketing de contenidos.

---

## Cuándo usar este skill

Cuando el usuario solicite crear un carrusel para Instagram o LinkedIn de 3 a 10 slides (formato cuadrado 1080×1080 PNG), transformar un artículo/hilo en slides visuales, o generar creativos sin recurrir a diseño manual en Canva ni consumir créditos de modelos generativos de imagen.

---

## Prerequisitos

- [ ] Node.js 18+ instalado
- [ ] Playwright con navegador Chromium (`npx playwright install chromium`)
- [ ] Repositorio o scripts de renderizado de `forge-studio-lite` disponibles
- [ ] Variables de marca configuradas en `brand/brand.css`, `brand/brand.json` y `brand/voice.json` (o usar tokens por defecto)
- [ ] API Key de Pexels o Unsplash (opcional, solo para variante de fotos de stock)

---

## Pasos

### Paso 1 — Intake y Selección de Estructura Narrativa
Identifica el tema central, público objetivo, número de slides (ideal: 5 a 7) y selecciona la estructura narrativa adecuada:
- **Hook Contrarian:** Refuta una creencia común de la industria → Demuestra el error → Revela la alternativa → Pasos prácticos → CTA.
- **Framework Paso a Paso:** Promesa de resultado rápido → Pasos secuenciales 1 a N con ejemplos → CTA de guardado.
- **Caso de Estudio / Transformación:** Situación inicial problemática → El punto de quiebre → La metodología implementada → Resultados medibles → CTA.
- **Curaduría / Noticias:** Gran anuncio o titular → Por qué importa → Desglose de 3 claves → Impacto futuro → CTA.

### Paso 2 — Redacción del Storyboard (`STORYBOARD.md`)
Escribe el archivo `STORYBOARD.md` dentro de la carpeta del proyecto (`./carousels/<slug>/`):
- Asigna un rol específico a cada slide: `hook`, `problema`, `solución`, `desarrollo`, `prueba`, `cta`.
- Limita el copy a un máximo de 25-35 palabras por slide. Menos texto = mayor impacto.
- Identifica 1 a 3 palabras clave por slide para resaltar (*keyword highlighting*).

### Paso 3 — Compuerta Obligatoria de Aprobación (*Gate*)
Presenta el outline completo al usuario antes de generar código HTML:
```
He estructurado el carrusel de [N] slides bajo el framework [Nombre].
- Slide 1 (Hook): [Copy principal]
- Slide 2: [Punto clave]
...
- Slide N (CTA): [Llamado a la acción]

¿Deseas proceder con el renderizado de los slides HTML, o prefieres ajustar el copy?
```
Espera la confirmación explícita del usuario antes de pasar al paso siguiente.

### Paso 4 — Generación de Slides HTML Auto-contenidos
Crea cada archivo `slides/source/slide-NN.html` cumpliendo estas reglas estrictas:
- **Dimensiones fijas:** `width: 1080px; height: 1080px; overflow: hidden;` en `html, body, .slide`.
- **CSS Inline:** Copia directamente los tokens de `brand/brand.css` dentro de la etiqueta `<style>` de cada slide (garantiza portabilidad sin enlaces relativos rotos).
- **Keyword Highlighting:** Envuelve las palabras clave en `<span style="color: var(--primary);">palabra</span>`.
- **Márgenes de seguridad:** Padding mínimo de `80px` arriba/abajo y `60px` a los costados para no chocar con la UI de Instagram (nombre de usuario, paginador, botón de guardar).
- **Píldora de marca (Brand Pill):** Incluye una insignia sutil en la parte superior izquierda (`top: 40px; left: 60px`) con el identificador de la marca.
- **Slide de CTA:** Reserva la última slide para el cierre con avatar o logo oficial y llamado a comentar, guardar o seguir.

### Paso 5 — Renderizado Headless con Playwright
Ejecuta el pipeline de renderizado local para capturar los PNGs:
```bash
npx tsx src/pipelines/carousel.ts ./carousels/<slug>
# o si usas el script de npm:
npm run carrusel -- ./carousels/<slug>
```
Playwright levantará una instancia Chromium headless a 1080×1080 con device scale factor 2x para nitidez retina, capturando cada slide como PNG determinístico en segundos.

### Paso 6 — Verificación de Calidad
Comprueba que:
1. No exista desborde de texto (*overflow*) ni scrollbars visibles.
2. Las imágenes (si aplica) cargaron correctamente sin errores 404.
3. El contraste cromático entre texto y fondo sea superior a 4.5:1.
4. Los archivos `slide-01.png` a `slide-NN.png` se encuentren en la carpeta de salida.

---

## Outputs esperados

- Archivo `./carousels/<slug>/STORYBOARD.md` documentando la narrativa.
- Código fuente `./carousels/<slug>/slides/source/slide-01.html` a `slide-NN.html`.
- Imágenes PNG finales `./carousels/<slug>/slides/slide-01.png` a `slide-NN.png` listas para subir a redes sociales.

---

## Errores comunes

| Error | Causa | Solución |
|-------|-------|----------|
| Fuentes tipográficas no cargan | Uso de fuentes del sistema no instaladas en la máquina o enlaces web bloqueados | Usar fuentes web seguras de Google Fonts (`@import`) o el stack nativo (`system-ui, sans-serif`) |
| Texto montado sobre la foto | Falta de máscara de contraste en la variante de imagen | Añadir una capa con gradiente CSS (`background: linear-gradient(to top, rgba(0,0,0,0.9) 0%, transparent 60%)`) |
| Imágenes deformadas en Playwright | Propiedad `object-fit` ausente | Aplicar siempre `object-fit: cover; width: 100%; height: 100%;` a las fotos de fondo |
| Renderizado borroso en pantallas móviles | Captura en 1x sin factor de escala | Configurar Playwright con `deviceScaleFactor: 2` para exportar a 2160×2160 y escalar limpio |

---

## Variaciones

**Variación A — Typographic (Por defecto - $0):** Fondo sólido oscuro o con gradiente geométrico sutil. Ideal para hilos técnicos, reflexiones de negocio y listas de herramientas.

**Variación B — Foto de Fundador / Producto:** Incorpora fotografías desde `brand/photos/` usando viñeta oscura para ubicar el texto en la zona inferior. Ideal para slides de opinión personal y credibilidad.

**Variación C — Noticias con Stock:** Usa llamadas a la API de Pexels buscando imágenes por término clave (ej. "server", "artificial intelligence") y las inyecta de fondo automáticamente.

---

## Notas adicionales

El éxito de un carrusel radica en la retención slide a slide: el slide 1 debe detener el scroll con un título irresistible; los slides intermedios deben entregar una sola idea clara por pantalla; y el slide final debe pedir una acción concreta (generalmente "Guarda este post" o "Comenta X para recibir Y").

---

*Creado: 2026-09-07 · Basado en Forge Studio Lite por Carlos Domínguez*
