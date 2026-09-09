# SKILL: Optimización de Tokens, Prompt Caching y Poda de MCPs en Claude Code

> Guarda este archivo en `/skills/optimizar-tokens-prompt-caching/SKILL.md`
> Referencia en tu CLAUDE.md: `- /skills/optimizar-tokens-prompt-caching/SKILL.md → para auditar el consumo de tokens, aprovechar la ventana de Prompt Caching de Anthropic y podar herramientas MCP inactivas`

---

## Cuándo usar este skill

Cuando un desarrollador o agente en Claude Code requiera:
1. Reducir drásticamente el consumo de tokens y costos en proyectos medianos o grandes.
2. Mantener la ventana de contexto en su zona óptima (<50%) para prevenir alucinaciones arquitectónicas y omisión de directivas.
3. Configurar y respetar la regla de los 5 minutos (Fast Phase) para maximizar la tasa de aciertos de Prompt Caching.
4. Desactivar servidores MCP ruidosos que sobrecargan el prompt basal del sistema con esquemas de herramientas innecesarias.

Basado en las directrices de la **Clase 21 — Arquitectura de Núcleo: Blueprint, Yunque vs Forja y Contexto**.

---

## Prerequisitos

- [ ] Sesión activa de Claude Code en terminal o IDE.
- [ ] Servidores MCP configurados en `.mcp.json` o configuración global (`claude mcp list`).
- [ ] Acceso a los comandos internos de Claude Code (`/mcp`, `/context`, `/compact`).

---

## Pasos de Optimización

### Paso 1 — Poda Activa de Servidores MCP (`/mcp`)
Las definiciones de esquemas de cada servidor MCP se inyectan en cada llamada, consumiendo entre un 20% y un 40% de la ventana basal antes de escribir una sola línea de código:

1. Listar y auditar los servidores MCP activos:
   ```bash
   claude mcp list
   ```
2. Desactivar temporalmente cualquier herramienta que no se utilice en la fase actual (ej. Slack, Gmail, Excalidraw, Notion durante fases de backend, modelado de datos o maquetado UI):
   - En la interfaz de Claude Code: ejecutar `/mcp` y seleccionar `disable` en las herramientas prescindibles.
3. Mantener activos únicamente los servidores críticos para la tarea inmediata (ej. Context 7 para consultar documentación de librerías, o Playwright MCP para validaciones E2E).

### Paso 2 — Aplicar la Regla de Fast Phase (Prompt Caching de 5 Minutos)
El sistema de Prompt Caching de Anthropic retiene en memoria los bloques de contexto de entrada:
- **Respuesta inmediata (< 5 min):** Si el operador responde a Claude Code dentro de los 5 minutos posteriores a su turno, la llamada aprovecha el caché en memoria, reduciendo el costo de tokens de entrada hasta en un 80%.
- **Degradación (5 min a 1 hora):** El caché comienza a invalidarse paulatinamente.
- **Expiración total (> 1 hora o al día siguiente):** Continuar en el mismo chat fuerza al modelo a reprocesar todo el historial desde el mensaje inicial. Si pasó más de una hora, cierra la sesión o haz compactación guiada.

### Paso 3 — Monitoreo de Umbrales de Contexto (`/context`)
Ejecutar periódicamente `/context` para inspeccionar la saturación de la ventana de contexto:

| Nivel de Saturación | Estado de Lucidez | Acción Requerida |
| :--- | :--- | :--- |
| **0% a 50%** | 🟢 Óptimo | Operar con normalidad; máxima capacidad de razonamiento |
| **50% a 75%** | 🟡 Precaución | Evitar pedir tareas complejas o refactors masivos; preparar cierre |
| **75% a 100%** | 🔴 Crítico | Detener el sprint. Riesgo alto de alucinación. Compactar o reiniciar |

### Paso 4 — Compactación Dirigida (`/compact <ancla>`)
Nunca uses `/compact` en blanco si estás en medio de un flujo con directivas técnicas complejas:
1. Ejecuta `/compact` agregando una instrucción explícita de lo que debe prevalecer:
   ```text
   /compact Resume la sesión reteniendo el esquema de Supabase acordado, las dependencias de la Fase 3 del Blueprint y los endpoints pendientes de validación.
   ```
2. Si la sesión concluyó un hito completo, no compactes: genera un archivo de memoria (`MEMORY.md` o `handoff.md`), cierra la ventana y abre una sesión limpia.

### Paso 5 — Separación de Modelos por Etapa (`opusplan`)
Para balancear costo y capacidad de razonamiento en proyectos complejos:
- Usar **Opus** para la fase de arquitectura, diseño del Blueprint y análisis de viabilidad.
- Usar **Sonet** o **Haiku** para la implementación de código, generación de componentes y tareas mecánicas de terminal.
- Activar el modo híbrido en Claude Code:
  ```text
  model opusplan
  ```

---

## ⚠️ Errores comunes a evitar

- **Mantener múltiples servidores MCP encendidos perpetuamente:** Agotar un tercio del contexto antes de empezar.
- **Dejar sesiones abiertas durante días:** Reanudar un chat viejo creyendo que ahorra tiempo, cuando en realidad quema presupuesto releyendo mensajes caducados.
- **Compactar sin directiva:** Permitir que el LLM decida de forma aleatoria qué decisiones técnicas preservar.

---

*Creado: Septiembre 2026 · Basado en Clase 21 de Vibe Coding*
