# Clase 33 — Clonar el Repo, Plan de Desarrollo, Localhost y Primeros Fixes

**Tags:** `Antigravity` `Planning Mode` `Vite` `Browser QA`
**Conecta con:** [Clase 28](clase-28-instalacion-configuracion-antigravity.md) · [Clase 31](clase-31-primera-win-clon-linktree-antigravity.md) · [Clase 32](clase-32-metaprompting-prd-maquetacion-mvp.md)

---

## Idea central

La transición de una maqueta conceptual a un entorno operativo requiere clonar el repositorio remoto en Antigravity y someterlo a un análisis estructurado en *Planning Mode* antes de modificar código. Al articular la lectura estricta del PRD con un agente de razonamiento profundo, la orquestación en paralelo de skills y la resolución visual de fallos en Vite mediante inspección autónoma en navegador, se asegura una base local estable antes de avanzar hacia integraciones de backend y despliegues.

---

## 1. Clonación y Análisis Inicial en Modo Planning

El flujo de trabajo dentro de Antigravity parte de vincular el control de versiones e instruir al modelo antes de solicitar cambios:

1. **Clonación Autorizada:** Seleccionar `Clone Repository`, autenticar la extensión con GitHub mediante código temporal, elegir el repositorio generado y guardarlo en un directorio local.
2. **Auditoría de Requerimientos:** En lugar de ordenar cambios dispersos, se activa el agente en *Planning Mode* con Gemini 3 Pro en modalidad *Low* (razonamiento reducido, priorizando velocidad sobre profundidad) para:
   - Leer exhaustivamente los archivos `README.md` y el PRD (*Product Requirements Document*).
   - Identificar dependencias activas del tech stack (React, Vite, Tailwind CSS, Supabase).
   - Mapear *user stories* y clasificar funcionalidades implementadas frente a pendientes.
   - Entregar un plan de desarrollo secuencial por fases priorizado para lanzar el MVP.
3. **Agente Secundario en Paralelo (Fast Mode):** Mientras el modelo principal elabora el plan, se abre una conversación concurrente (Gemini Flash) para investigar e inicializar la estructura de carpetas de *Agent Skills* (`agent_skills/`), preparando la extensibilidad del proyecto sin bloquear la rama principal.

---

## 2. Aprovisionamiento Local y Variables de Entorno

Para levantar la aplicación en el servidor local de desarrollo (`localhost:5173` o `localhost:3000`), el agente genera un archivo `.env.local` en la raíz del proyecto para alojar las claves requeridas:

| Variable de Entorno | Origen de la Credencial | Ámbito y Seguridad |
| :--- | :--- | :--- |
| `VITE_GEMINI_API_KEY` | Google AI Studio → *Get API Key* | Exclusiva para desarrollo local y generación de diagnósticos. Nunca commitear al repo. |
| `VITE_SUPABASE_URL` | Supabase Dashboard → *Project Settings → API → Project URL* | Endpoint base para consultas de tablas y llamadas a Edge Functions. |
| `VITE_SUPABASE_ANON_KEY` | Supabase Dashboard → *Project Settings → API → Project API Keys* | Llave pública anónima protegida por políticas de Row Level Security (RLS). |

Con las credenciales asignadas, se ejecuta `npm run dev` en la terminal integrada para instanciar el servidor de Vite.

---

## 3. Diagnóstico Visual Autónomo y Corrección de Bugs Típicos

Al ejecutar maquetas generadas por IA, emergen desajustes habituales de renderizado que se diagnostican aceleradamente mediante control de navegador:

- **Pantalla en Blanco (Tailwind v4 / Vite):** La ausencia de estilos o UI suele deberse a incompatibilidades entre directivas legadas de Tailwind y los plugins de compilación en `vite.config.ts`. El agente instala el plugin oficial, actualiza la configuración, y requiere reiniciar el servidor (`Ctrl + C` y `npm run dev`).
- **Dark Mode Roto y Falta de Legibilidad:** Al conmutar temas, surgen componentes que conservan colores claros o etiquetas con textos oscuros sobre fondos oscuros.
- **Inspección Autónoma vía Browser:** La primera vez, Antigravity pide instalar su extensión de Chrome; una vez instalada, se le concede permiso para lanzar una instancia de navegador controlada (halo azul visible). El agente interactúa con la interfaz, ejecuta scroll, simula eventos de usuario, toma capturas de pantalla de la renderización real y parchea los tokens de diseño hasta garantizar legibilidad absoluta.

---

## 🎯 Ejercicio práctico

Clonar un proyecto desde GitHub, levantar su entorno local con variables seguras y auditar la interfaz visualmente.

**Ejercicio 1:** Clona el repositorio de tu proyecto en Antigravity autorizando la conexión con GitHub. Abre el agente en *Planning Mode* (Gemini Pro) y pídele que lea el PRD y genere el plan de fases. Crea el archivo `.env.local` con tus claves de Google AI Studio y Supabase, levanta el proyecto con `npm run dev` y solicita al agente que use la herramienta de navegador para verificar que el alternador de modo oscuro no degrade la legibilidad de los textos.

**Ejercicio 2 (avanzado, opcional):** Mientras el servidor corre en local, abre una sesión en paralelo con Gemini Flash para crear un placeholder de skill en `skills/review.md` que contenga una directiva de verificación de accesibilidad de colores antes de autorizar cualquier commit.

---

## 💡 Tip

Cuando la interfaz se quede completamente en blanco tras compilar o notes errores extraños en el renderizado de Tailwind CSS, no intentes adivinar el bug con múltiples prompts: detén el servidor Vite en la terminal (`Ctrl + C`), toma una captura de pantalla del navegador o de los errores de consola, y pide al agente que verifique si falta el plugin oficial de Tailwind en `vite.config.ts` antes de volver a correr `npm run dev`.

---

## ⚠️ Error común

Subir accidentalmente el archivo `.env.local` o credenciales vivas (API keys de Supabase o Gemini) al repositorio público de GitHub al realizar el primer commit de ajustes. Verifica siempre que `.env.local` figure dentro de tu `.gitignore` antes de ejecutar cualquier comando de `git push`.

---
