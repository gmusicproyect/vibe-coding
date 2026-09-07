# Clase 12 — De Vibe Coding a Vibe Marketing

**Tags:** `Vibe Marketing` `Forge Studio` `Hyperframes` `Playwright`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 07](clase-07-ui-tokens.md) · [Clase 10](clase-10-agente-5usd-cloudflare.md) · Bono Forge Studio Lite

---

## Idea central

El *Vibe Marketing* traslada la filosofía del vibe coding a la producción audiovisual: el usuario formula la intención estratégica y los agentes orquestan la generación, composición y postproducción multimedia. Utilizando arquitecturas híbridas —generación en la nube para video e imágenes pesadas y procesamiento local determinístico a costo $0 con HTML, CSS, Playwright y ffmpeg— es posible crear piezas con calidad de agencia sin requerir software manual de edición.

---

## El Pipeline de 6 Fases (Forge Studio)

| Fase | Nombre | Función clave | Tecnología |
|------|--------|---------------|------------|
| **1** | **Estrategia** | Define hook, audiencia, ángulo y Call to Action (CTA) | Claude Code / Hermes + Wiki |
| **2** | **Storyboard** | Moodboard 3×3 y desglose de escenas para consistencia visual | Storyboard Markdown / Grid 9 paneles |
| **3** | **Generación** | Producción de fotos, video y audio con cascada de fallbacks | Muapi, Higgsfield, VoiceBox, Whisper MLX |
| **4** | **Composición** | Montaje multicapa, animaciones 3D, tipografía y canales alfa | Hyperframes (HTML + CSS determinístico) |
| **5** | **Renderizado** | Compilación a MP4, sincronización de pacing y audio estéreo | ffmpeg local (conversión HTML a video) |
| **6** | **Auditoría** | Revisión de brand alignment, solapamientos y desfaces | Subagentes especializados (Director, Diseñador) |

---

## El Equipo Creativo de Subagentes

El orquestador no trabaja solo; delega la validación en 4 subagentes especializados antes de entregar:
- **Director:** Planifica escenas, orquesta las llamadas y gestiona el loop de correcciones.
- **Estratega de Contenido:** Valida que el hook capture la atención en los primeros 3 segundos y define el CTA.
- **Crítico de Continuidad:** Detecta el *drift* visual entre tomas consecutivas y evalúa consistencia de personajes.
- **Brand Designer:** Audita la adherencia estricta a `brand.json`, `voice.json` y los contrastes cromáticos en CSS.

---

## El Stack Híbrido: Nube vs Local ($0)

Para mantener los costos bajo control, se divide el trabajo entre APIs cloud indispensables y motores locales gratuitos:

```
[ NUBE (Generación pesada) ]
  ├── Video: Seedance 2.0 (tomas complejas/money shots) · Kling 3.0 / Veo 3.1 Fast (b-rolls)
  ├── Imágenes & Música: Muapi (GPT-4o, Flux Context, mm-audio) · Higgsfield
  └── Stock Royalty-Free: Pexels API / Unsplash ($0) · Google Images con Apify

[ LOCAL (Composición y render a costo $0) ]
  ├── Voz & Audio: VoiceBox local (clonación TTS con Qwen 1.7B) · Pacing calibrado a 175 wpm
  ├── Transcripción & Captions: Whisper MLX en Neural Engine (Apple Silicon M-series / GPU)
  ├── Carruseles & Capturas: Playwright headless (Chromium 1080×1080 en ~6 segundos)
  └── Motor de Montaje: Hyperframes + ffmpeg (edición, corrección de canal estéreo y exportación)
```

---

## Las 3 Variantes de Carruseles (1080×1080)

1. **Typographic (Default - $0):** Fondo oscuro con tipografía contrastada y *keyword highlighting* con color primario. Cero llamadas a APIs de imagen.
2. **Foto de Marca:** Utiliza retratos del fundador o producto (`brand/photos/`) con gradientes alfa y viñetas que aseguran legibilidad inferior.
3. **Imágenes de Stock:** Búsqueda automática vía Pexels o Unsplash para ilustrar conceptos de actualidad a costo ínfimo o nulo.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Descarga la plantilla de carrusel tipográfico y genera con Claude Code un carrusel de 5 slides (1080×1080 px) para tu producto o servicio.
1. Crea tu archivo `brand/brand.css` con variables `--primary`, `--bg-color` y `--font-family`.
2. Redacta `STORYBOARD.md` con 5 slides: Slide 1 (Hook con impacto), Slides 2-4 (Puntos de valor con 1-2 palabras destacadas en `<span style="color: var(--primary);">`), Slide 5 (CTA final).
3. Pídele a Claude Code que escriba los 5 archivos `slide-01.html` a `slide-05.html` auto-contenidos (CSS inline) y ejecute el screenshot con Playwright para obtener los PNGs finales.

**Ejercicio 2 (Avanzado):** Crea un subagente auditor en Claude Code que inspeccione el código HTML de cada slide antes de renderizar y confirme que no existan más de 35 palabras por slide, que el contraste cumpla estándar WCAG AA y que los logos respeten el padding de 40px.

---

## 💡 Tip

Nunca delegues la tipografía o los textos a modelos de difusión de imagen (como Midjourney o Flux): generan inconsistencias y textos deformados. Renderiza siempre los textos mediante HTML y CSS limpio, usando las IAs generativas exclusivamente para los fondos o assets visuales.

---

## ⚠️ Error común

Gastar créditos en modelos de video pesados (como Seedance 2.0 a $8 USD por clip) para fondos simples o escenas de relleno. Configura tu agente con una política de fallbacks que use modelos livianos (Veo 3.1 Fast o Kling 3.0) para planos secundarios y reserve los modelos de alta fidelidad únicamente para las tomas protagónicas (*money shots*).
