# Clase 29 — Dominando Google AntiGravity: El Manual del 1%

**Tags:** `Antigravity` `Agentes` `MCP` `Workflows`
**Conecta con:** [Clase 25](clase-25-antigravity-claude-code-openclaw.md) · [Clase 27](clase-27-vibe-coding-antigravity-de-idea-a-deploy.md) · [Clase 28](clase-28-instalacion-configuracion-antigravity.md)

---

## Idea central

La diferencia entre tratar Google AntiGravity como un chatbot avanzado (el enfoque del 99%, con instrucciones vagas y proceso reactivo que termina en aplicaciones genéricas) y dominarlo como un "Director de Orquesta" (la mentalidad del 1%) está en invertir la mayor parte del tiempo en planificación y estrategia antes de escribir una sola línea de código, orquestar múltiples agentes en paralelo, conectar el ecosistema con herramientas externas vía MCP, y codificar la propia experiencia en workflows y reglas personalizadas. El desarrollador deja de ser constructor línea por línea para convertirse en arquitecto de sistemas.

---

## 1. Pilar I: Planificación Estratégica

> "El 50-60% del éxito de un proyecto, y de que salga bien, es literalmente planear mucho antes de que la IA escriba la primera línea de código."

- **El Cerebro Externo:** No usar los créditos de AntiGravity para el brainstorming inicial. Se dialoga primero con un LLM externo (Claude, Gemini, ChatGPT) que hace preguntas clave (métricas cruciales, roles de usuario, flujo del agente) hasta refinar la idea en un SOP (Standard Operating Procedure) conciso de máximo 500 caracteres, que recién ahí se entrega a AntiGravity.
- **El Dossier de Diseño:** No dejar el diseño al azar — alimentar al agente con todos los activos desde el inicio: imágenes de inspiración (capturas de Dribbble para el "look & feel"), guías de marca (`brand_guidelines.md` con tipografías y paletas), logotipos/iconografía (SVG/PNG subidos al explorador del proyecto), y reglas de interfaz (`design.md` con instrucciones como "minimalista, estético y con excelente legibilidad").

---

## 2. Pilar II: Orquestación Inteligente

Una vez definido el plan, el rol deja de ser pasivo: se trata de gestionar el flujo de múltiples agentes en tiempo real, no de esperar un resultado único.

- **Agent Manager:** No limitar el proyecto a una sola conversación — se ejecutan múltiples agentes simultáneamente. Ejemplo con un CRM inmobiliario: el Agente 1 (Principal, modo Planning) desarrolla el frontend según el plan y los activos de diseño, mientras el Agente 2 (Investigación, modo Fast) investiga los 5 CRMs líderes y guarda el 20% de funcionalidades que generan el 80% del valor en `research.md`, que luego alimenta al Agente 1.
- **Ciclo de Retroalimentación Precisa:** Los errores no son un fracaso, son parte de la iteración. AntiGravity puede ver y corregir sus propios errores si se le guía con precisión — ej. "El fondo debe ser blanco, no gris. Los íconos no se alinean como en la imagen de SAT CN que te proporcioné" — cerrando el ciclo Error → Feedback → Corrección.

---

## 3. Pilar III: Ecosistema Conectado

AntiGravity no es una isla: se convierte en el centro de comando de servicios externos mediante MCPs (Model Context Protocol), un "idioma universal" que le permite operar de forma nativa con otras aplicaciones y APIs.

| Tipo de conector | Ejemplo | Pasos de configuración |
| :--- | :--- | :--- |
| **Nativo** | GitHub | `MCP Servers` → seleccionar GitHub e instalar → generar *Personal Access Token* en GitHub → pegar el token en AntiGravity |
| **Personalizado** | n8n / Supabase | Obtener el JSON de configuración del MCP desde el servicio externo → en AntiGravity ir a `View Raw Config` → pegar el JSON |

Conectar estas herramientas le da al agente "superpoderes" para interactuar con bases de datos, sistemas de automatización y control de versiones (indispensable para el despliegue continuo, CI/CD).

---

## 4. Pilar IV: Personalización Profunda

El paso final hacia la maestría es codificar la propia experiencia en la herramienta, en lugar de repetir las mismas instrucciones una y otra vez. Se configuran en la sección `Customizations`, a nivel de proyecto (`Workspace`) o global:

- **Workflows ("el Qué"):** Prompts reutilizables con directivas de alto nivel, invocados en el chat con `@nombre_workflow`. Ej.: `@frontend` → "Usa siempre Next.js con TypeScript. Implementa el diseño usando la librería SAT CN. Prioriza un diseño minimalista, responsivo y con una performance excepcional."
- **Reglas ("el Cómo"):** Instrucciones granulares que guían el comportamiento al ejecutar una tarea. Ej.: `debugging` → "Cuando encuentres un error: 1) Analiza el log, 2) Aísla el componente problemático, 3) Propón tres posibles soluciones antes de implementar una."

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Configura tu propio Dossier de Diseño y un workflow personalizado:
1. Crea en tu proyecto los archivos `brand_guidelines.md` y `design.md` con al menos tres reglas de interfaz concretas (ej. paleta de colores, tipografía, nivel de minimalismo).
2. Sube una captura de inspiración desde Dribbble al explorador de archivos del proyecto.
3. En `Customizations`, crea el workflow `@frontend` con una directiva de alto nivel para tu stack (framework, librería de UI, prioridad de performance).
4. Invócalo en el chat con `@frontend` y verifica que AntiGravity aplique la directiva sin que se la repitas.

**Ejercicio 2 (avanzado):** Conecta el MCP nativo de GitHub (genera un Personal Access Token y pégalo en AntiGravity) y luego un conector personalizado (Supabase o n8n, pegando el JSON de configuración en `View Raw Config`). Pide a un agente que haga `commit` de un cambio al repositorio y que consulte datos reales desde la base de datos conectada.

---

## 💡 Tip

> **No delegues el brainstorming inicial a AntiGravity:** Usa primero un LLM externo (Claude, Gemini o ChatGPT) como socio estratégico para refinar la idea con preguntas clave, y entrega a AntiGravity solo el SOP final y conciso (máx. 500 caracteres). Esto ahorra créditos y elimina la ambigüedad antes de que se escriba la primera línea de código.

---

## ⚠️ Error común

> **Tratar a AntiGravity como un chatbot avanzado.** Dar instrucciones vagas esperando resultados mágicos, sin plan ni dossier de diseño previo, produce un proceso lineal y reactivo donde se corrigen errores sobre la marcha. El resultado son aplicaciones genéricas, retrabajo constante y frustración — exactamente lo opuesto a la mentalidad del 1%, que invierte la mayor parte del tiempo en la estrategia antes de orquestar a los agentes.
