# Clase 04 — El que encuentra el bug no lo arregla

**Tags:** `Adversarial Review` `Codex` `Seguridad` `Auditoría`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 02](clase-02-tunear-claude-code.md) · [Clase 03](clase-03-segundo-cerebro.md)

---

## Idea central

Pedirle al mismo modelo que escribió tu código que lo revise produce una validación complaciente ("el autógrafo"), no una auditoría real. Una revisión adversarial introduce un segundo modelo independiente (como OpenAI Codex o modelos open source en OpenCode) instruido exclusivamente para destruir la solución, encontrar brechas de seguridad y auditar la interfaz visual antes de llegar a producción.

---

## El principio del autógrafo vs. auditoría adversarial

| Enfoque | Quién revisa | Incentivo del prompt | Resultado típico |
|---------|--------------|----------------------|------------------|
| **Autógrafo** | El mismo modelo constructor | "¿Está bien este código?" | Confirma sus propios sesgos y pasa por alto errores sutiles. |
| **Adversarial** | Segundo modelo independiente | "Encuentra razones por las que esto NO debe ir a producción." | Identifica fugas de memoria, edge cases y fallos lógicos graves. |

La regla operativa es estricta: **el que audita no repara**. El auditor adversarial solo lista fallos con severidad y pruebas de concepto; el modelo constructor (Claude Code) recibe el reporte y aplica las correcciones.

---

## Rutas de ejecución: Plugin de Codex y alternativas

Para ejecutar revisiones sin fricción existen tres vías según presupuesto y stack:

1. **Plugin oficial de Codex en Claude Code:** Se invoca vía `/codex adversarial-review` pasando la rama o el diff del commit.
2. **Extensión en IDE (VS Code / Cursor):** Permite lanzar agentes de OpenAI o modelos locales en paralelo sobre archivos abiertos.
3. **OpenCode / Modelos abiertos:** Permite utilizar modelos más económicos o locales (DeepSeek, GLM) para auditorías continuas sin disparar el costo de API.

---

## Las tres trampas al auditar con LLMs

1. **Filtros de seguridad (Safety filters):** Prompts con palabras como "hackea" o "pentest" bloquean el modelo. Debe enmarcarse como *análisis estático defensivo de seguridad OWASP*.
2. **Secuestro por directivas (`AGENTS.md` / `CLAUDE.md`):** Si el archivo del proyecto afirma que "la autenticación es segura", el auditor asume la premisa como cierta. Solución: auditar con `--project-doc-max-bytes 0` o ignorar directivas contextuales.
3. **El auditor que parcha:** Si dejas que el auditor modifique el código directamente, pierdes la separación de poderes y reaparece el autógrafo.

---

## Auditoría visual de interfaces

Los modelos de lenguaje son ciegos al renderizado real en pantalla (pueden aprobar botones ilegibles de 19px o contraste gris sobre gris). Para interfaces de usuario:

- **Browser tools (Playwright / DevTools / Station):** Se navega la aplicación de forma headless, capturando capturas de pantalla y el árbol de accesibilidad (AOM).
- **Inspección multimodal:** El segundo modelo audita el screenshot contra estándares de diseño, contraste WCAG y estados interactivos (hover, mobile responsive, pantallas de error).

---

## Cuándo auditar: Checkpoints críticos

No tiene sentido auditar cada línea o comando (arruina el flujo de Vibe Coding). La auditoría adversarial se reserva para momentos clave:

- Antes de abrir un Pull Request o hacer merge a `main`.
- Cambios en capas de autenticación, pagos o Row Level Security (RLS).
- Migraciones de esquema en base de datos.
- Lanzamiento de flujos críticos de usuario hacia producción.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Elige una función o endpoint crítico de tu proyecto actual (por ejemplo, registro de usuarios o consulta con RLS). Pásaselo a un segundo modelo distinto al que lo programó con el siguiente prompt: *"Actúa como un auditor de seguridad implacable. No propongas código ni halagos; lista los 3 peores vectores de ataque o fallos lógicos por los cuales este archivo fallará en producción"*. Entrega ese reporte a Claude Code para que aplique los parches.

**Ejercicio 2 (avanzado):** Configura un script o hook de pre-commit que tome el `git diff` del área de staging y ejecute una revisión adversarial automática con un modelo secundario antes de permitir el commit.

---

## 💡 Tip

Cuando audites seguridad en backend, corre al auditor pasándole únicamente el archivo de rutas y la función sin el contexto de tus reglas generales. Forzar al modelo a evaluar el código de forma aislada e ignorante del resto del sistema revela de inmediato supuestos no validados y validaciones faltantes.

---

## ⚠️ Error común

Permitir que el modelo auditor genere y aplique directamente el fix sobre el código. Cuando el auditor repara, asume el rol de constructor y queda ciego ante las regresiones que él mismo introduce; la auditoría y la remediación deben mantenerse en agentes separados.
