# Clase 27 — Vibe Coding con Antigravity: De la Idea al Deploy

**Tags:** `Vibe Coding` `Antigravity` `Google AI Studio` `Stack MVP`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 13](clase-13-golden-path-fable-vs-opus.md) · [Clase 25](clase-25-antigravity-claude-code-openclaw.md)

---

## Idea central

El Vibe Coding transforma el desarrollo de software al reemplazar la codificación manual por la orquestación en lenguaje natural, guiada por intuición y velocidad bajo la premisa de "crea primero y refina después". En este flujo, Google Antigravity actúa como orquestador multi-agente asistido por Google AI Studio para maquetación rápida, GitHub para control de versiones, Supabase para backend y Vercel para despliegue, optimizado estrictamente para validar MVPs y herramientas internas sin pretender sustituir la arquitectura de producción a gran escala.

**Hoja de ruta del módulo:** el curso construye dos proyectos completos —una landing page tipo Linktree desplegada y funcional, y una app compleja con autenticación, base de datos y automatizaciones de IA corriendo en el backend— y cierra con un bonus sobre cómo convertir el resultado en una Progressive Web App (PWA).

---

## 1. El Stack Completo: De Idea a Producción a Costo Cero

El pipeline de desarrollo integra herramientas accesibles en sus niveles gratuitos para transformar conceptos visuales en aplicaciones operativas:

| Herramienta | Rol en el Flujo | Función Clave |
| :--- | :--- | :--- |
| **Dribbble** | Inspiración visual | Referencias de UI/UX, layouts de dashboards y paletas de color mediante capturas. |
| **Google AI Studio** | Prototipado y maquetación | Generación rápida de UI (React/Angular) vía prompts, modo Build, Stream y exportación a GitHub. |
| **GitHub** | Control de versiones | Repositorio central de código, sincronización y puente hacia el IDE y el deploy. |
| **Antigravity** | Orquestador multi-agente | Coordinación de agentes (Gemini 3.0 Pro/Flash, Claude Opus 4.5), refactorización e iteración. |
| **Supabase** | Backend y persistencia | Base de datos PostgreSQL, autenticación OAuth y Edge Functions para lógica de servidor. |
| **Vercel** | Despliegue web | Hosting y publicación continua del frontend conectado directamente al repositorio de GitHub. |

---

## 2. Modos de Autonomía y Alcance de Antigravity

Antigravity opera como núcleo orquestador entre el criterio humano y múltiples agentes autónomos, ofreciendo tres esquemas de control:

1. **Modo Sugerencia Estricta:** El agente analiza el código y propone cambios, pero no ejecuta escrituras ni comandos; el usuario aplica las modificaciones manualmente.
2. **Modo Sugerencia con Autorización Explícita (Recomendado):** El agente redacta el plan y las modificaciones, pero solicita confirmación previa antes de tocar cualquier archivo. Permite inspeccionar qué se alterará y prevenir efectos secundarios no deseados.
3. **Modo Acceso Libre:** El agente ejecuta todas las operaciones y modificaciones de forma completamente desatendida. Aunque acelera el flujo, introduce alto riesgo de corrupción en el código si se carece de supervisión.

> **Criterio de Aplicación:** Antigravity es ideal para construir MVPs, validar hipótesis comerciales y desarrollar herramientas internas rápidamente. Si el software debe escalar a nivel corporativo para cientos de usuarios o requiere una arquitectura modular compleja mantenida por clientes externos, se requiere desarrollo técnico formal y no depender únicamente de un generador iterativo.

---

## 3. Prerrequisitos de Configuración y Flujo Operativo

Para ejecutar el pipeline completo sin bloqueos técnicos:

- **Activación de Billing en Google Cloud:** Aunque Google AI Studio y Gemini ofrecen cuotas de uso gratuitas, Google Cloud exige vincular una tarjeta de crédito para configurar una cuenta de facturación (*billing account*). Sin este paso, no se habilitan las claves de API de Gemini necesarias para alimentar los agentes.
- **Flujo de Maquetación Visual:**
  1. Localiza en Dribbble un dashboard o interfaz que refleje la distribución visual deseada.
  2. Toma una captura de pantalla del diseño y cárgala en Google AI Studio.
  3. Solicita en lenguaje natural generar la estructura en React/Angular replicando los bloques y menús observados.
  4. Exporta el código generado a un repositorio de GitHub.
  5. Clona el repositorio dentro de Antigravity para iniciar la orquestación iterativa con Gemini y Claude.

---

## 🎯 Ejercicio práctico

Validar la captura de requerimientos visuales y la configuración de gobernanza en el orquestador.

**Ejercicio 1:** Selecciona un diseño de interfaz en Dribbble (un panel de control o formulario de cotizaciones). Captura la pantalla, ábrela en Google AI Studio y solicita mediante un prompt estructurado generar el layout inicial especificando menús, componentes y esquema de colores. Conecta el resultado a un repositorio de GitHub, ábrelo en Antigravity y asegúrate de fijar la configuración de agentes en modo "Sugerir con autorización previa" antes de solicitar la primera modificación de código.

**Ejercicio 2 (avanzado, opcional):** Configura tu cuenta de facturación en Google Cloud para generar una API key de Gemini, incorpórala a Antigravity y solicita a un agente que redacte el esquema inicial de tablas SQL para autenticación y datos en Supabase.

---

## 💡 Tip

No delegues la definición inicial en blanco a Antigravity. La calidad del resultado depende de la precisión del prompt y de la maquetación base; llega siempre a Antigravity con la estructura visual pregenerada en Google AI Studio o con capturas de referencia claras para evitar alucinaciones arquitectónicas.

---

## ⚠️ Error común

Configurar Antigravity en modo de acceso libre ("haz todo sin preguntar") creyendo que la IA resolverá cualquier error automáticamente. Si el agente comete una mala interpretación arquitectónica inicial, encadenará modificaciones erróneas sobre el código hasta volverlo incomprensible e inmanejable.

---
