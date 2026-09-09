# Clase 22 — Construimos una app desde 0 con Claude Code

**Tags:** `Planificación` `Fullstack` `PRD` `Codex Review`
**Conecta con:** [Clase 04](clase-04-adversarial-review.md) · [Clase 13](clase-13-golden-path-fable-vs-opus.md) · [Clase 21](clase-21-como-no-quemar-tokens.md)

---

## Idea central

El desarrollo profesional de aplicaciones complejas con Claude Code invierte el 80% del esfuerzo inicial en la fase de planeación estructurada: antes de escribir una sola línea de código, se somete la idea a un Viability Check que acota el alcance a un MVP estricto, se redacta el PDR con un único KPI de éxito, se definen especificaciones técnicas robustas (PostgreSQL con índices trigram y pipelines asíncronos), y se implementa una auditoría cruzada adversarial con modelos alternativos (Codex / GPT-5.4) para neutralizar sesgos y ambigüedades arquitectónicas.

---

## 1. El Pipeline de Planificación: De la Idea al Tech Spec

Para evitar que el agente alucine o genere código inescalable, el desarrollo sigue un efecto cascada donde cada documento valida y nutre al siguiente:

1. **Viability Check y acotación de fases:** Evalúa factibilidad técnica y riesgo de scope. Si el alcance es excesivo (PWA, offline-first, sync, extensión y RAG a la vez), divide el proyecto en fases:
   - *Fase 1 (MVP acotado):* Captura rápida de links, texto y comandos, extracción asíncrona de OG metadata, categorización automática con Haiku, búsqueda full-text y workspaces.
   - *Fase 2:* Modo offline-first con IndexedDB, notas de voz, RAG chat sobre documentos y extensión de navegador.
   - *Fase 3:* Procesamiento de video social (Reels/TikTok) y sincronización cross-device avanzada.
2. **PDR (Product Definition Report):** Establece el Happy Path, delimita explícitamente el *Out of Scope* (ej. no colaboración multiusuario ni scraping invasivo) y fija una única North Star Metric medible (ej. recuperar cualquier recurso guardado en menos de 5 segundos).
3. **Tech Specs:** Modela la base de datos (6 tablas con RLS mandatorio e índices trigram para búsqueda instantánea) y define una arquitectura orientada a eventos con procesamiento asíncrono para no bloquear la interfaz.

---

## 2. Auditoría Cruzada con Modelos Alternativos (Codex Review Loop)

Ningún modelo debe auditar sus propias especificaciones arquitectónicas. Utilizar un modelo rival como revisor externo expone ángulos ciegos antes de codificar:

| Dimensión | Autor (Claude Opus / Sonnet) | Auditor Externo (Codex / GPT-5.4) |
| :--- | :--- | :--- |
| **Rol en el Flujo** | Generación de PDR, esquemas DDL y arquitectura | Revisión crítica de contratos y casos de borde |
| **Detección Típica** | Asume flujos implícitos como resueltos | Señala vacíos en el contrato funcional del MVP |
| **Modo Rescate (`rescue`)** | Puede entrar en bucles recursivos de error | Interviene como observador externo para desbloquear |
| **Entregable** | `techspecs.md` | `techspecs_revisado_codex.md` con parches de diseño |

*Ejemplo en Núcleo:* Mientras Claude redactó el Tech Spec asumiendo que el MVP se limitaba a URLs, Codex advirtió que la promesa de valor incluía comandos y texto plano, forzando a declarar explícitamente el contrato de datos antes de construir los endpoints.

---

## 3. Del Blueprint a la Validación Comercial: El Crisol

La arquitectura técnica debe respaldarse con validación de negocio antes del despliegue:

- **Brújula y North Star:** Alineamiento de la visión del producto y métrica central de retención.
- **Battle Cards y Pricing:** Comparativa directa frente a competidores establecidos (ej. Núcleo vs. Notion) identificando ventajas asimétricas, estructura de costos fijos/variables (API tokens) y proyección de ROI.
- **Demos de prospección automatizada:** Casos como *Antomatic* demuestran el poder de clonar visualmente e-commerces y conectar agentes de prospección con catálogos scrapeados para validar tracción comercial de forma inmediata.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Diseña la fase de viabilidad y somete tu Tech Spec a una auditoría cruzada:
1. Define en un archivo `viability.md` el MVP de una aplicación web, separando explícitamente qué queda dentro de la Fase 1 y qué se posterga a Fases 2 y 3.
2. Genera el esquema de base de datos con políticas RLS obligatorias.
3. Abre un modelo alternativo (Codex vía plugin oficial de Claude Code, o ventana independiente de GPT-5.4/Gemini) con el siguiente prompt adversarial:
   ```text
   Actúa como un arquitecto de software senior despiadado. Revisa este @techspecs.md. Identifica suposiciones implícitas, vacíos en el contrato de datos y discrepancias entre la promesa del MVP y los endpoints propuestos.
   ```
4. Aplica las correcciones antes de iniciar la codificación.

**Ejercicio 2 (avanzado):** Configura un loop de rescate en terminal donde, si Claude Code falla dos veces seguidas en un test unitario, invoque automáticamente a Codex mediante subproceso para auditar el stack trace.

---

## 💡 Tip

> **Procesamiento Asíncrono para llamadas de IA pesadas:** Al diseñar flujos que consumen APIs externas o LLMs (como resumir un artículo o extraer metadata OG), guarda el registro inmediatamente en la base de datos con estado `procesando` y delega el análisis a un worker en segundo plano. Esto mantiene la interfaz reactiva al instante y evita que el usuario quede congelado ante tiempos de respuesta variables.

---

## ⚠️ Error común

> **Comenzar a codificar sin delimitar el "Out of Scope":** Lanzarse a construir sin una lista cerrada de lo que NO hará el MVP conduce a la dispersión de features (scope creep), inflando el consumo de tokens y generando bases de código fragmentadas que colapsan antes de entregar valor real.
