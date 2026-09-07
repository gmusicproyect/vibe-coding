# Clase 13 — El Golden Path del Vibe Coding: Fable 5 vs Opus 4.8 en Vivo

**Tags:** `Golden Path` `Fable 5` `Opus 4.8` `Ultra Code` `Agentation`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 02](clase-02-tunear-claude-code.md) · [Clase 08](clase-08-ux-seguridad.md)

---

## Idea central

El éxito del *vibe coding* no depende de improvisar prompts a ciegas, sino de aplicar la regla del 80/20: dedicar el 80% del esfuerzo a formular un **Blueprint unificado como única fuente de verdad** y el 20% restante a la ejecución automatizada con el stack estándar de la industria (**Next.js + Supabase + Tailwind + shadcn/ui + Vercel**). Al enfrentar en paralelo a **Claude Fable 5** y **Claude Opus 4.8** (con y sin arnés), se demuestra que la disciplina arquitectónica y los flujos multiagente (*Ultra Code*) superan a la potencia bruta aislada del modelo.

---

## El Stack Estándar: "The Golden Path"

Para construir aplicaciones web escalables sin generar código "Frankenstein", la comunidad adopta este ecosistema probado:

| Capa | Tecnología | Rol en la arquitectura | Justificación técnica |
|------|------------|------------------------|-----------------------|
| **Framework** | **Next.js 16 + React 19** | Front & Back unificado | App Router, Server Components y compilación ultrarrápida con TurboPack |
| **Diseño / UI** | **Tailwind CSS + shadcn/ui** | Componentes base y estilos | Componentes copiables, personalizables y sin dependencia de librerías rígidas |
| **Backend & DB** | **Supabase (PostgreSQL)** | Base de datos relacional | Auth, Realtime, RLS (Row Level Security), storage y SQL estándar sin vendor lock-in |
| **Tipado y Estado** | **TypeScript + Zod + Zustand** | Validación en runtime y estado | Tipado estático estricto, validación de schemas de API y estado global ligero |
| **Deploy & CI/CD** | **Vercel** | Publicación en producción | Autodeploys nativos conectados a GitHub en cada push a la rama `main` |

---

## La Anatomía de un Blueprint Riguroso

Un Blueprint no es una descripción vaga; es un documento exhaustivo de 800 a 5.000 líneas que previene alucinaciones y contiene 7 capas clave:
1. **PDR (Product Definition Report):** Objetivos de negocio y problema que resuelve.
2. **Pre-mortem:** Análisis previo de riesgos de arquitectura y seguridad antes de escribir código.
3. **Tech Spec & Architecture:** Modelos de datos, relaciones y diseño de endpoints API.
4. **SQL Migrations:** Definición de tablas, índices y políticas RLS listas para ejecutar en Supabase.
5. **UI & Design Tokens:** Breakpoints, paleta de colores y componentes de shadcn/ui requeridos.
6. **User Stories:** Flujos de interacción detallados paso a paso (entradas, salidas, casos borde).
7. **Rúbrica de Evaluación:** Criterios medibles para que el propio agente audite y valide su entrega final.

---

## Benchmark Mano a Mano: Fable 5 vs Opus 4.8

En una prueba One-Shot para construir un ERP de inventario con dashboard, KPIs, gráficas y alertas:

| Criterio | Opus 4.8 (Sin / Con Arnés) | Fable 5 (Sin / Con Arnés) | Veredicto |
|----------|----------------------------|---------------------------|-----------|
| **Velocidad de entrega** | ~45-50 min (ambos entornos) | **~15-18 min** (Fable con arnés terminó primero) | **Fable 5** demostró mayor rapidez en ejecución multi-workflow |
| **Consumo de tokens** | 152k (sin arnés) / 183k (con arnés) | 150k (sin arnés) / 150k (con arnés) | Consumo similar (~15% ventana 1M), pero Fable es 2x más caro por token |
| **Acabado visual (UI)** | Tablas y cards comprimidos con scroll | Ocupó el 100% de la pantalla; vistas fluidas | **Fable 5** entregó un layout más armónico y ordenado |
| **Rigor funcional** | Validó dropdown de unidades y stock negativo | Dejó la unidad de medida como texto libre manual | **Opus 4.8** fue superior en validación de reglas de negocio |

---

## Automatización y Feedback Visual en Vivo

- **Ultra Code & Dynamic Workflows:** Al invocar `ultra code`, el orquestador dispara subagentes en paralelo encargados del esquema SQL, rutas, frontend y testing sin bloquear la sesión.
- **Modo Bypass (`--dangerously-skip-permissions` / alias `yolo`):** Habilita ejecución desatendida sin confirmaciones manuales intermedias para acelerar builds.
- **Inspección Visual con Agentation:** Mediante su integración MCP (`agentation self drive` + Playwright), el agente inspecciona coordenadas de componentes defectuosos en el navegador y corrige desalineaciones automáticamente.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Diseña un `BLUEPRINT.md` exhaustivo para una aplicación de notas categorizadas (PDR, esquema de tablas Supabase, endpoints, componentes shadcn/ui requeridos y rúbrica de pruebas). Lanza la construcción en Claude Code en modo One-Shot utilizando Next.js y shadcn/ui, verificando que el agente cumpla el 100% de los criterios sin pedir contexto adicional.

**Ejercicio 2 (Avanzado):** Levanta la aplicación local con Playwright configurado y ejecuta una ronda de auditoría de UI/UX para verificar que el layout sea totalmente responsivo en viewport móvil (390px) y que ningún elemento requiera scroll horizontal involuntario.

---

## 💡 Tip

No uses Fable 5 para proyectos de codificación rutinaria: al costar el doble por token, agota tu cuota rápidamente. Reserva Fable para la fase de planeación estratégica, redacción de PRDs densos y auditoría forense, y utiliza Opus 4.8 o Sonet para la implementación de código y validaciones lógicas.

---

## ⚠️ Error común

Omitir los criterios de diseño *Mobile-First* en el Blueprint inicial. Si no declaras explícitamente cómo deben colapsar las tablas y cards en pantallas móviles (transformando filas de tabla en tarjetas verticales apiladas), el agente asumirá vista exclusiva para desktop, obligando al usuario a lidiar con barras de desplazamiento horizontal.
