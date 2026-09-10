# Clase 32 — Mejores Prácticas, Metaprompting y Maquetación del MVP

**Tags:** `Metaprompting` `PRD` `Google AI Studio` `Antigravity`
**Conecta con:** [Clase 27](clase-27-vibe-coding-antigravity-de-idea-a-deploy.md) · [Clase 28](clase-28-instalacion-configuracion-antigravity.md) · [Clase 31](clase-31-primera-win-clon-linktree-antigravity.md)

---

## Idea central

Antes de tocar Antigravity, el trabajo serio empieza con metaprompting: usar IA para refinar una idea vaga en un PRD (Product Requirements Document) claro y ejecutable, que se convierte en la "biblia" que evita que el agente invente funcionalidades. Con ese PRD se maqueta primero el MVP en Google AI Studio (solo UI/UX y estructura, sin funcionalidad real) y luego se lleva a Antigravity con control de versiones en GitHub, trabajando siempre por *features* pequeños y no como una sola tarea gigante.

---

## 1. Metaprompting y el PRD

- **Metaprompting:** método para refinar prompts con IA. En lugar de escribir un prompt a mano y esperar que funcione, le pides a la IA que analice tu idea, identifique huecos o ambigüedades, y te genere el mejor prompt posible para construir el producto. El Gem usado en el curso para esto ("Artemis") tiene su [catálogo completo de capacidades documentado aparte](../../recursos/gems/artemis-catalogo-capacidades.md).
- **PRD (Product Requirements Document):** documento que define visión y objetivo, problema que resuelve, público objetivo, funcionalidades, restricciones, criterios de aceptación, prioridades, métricas de éxito, flujos de usuario, *user stories* (quién, cómo, qué) y tech stack.
- **Por qué importa:** en vibe coding el PRD no es "algo bonito" — es la referencia principal para que el agente no invente. Mientras más claro y estructurado desde el inicio, mejores resultados.
- **Ejemplo trabajado en la clase:** *Automation Opportunity Finder*, una app para que freelancers y agencias diagnostiquen negocios, detecten oportunidades de automatización con IA y generen recomendaciones, precios y siguientes pasos para vender servicios.

---

## 2. Cinco Reglas para Trabajar con Agentes

| Regla | Qué evitar | Qué hacer en su lugar |
| :--- | :--- | :--- |
| **1. Trabaja por features** | "Hazme toda la aplicación" | Divide el proyecto en piezas (ej. Auth con Supabase, Dashboard, Wizard de diagnóstico, Clientes, Cotizaciones) y asigna cada una como tarea independiente. |
| **2. Trátalo como equipo real** | Una sola conversación interminable haciendo todo | Un agente por feature, otro por bug, otro por refactor — usa el Agent Manager en ciclos cortos con objetivos claros. |
| **3. Primer prompt: "analiza el proyecto"** | Pedir cambios antes de que el agente entienda el sistema | Que primero lea carpetas y archivos, entienda el stack y pregunte lo que no le quedó claro. |
| **4. Especifica objetivo y límites** | Dejar que el agente decida qué tocar sin restricción | Define qué lograr, qué archivos puede editar y qué NO debe cambiar; revisa el diff antes de aceptar. |
| **5. Usa guías internas al escalar** | Repetir lineamientos de auth/UI/testing en cada prompt | Archivos markdown/reglas internas de Antigravity que el agente consulta automáticamente. |

---

## 3. Flujo de Maquetación: De la Idea al MVP Versionado

1. **Generar el PRD:** se pasa la idea por un [Gem de Gemini entrenado para generar PRDs de vibe coding](https://gemini.google.com/gem/f3be5f5276c7), que entrega visión, tech stack sugerido y *user stories*.
2. **Revisar y corregir:** el PRD generado se ajusta manualmente (ej. cambiar el modelo de IA sugerido si no conviene).
3. **Maquetar en Google AI Studio:** se copia el PRD junto con una imagen de referencia visual (tomada de Dribbble) y se pide explícitamente que el objetivo de esta primera iteración es solo la estructura del proyecto y el UI, no desarrollar todos los features completos.
4. **Iterar rápido en la maqueta:** traducir la interfaz a español, ajustar el tech stack mostrado dentro de la app, validar formularios (ej. no avanzar sin nombre), crear una pantalla real de configuración con modo oscuro/claro, y confirmar que funciones agregadas (como grabación de audio) muestren evidencia clara de que se guardaron y analizaron.
5. **Versionar en GitHub:** conectar el proyecto de Google AI Studio a un repositorio y hacer commits descriptivos por cada tanda de cambios (ej. commit inicial, commit de ajustes de UI, commit de traducción y validaciones).
6. **Continuar en Antigravity:** una vez que la maqueta está lista y versionada, el desarrollo funcional real continúa ahí, aplicando las cinco reglas de la sección anterior.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Usa el Gem de generación de PRD para convertir una idea de aplicación propia en un documento con visión, público objetivo, funcionalidades y tech stack. Revísalo y corrige al menos un punto que no te convenza (ej. el modelo de IA sugerido). Copia el PRD corregido junto con una imagen de referencia de Dribbble a Google AI Studio y pide explícitamente que la primera iteración se limite a estructura y UI, sin funcionalidad completa.

**Ejercicio 2 (avanzado, opcional):** Conecta el proyecto generado en Google AI Studio a un repositorio de GitHub, haz un commit inicial, aplica al menos un cambio de iteración (ej. traducir la interfaz o agregar una validación de formulario) y haz un segundo commit describiendo exactamente qué cambiaste.

---

## 💡 Tip

Cuando abras el proyecto maquetado en Antigravity por primera vez, no le pidas cambios de inmediato. El primer prompt debe ser que analice todo el proyecto —carpetas, archivos, PRD, tech stack— y te pregunte lo que no le quedó claro antes de tocar una sola línea. Esto evita que el agente asuma decisiones arquitectónicas equivocadas desde el arranque.

---

## ⚠️ Error común

Confundir la maqueta generada en Google AI Studio con una aplicación funcional terminada. El objetivo de esa primera etapa es únicamente definir UI/UX, estructura del proyecto, rutas y componentes — no que todo funcione perfecto. La funcionalidad real (autenticación, análisis con IA, conexiones a base de datos) se completa después, en Antigravity, trabajando por features.
