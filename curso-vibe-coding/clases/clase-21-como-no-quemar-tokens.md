# Clase 21 — Cómo no quemar tokens construyendo una app real

**Tags:** `Tokens` `Prompt Caching` `Blueprint` `Forge`
**Conecta con:** [Clase 03](clase-03-segundo-cerebro.md) · [Clase 18](clase-18-estructurar-sesiones-agentes.md) · [Clase 20](clase-20-cerramos-nucleo-deploy-github.md)

---

## Idea central

La transición del diseño a la construcción de software con Claude Code exige un Blueprint maestro estructurado en fases atómicas con dependencias explícitas, la elección estratégica entre dos modalidades de ejecución (el Modo Yunque secuencial y controlado vs. el Modo Forja paralelo y distribuido con múltiples agentes), y una disciplina rigurosa de higiene de contexto apoyada en el Prompt Caching de Anthropic (regla de los 5 minutos) y la poda selectiva de herramientas MCP.

---

## 1. Higiene de Contexto, Prompt Caching y Poda de MCPs

Maximizar la lucidez del agente y reducir costos depende de gestionar activamente la memoria de trabajo:

- **La regla de los 5 minutos (Fast Phase):** Si respondes al agente dentro de los 5 minutos posteriores a su turno, Anthropic mantiene el caché caliente, ahorrando hasta un 80% en costos de tokens de entrada. Pasada una hora o al día siguiente, el caché expira y continuar en el mismo hilo obliga al modelo a reprocesar todo el historial.
- **Umbrales de saturación cognitiva:**
  - *Menor al 50%:* Zona óptima de razonamiento y precisión arquitectónica.
  - *50% a 75%:* Precaución; riesgo creciente de omitir instrucciones sutiles.
  - *Mayor al 75%:* Saturación crítica y alucinaciones. Es imperativo compactar o abrir nueva sesión.
- **Poda de servidores MCP (`/mcp`):** Servidores inactivos (Slack, Gmail, Excalidraw) consumen entre 30% y 40% del contexto basal únicamente enviando sus esquemas JSON. Desactívalos en terminal con `/mcp` y conserva solo herramientas de conocimiento vivo como Context 7.

---

## 2. Los Dos Modos de Construcción: Yunque vs. Forja

Una vez aprobado el Blueprint maestro, el desarrollo puede abordarse mediante dos filosofías operativas:

| Parámetro | Modo Yunque (Manual / Artesanal) | Modo Forja (Paralelo / Distribuido) |
| :--- | :--- | :--- |
| **Metodología** | Secuencial paso a paso con validación humana | Paralela y autónoma en sandboxes aislados |
| **Mecánica** | Golpear, inspeccionar, ajustar y avanzar | Despliega N agentes simultáneos (`--bypass`) |
| **Consumo Hardware** | 1 proceso (~3 a 4 GB RAM); consumo gradual | N procesos (~3 a 4 GB RAM c/u) y puertos (3000, 3001...) |
| **Idoneidad** | Tareas acopladas, refinamiento de UI y lógica core | Módulos independientes o versiones exploratorias |

---

## 3. UI Anti-Slop, Wiki LLM (Obsidian) y Microcommits de Git

- **Diseño sin AI Slop:** Evita descripciones genéricas. Provee referencias concretas (ej. clon de Notion en modo Light minimalista) y screenflows en markdown (`docs/ui-design/screenflows/`) para que el agente no invente componentes ni use paletas cliché.
- **Wiki LLM con Obsidian:** Inspirado en la propuesta de Andrej Karpathy, el segundo cerebro no debe alimentarse manualmente. Se conectan bóvedas de Markdown en Obsidian para que agentes especializados nutran, interconecten y auditen la documentación de forma continua.
- **Microcommits en `CLAUDE.md`:** Instruye a Claude Code para ejecutar `git init`, crear ramas atómicas y realizar commits automáticos por cada funcionalidad finalizada. Esto garantiza puntos de restauración (`rollback`) inmediatos ante roturas de código.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Optimiza tu entorno de desarrollo y planifica un módulo con compuertas de contexto:
1. Abre tu terminal con Claude Code y ejecuta `/mcp` para desactivar servidores que no uses en la sesión.
2. Configura el modo de razonamiento dual para ahorrar tokens:
   ```text
   model opusplan
   ```
3. Genera un mini blueprint de 3 tareas con dependencias claras y exige en `CLAUDE.md` que se realice un commit con mensaje descriptivo al finalizar cada tarea.

**Ejercicio 2 (avanzado):** Simula el Modo Forja solicitando a Claude Code lanzar dos subagentes en paralelo para construir dos módulos desacoplados (ej. exportador de datos y parser de bookmarks), verificando que reporten sus resultados de forma independiente.

---

## 💡 Tip

> **Compactación dirigida (`/compact [instrucción]`):** Al ejecutar `/compact`, añade siempre un texto que defina qué debe retener el modelo (ej. `/compact mantén decisiones de auth, esquema de Supabase y el estado de la Fase 2`). Esto previene que Claude descarte información crítica de negocio al resumir la sesión.

---

## ⚠️ Error común

> **Continuar sesiones antiguas para "no perder contexto":** Retomar un chat tras varios días o después de haber superado el 75% de contexto creyendo que es más cómodo quema cientos de miles de tokens releyendo mensajes viejos y provoca alucinaciones. Es infinitamente más eficiente abrir una nueva ventana, importar el resumen de memoria (`MEMORY.md` o `/avivar`) e iniciar con contexto 100% fresco.
