# Bono: Forge Studio Lite — Estudio de Contenido Automatizado y Carruseles a Costo $0

> Repositorio oficial: [Carlos-Dominguez-faber/forge-studio-lite](https://github.com/Carlos-Dominguez-faber/forge-studio-lite)

**Forge Studio Lite** es la versión abierta y empaquetada del estudio de contenidos de Carlos Domínguez presentado en la sesión *De Vibe Coding a Vibe Marketing*. Permite a founders y equipos técnicos producir carruseles de Instagram (1080×1080 PNG) y composiciones multimedia de alto impacto a partir de código HTML + CSS determinístico capturado por Playwright, eliminando el diseño manual y reduciendo el costo de generación gráfica a **$0 USD**.

---

## 🛠️ Stack y Arquitectura Híbrida

El sistema opera dividiendo estratégicamente la carga pesada en la nube y el ensamblado determinístico en local:

| Capa | Herramienta | Rol en el pipeline | Costo |
|------|-------------|--------------------|-------|
| **Orquestación & Control** | Claude Code / Hermes CLI | Planificación de piezas, redacción de storyboards y gestión de loops | Tokens de contexto |
| **Render de Carruseles** | Playwright (Chromium Headless) | Captura de slides 1080×1080 desde HTML self-contained (~6s por 5 slides) | **$0** (Local) |
| **Composición de Video** | Hyperframes (de HeyGen) | Ensamble de animaciones, capas alfa, overlays y layouts tipo Photoshop en HTML | **$0** (Local) |
| **Procesamiento Audiovisual** | ffmpeg | Conversión de HTML a MP4, corrección estéreo y sincronización a 175 wpm | **$0** (Local) |
| **Voz & Doblaje Local** | VoiceBox (Qwen 1.7B) | Clonación de voz de 30s para comerciales y narración en local (Mac/Linux/Win) | **$0** (Local) |
| **Subtítulos & Pacing** | Whisper MLX | Transcripción de alta velocidad en Neural Engine de Apple Silicon | **$0** (Local) |
| **Generación Cloud (Opcional)** | Muapi / Higgsfield | Modelos de video (Seedance 2.0, Kling 3.0, Veo 3.1) e imagen (GPT-4o, Flux) | Pay-per-use ($2 - $9 por video) |
| **Stock Royalty-Free** | Pexels API / Unsplash | Inyección de fotografía contextual libre de derechos | **$0** (API gratuita) |

---

## 🚀 Instalación y Quickstart

```bash
# 1. Clona el repositorio oficial de Carlos Domínguez
git clone https://github.com/Carlos-Dominguez-faber/forge-studio-lite
cd forge-studio-lite

# 2. Ejecuta el instalador idempotente (valida Node 18+, Playwright Chromium y entorno)
./setup.sh

# Alternativa manual:
# npm install && npx playwright install chromium && cp .env.example .env

# 3. Renderiza el carrusel de ejemplo tipográfico (5 slides en ~6 segundos)
npm run carrusel -- examples/carousel-typographic
```

Los archivos PNG generados quedarán listos en `examples/carousel-typographic/slides/slide-01.png` a `slide-05.png`.

---

## 🎠 Las 3 Variantes de Carruseles

Las tres variantes pueden combinarse en un mismo carrusel (por ejemplo: hook tipográfico → desarrollo con fotos de stock → CTA final con foto del fundador):

1. **Variante (a) Typographic (Por defecto - $0):**
   - Fondo dark elegante, tipografía de alto contraste y *keyword highlighting* (`<span style="color: var(--primary);">clave</span>`).
   - Cero dependencias de APIs gráficas o consumo de créditos.
2. **Variante (b) Foto de Marca + Gradiente:**
   - Monta fotos locales de tu banco (`brand/photos/`) a sangre (*full-bleed*) con degradados oscuros inferiores y grano sutil para garantizar legibilidad perfecta del texto.
   - Ideal para slides de autoridad, retratos del creador o primeros planos de producto.
3. **Variante (c) Stock Royalty-Free:**
   - Descarga automática de imágenes libres de derechos desde Pexels o Unsplash API.
   - Perfecto para cubrir noticias del sector o conceptos abstractos sin diseñar nada a mano.

---

## 🔒 Flujo Guiado con Compuertas Obligatorias (*Gates*)

Aunque los carruseles son de costo $0, el pipeline impone un **gate de dirección editorial** para no perder tiempo ni tokens iterando código a ciegas:

```
[ INTAKE ] ──→ Confirma tema, objetivo, # slides y estructura narrativa
    │
    ▼
[ OUTLINE ] ──→ Escribe STORYBOARD.md (hook / desarrollo / prueba / cta)
    │
    ▼
[ COMPUERTA / GATE ] ──→ Claude pausa y muestra: [Aprobar y renderizar] / [Ajustar] / [Cancelar]
    │
    ▼
[ RENDER ] ──→ Genera slides HTML self-contained y corre Playwright
    │
    ▼
[ AUDITORÍA ] ──→ Subagente Brand Designer valida padding, contraste y legibilidad
```

---

## 🎨 Configuración de Marca (`brand/`)

Para que el agente produzca piezas alineadas con tu identidad sin volver a pedir instrucciones, configura 3 archivos en la carpeta `brand/`:

1. **`brand/brand.json`:** Define nombre, nicho, paleta de colores hexadecimales (primario, fondo, texto, bordes) y fuentes.
2. **`brand/voice.json`:** Tono de comunicación, palabras de gancho permitidas, términos prohibidos (*avoid*) y ritmo de lectura.
3. **`brand/brand.css`:** Variables CSS canónicas que el agente copia *inline* en cada slide para garantizar que sean auto-contenidos:
   ```css
   :root {
     --primary: #FF5500;
     --bg: #0D0E12;
     --surface: #171821;
     --text: #F3F4F6;
     --text-muted: #9CA3AF;
     --font-heading: 'Inter', -apple-system, sans-serif;
   }
   ```

---

## 👥 Equipo Creativo de Subagentes

En entornos de producción completos, el orquestador divide la validación en cuatro roles:
- **Director:** Conduce el flujo, asigna tareas y consolida el entregable final.
- **Estratega:** Asegura que el hook responda a la estructura narrativa elegida (Hook de curiosidad, Contrarian, Framework paso a paso, o Caso de estudio).
- **Crítico de Continuidad:** Evita saltos de ritmo visual y verifica que las tipografías y márgenes no varíen entre láminas consecutivas.
- **Brand Designer:** Inspecciona el código CSS de las slides para certificar contraste WCAG AA, padding seguro contra interfaces de Instagram (80px superior/inferior) y ausencia de *AI slop*.

---

## ⚠️ Errores Comunes y Soluciones

| Error | Causa | Solución |
|-------|-------|----------|
| **Texto cortado en Instagram** | Elementos ubicados en bordes extremos de la imagen | Mantener un padding de seguridad mínimo de 60-80px en todos los márgenes del slide |
| **Imágenes no cargan en Playwright** | Referencias a rutas relativas externas rotas | Embeber imágenes en Base64 o verificar rutas absolutas/locales auto-contenidas en el HTML |
| **Desfase de audio en videos** | Inconsistencia entre palabras por minuto del locutor y duración del clip | Calibrar el script a ~175 palabras/minuto antes de enviar a VoiceBox/ffmpeg |
| **Audio sale por un solo canal (mono)** | Grabación o export con canal apagado | Correr filtro ffmpeg con mapeo de canal duplicado para estéreo balanceado |
