# SKILL: Auditoría Cruzada de Arquitectura y Rescate Multi-Modelo

> Guarda este archivo en `/skills/auditar-arquitectura-multi-modelo/SKILL.md`
> Referencia en tu CLAUDE.md: `- /skills/auditar-arquitectura-multi-modelo/SKILL.md → para auditar documentos de arquitectura (PRD, TechSpecs) y rescatar sesiones trabadas mediante modelos alternativos (Codex / GPT-5.4 / Gemini)`

---

## Cuándo usar este skill

Cuando el desarrollador o agente requiera:
1. Auditar de forma imparcial especificaciones técnicas (`techspecs.md`, esquemas SQL, contratos de API) antes de comenzar a codificar, eliminando suposiciones implícitas y sesgos del modelo autor.
2. Desbloquear bucles de error persistentes en Claude Code (modo `rescue`): cuando un problema de compilación, lógica o tests no se resuelve tras dos intentos consecutivos.
3. Comparar propuestas arquitectónicas de dos o más LLMs de frontera para seleccionar la solución más robusta y económica antes de construir.

Basado en las directrices de la **Clase 22 — Construimos una app desde 0 con Claude Code**.

---

## Prerequisitos

- [ ] Sesión activa de Claude Code con acceso a documentos técnicos (`techspecs.md`, `PRD.md`, `BLUEPRINT.md`).
- [ ] Acceso a un modelo alternativo:
  - Plugin oficial de Codex en Claude Code marketplace, o
  - CLI de OpenAI / Codex autenticado (`codex login`), o
  - Subagente configurado con endpoint de OpenRouter / OpenAI.

---

## Pasos de Auditoría Cruzada

### Paso 1 — Congelar la Especificación Base
Asegurar que el documento arquitectónico elaborado por el agente primario (Claude Opus/Sonnet) esté guardado y estable (ej. `docs/techspecs.md`).

### Paso 2 — Invocación del Revisor Externo (Adversarial Review)
Ejecutar el comando de revisión cruzada pasando el archivo de especificación:

```bash
# Vía plugin de Codex en Claude Code o CLI
codex review --file docs/techspecs.md --prompt "Audita este documento técnico. Busca: 1) Contratos ambiguos entre frontend y backend, 2) Flujos declarados en la visión pero omitidos en los endpoints, 3) Cuellos de botella en el esquema de base de datos."
```

Si no se dispone del plugin CLI integrado, exportar el documento y ejecutar la consulta a través de OpenRouter con el modelo alternativo (`gpt-5.4` o `gemini-1.5-pro`).

### Paso 3 — Triangulación de Hallazgos y Corrección
Analizar el veredicto del modelo auditor:
1. **Contratos Implícitos:** Si el auditor detecta que un flujo no está explícito en el esquema (ej. URLs vs. texto plano o archivos binarios), formalizar el contrato en el archivo de especificaciones.
2. **Generación del Documento Enriquecido:** Crear `docs/techspecs_revisado.md` incorporando las observaciones válidas y descartando falsos positivos.

### Paso 4 — Modo Rescate ante Bucles de Error (`Rescue Mode`)
Cuando Claude Code quede atrapado en un ciclo de corrección fallido (mismo error repetido tras 2 turnos):
1. Pausar la ejecución con `Escape`.
2. Invocar el modo rescate de Codex enviando el stack trace y los archivos involucrados:
   ```text
   Codex Rescue: Claude Code lleva 2 iteraciones sin resolver este error en la migración de Supabase. Analiza los archivos @schema.sql y el log de error adjunto. Entrega la causa raíz exacta sin reescribir código innecesario.
   ```
3. Aplicar el diagnóstico puntual provisto por el modelo externo y reanudar la sesión en Claude Code.

---

## ⚠️ Errores comunes a evitar

| Error | Consecuencia | Corrección |
| :--- | :--- | :--- |
| **Pedirle auto-auditoría al mismo modelo** | Sesgo de confirmación; no detectará sus propios supuestos | Delegar siempre la revisión a un LLM con pesos y entrenamiento diferente |
| **Aceptar sugerencias del auditor a ciegas** | Expansión descontrolada del alcance (scope creep) | Contrastar las críticas contra el *Out of Scope* definido en el PDR |
| **Invocar el modo rescate al primer error** | Gasto innecesario de tokens y pérdida de fluidez | Permitir un intento de autocorrección antes de activar el rescate externo |

---

*Creado: Septiembre 2026 · Basado en Clase 22 de Vibe Coding*
