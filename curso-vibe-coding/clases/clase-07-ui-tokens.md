# Clase 07 — UI que no grita IA: componentes y design tokens

**Tags:** `UI Design` `Design Tokens` `Tailwind v4` `Anti-Slop`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 02](clase-02-tunear-claude-code.md) · [Clase 04](clase-04-adversarial-review.md)

---

## Idea central

La inteligencia artificial no diseña por intención: produce la mediana estadística de su corpus, generando interfaces clónicas ("AI Slop") caracterizadas por tonos morados (`bg-indigo-500`), tipografía Inter uniforme, cards genéricas y emojis en lugar de iconos. Romper este patrón exige reemplazar peticiones vagas por nombres técnicos precisos de componentes, establecer un contrato estricto de Design Tokens en tres capas (Primitivos, Semánticos y Componentes) y construir un Showcase visual (UI Kit) antes de programar la lógica del producto.

---

## Anatomía del AI Slop vs. Especificación técnica

| Síntoma de AI Slop | Causa técnica en el LLM | Solución en contrato de diseño |
|--------------------|-------------------------|--------------------------------|
| **Morado genérico** | `bg-indigo-500` predefinido históricamente en Tailwind. | Paleta de tokens semánticos (Hue fuera de 235-285). |
| **Monocultivo tipográfico** | Selección por defecto de la fuente Inter en todo el DOM. | Máximo 2 familias: 1 display para títulos y 1 legible para body. |
| **Estructura fija 3 cards** | Distribución estandarizada de landing pages en su corpus. | Layout asimétrico según jerarquía de datos del producto. |
| **Radio idéntico en todo** | `border-radius: 16px` aplicado a todas las esquinas. | Máximo 3 valores de radio en todo el sistema (ej. 4px, 8px, 12px). |
| **Uso de emojis crudos** | Atajo para no importar paquetes de iconos en el código. | Librería de iconos SVG unificada (ej. `lucide-react`). |

---

## Catálogo de componentes: Di las cosas por su nombre

Para ahorrar tokens y evitar ambigüedades, solicita a Claude Code los componentes por su identificador exacto de UI:

- **Pagination Dots / Page Indicator:** Indicador secuencial de puntos para carruseles o wizards.
- **Toast:** Notificación emergente temporal y flotante que desaparece sola.
- **Segmented Control:** Barra de alternancia horizontal de opciones mutuamente excluyentes.
- **Dialog / Alert Dialog:** Modal bloqueante para confirmación crítica de acciones (ej. eliminar).
- **Bottom Sheet:** Panel contenedor deslizable que sube desde el borde inferior de la pantalla.
- **Tooltip:** Micro-etiqueta informativa desplegada al hacer hover sobre un control.
- **Hamburger Menu:** Botón de tres líneas que despliega el menú de navegación en móvil.

> **Herramientas de extracción visual:** Usa **`styles.design`** para descargar archivos `design.md` y variables CSS de webs de referencia, y la extensión de Chrome **`Design Style Extractor`** para clonar tokens de cualquier URL directo a tu repo.

---

## Arquitectura de Design Tokens en 3 capas

El contrato de diseño se estructura en tres niveles de abstracción unidireccionales (la lata, la etiqueta y la pared):

```
Capa 1: Primitivos    -->  Valores crudos sin contexto (#0F172A, 12px, Inter)
       ↓
Capa 2: Semánticos     -->  Propósito funcional (color-primary, surface-muted)
       ↓
Capa 3: Componentes    -->  Enlace de UI específico (button-bg-primary: var(--color-primary))
```

### Reglas duras del contrato (`Tailwind v4 @theme`)

1. **Dependencia estricta en un solo sentido:** La Capa 3 solo puede referenciar a la Capa 2; la Capa 2 referencia a la Capa 1. Prohibido apuntar de Capa 1 directo a Capa 3.
2. **Cero valores hex o px sueltos:** Ningún componente JSX o CSS puede incluir colores o medidas directas fuera del catálogo de tokens.
3. **Límites de coherencia visual:** Máximo 3 valores de `border-radius` y máximo 2 familias tipográficas en toda la aplicación.
4. **Validación determinista:** Integra un script de verificación en tu pipeline que devuelva `exit 0` en pass y `exit 1` en fail si detecta tokens ilegales o tonos en la zona prohibida (Hue 235-285).

---

## Brand DNA, Showcase (UI Kit) y captura con Agentation

Antes de codificar vistas funcionales, Carlos recomienda generar el ADN del sistema y probarlo en un entorno aislado:

1. **Archivos de contrato:** Define `brand.json` (geometría, densidades y paleta), `voice.json` (estilo editorial, tuteo y términos seguros) y `motion.json` (duración en ms, easing y respeto a `prefers-reduced-motion`).
2. **Showcase visual (`/showcase` o `/add-uikit`):** Despliega una página interna con todos los estados visuales del sistema: botones (default, hover, loading, disabled), inputs con estados de error, tablas, badges y **empty states** con llamada a la acción explícita (nunca pantalla en blanco).
3. **Feedback visual con `agentation`:** Activa la librería `agentation` en entorno local (`localhost`). Permite hacer click sobre cualquier elemento del navegador para generar un bloque de texto con el viewport, selector CSS y comentario exacto, pegándolo directo a Claude Code sin quemar tokens analizando capturas de pantalla.
4. **Skills y ecosistema recomendado:** Plugin oficial `/plugin install frontend-design` (Anthropic), paquete NPX `hallmark` con gates anti-slop, `impeccable` con 446 reglas deterministas (`critique` / `polish`), y el repo **`criterio`** de Carlos para entrevistas y auditorías automáticas de UI.

---

## 🎯 Ejercicio práctico

**Ejercicio 1 (Auditoría anti-slop de tu proyecto):**
1. Inspecciona el archivo de estilos global (`globals.css` o configuración de Tailwind) y busca colores hexadecimales o clases de tono morado (`indigo-500`, `purple-600`).
2. Crea un archivo `brand.json` con la estructura de tokens en 3 capas (Primitivos, Semánticos y Componentes), asignando un color primario propio fuera del rango Hue 235-285.
3. Pídele a Claude Code:
   ```text
   Revisa el proyecto contra brand.json. Reemplaza todos los colores hex directos por tokens semánticos de Capa 2 y sustituye emojis en botones o tarjetas por iconos de lucide-react.
   ```

**Ejercicio 2 (Generar el Showcase visual):**
Crea una ruta `/showcase` en tu aplicación Next.js donde se rendericen todos los botones con sus 4 estados (default, hover, loading, disabled). Modifica el token `color-primary` en tu CSS y verifica que los botones se actualicen instantáneamente sin tocar su código JSX.

---

## 💡 Tip

No envíes capturas de pantalla a Claude Code para ajustar espaciados o botones. Instala `agentation` o utiliza el inspector integrado de Claude Desktop para copiar las coordenadas y el selector exacto del componente en texto plano; ahorrarás entre 1.000 y 3.000 tokens por iteración visual.

---

## ⚠️ Error común

Pedir a la IA *"hazme un diseño moderno y limpio"* sin entregarle un contrato previo. La IA interpretará la solicitud desde su mediana estadística, devolviendo un fondo morado, cards con radio de 16px y emojis decorativos. El buen gusto no se pide en lenguaje natural: se impone mediante tokens y reglas deterministas de build.
