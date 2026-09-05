# SKILL: Diseñar UI sin AI Slop (Tokens en 3 capas y Criterio)

> Guarda este archivo en `/skills/disenar-ui-antislop/SKILL.md`
> y referencíalo en tu CLAUDE.md para que Claude Code lo use.

---

## Cuándo usar este skill

Cuando el usuario pida diseñar una nueva interfaz, maquetar componentes, crear una landing page o refactorizar el diseño de una aplicación web o PWA para eliminar el "AI Slop" (diseño genérico de IA: morado `indigo-500`, Inter por defecto, cards idénticas y emojis).

---

## Prerequisitos

- [ ] Proyecto web con Tailwind CSS (idealmente v4) o CSS modular.
- [ ] Librería de iconos SVG instalada (ej. `npm i lucide-react`).
- [ ] Opcional: `agentation` instalado para capturar feedback visual sin quemar tokens.

---

## Pasos

### Paso 1 — Establecer el contrato de tokens en 3 capas

Antes de escribir código JSX o componentes de interfaz, define la arquitectura de tokens unidireccional:

1. **Capa 1 (Primitivos):** La paleta cruda de valores (`--color-slate-900: #0f172a`, `--radius-sm: 4px`, `--font-sans: 'Inter'`).
2. **Capa 2 (Semánticos):** El rol funcional en la app (`--color-primary: var(--color-slate-900)`, `--color-surface: #ffffff`).
3. **Capa 3 (Componentes):** El enlace exclusivo al elemento (`--btn-bg-primary: var(--color-primary)`).

```css
/* Ejemplo en globals.css con Tailwind v4 @theme */
@theme {
  --color-primary: #0f172a;
  --color-accent: #f59e0b;
  --color-surface: #ffffff;
  --radius-default: 8px;
}
```

> **Regla de oro:** Prohibido apuntar de Capa 1 directo a Capa 3 o usar valores hexadecimales sueltos en el JSX.

### Paso 2 — Aplicar el gate anti-slop

Revisa el código y bloquea de forma determinista los 5 vicios habituales de la IA:

1. **Anti-Morado:** Prohibido usar tonos en el rango Hue 235 a 285 (`bg-indigo-500`, `bg-purple-600`) como color primario o de fondo.
2. **Control tipográfico:** Máximo 2 familias tipográficas en todo el proyecto (una editorial/display para H1/H2 y una de lectura para el cuerpo).
3. **Control de radios:** Máximo 3 valores de `border-radius` permitidos en todo el sistema.
4. **Cero emojis en la UI:** Reemplaza emojis crudos (ej. 🚀, 💡, ⭐) por iconos vectoriales de `lucide-react` con tamaño y color heredados.
5. **Jerarquía HTML:** Máximo un solo `<h1>` por vista; jerarquía clara de `<h2>`, `<h3>` y párrafos para optimización de accesibilidad y SEO.

### Paso 3 — Desplegar el Showcase visual (UI Kit)

Antes de construir las páginas finales, levanta una ruta interna (`/showcase`) para verificar que los componentes respondan a los tokens:

- **Botones:** Estados default, hover, active, loading y disabled.
- **Formularios:** Inputs de texto, selectores y estados de error/validación.
- **Feedback:** Toasts flotantes, tooltips y diálogos modales.
- **Empty states:** Pantallas vacías con mensaje de contexto y botón de acción (nunca pantalla en blanco).

### Paso 4 — Solicitar componentes por su nombre técnico

Al interactuar o pedir nuevos elementos a Claude Code, utiliza los identificadores estándar:
- `toast` en vez de "aviso flotante temporal".
- `segmented-control` en vez de "barrita de opciones redondeadas".
- `bottom-sheet` en vez de "cajón que sube de abajo".
- `pagination-dots` en vez de "puntitos del carrusel".
- `dialog` o `alert-dialog` en vez de "ventana de confirmación".

### Paso 5 — Capturar feedback visual con Agentation

Para iterar sobre la interfaz en entorno local (`localhost`):
1. Usa el componente `agentation` para seleccionar con un clic el elemento exacto del DOM.
2. Copia el bloque de feedback generado (viewport, selector CSS y sugerencia textual).
3. Pégalo directamente a Claude Code en vez de adjuntar capturas de pantalla que consumen miles de tokens de visión.

---

## Outputs esperados

Al terminar este skill, el resultado debe ser:
- Archivo de tokens de diseño configurado en CSS (`@theme`) o `brand.json` sin valores hex dispersos.
- Vistas libres de patrones de AI Slop (sin morados genéricos, sin emojis en controles y con jerarquía tipográfica).
- Componentes modulares referenciando únicamente tokens semánticos de Capa 2.

---

## Errores comunes

| Error | Causa probable | Solución |
|-------|---------------|---------|
| La app vuelve a verse morada | La IA recurre al valor por defecto de Tailwind | Imponer la paleta semántica explícitamente en el prompt o archivo de tokens |
| Un cambio de color no afecta a todos los botones | Se hardcodearon clases utilitarias directas en el JSX | Refactorizar el botón para que dependa de la variable `--btn-bg-primary` |
| La página se siente caótica | Múltiples border-radius y fuentes mezcladas | Forzar el límite de máximo 3 radios y 2 familias tipográficas en el CSS global |
| Se queman tokens rápidamente en ajustes visuales | Se envían screenshots para pedir cambios de márgenes | Usar `agentation` o selectores CSS textuales para dar feedback puntual |

---

## Notas adicionales

La calidad visual de una aplicación generada con Vibe Coding no depende del azar de la LLM, sino de los límites que se le imponen mediante contratos deterministas antes de picar código.

---

*Creado: Septiembre 2026 · Vibe Coding — Imperio Digital*
