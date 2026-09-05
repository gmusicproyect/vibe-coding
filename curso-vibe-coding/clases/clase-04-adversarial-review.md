# Clase 04 — El que encuentra el bug no lo arregla

**Tags:** `Adversarial Review` `Codex` `Seguridad` `Auditoría`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 02](clase-02-tunear-claude-code.md) · [Clase 03](clase-03-segundo-cerebro.md)

---

## Idea central

Pedirle al mismo modelo que escribió tu código que lo revise produce una validación complaciente ("el autógrafo"), no una auditoría real. Una revisión adversarial introduce un segundo modelo independiente (OpenAI Codex) con el único objetivo de destruir la solución y hallar brechas de seguridad o fallos visuales. La regla de oro operativa es estricta: **el que audita no repara**. Codex encuentra los fallos; Claude Code aplica las correcciones.

---

## Instalación y configuración del plugin oficial de Codex

Para auditar sin salir del contexto de Claude Code ni copiar y pegar entre ventanas:

1. **Instalar el plugin:** Ejecuta `/plugin` en Claude Code → selecciona `Manage Plugins` → busca e instala `Codex` (`@openai/codex` desde Marketplace).
2. **Autenticar:** Ejecuta en el prompt de Claude `!codex login` (o en terminal `codex login`). Abrirá el navegador para iniciar sesión en OpenAI; Claude detecta la salida y confirma la sesión automáticamente.
3. **Verificar estado:** Ejecuta `/codex:status` para confirmar conexión con el CLI y verificar si hay tareas activas.

---

## Comandos y flags de ejecución adversarial

| Comando / Flag | Función operativa |
|----------------|-------------------|
| `/codex:adversarial-review` | Lanza la auditoría del segundo modelo sobre el código actual. |
| `--base main` | Compara los cambios de la rama actual contra la rama base `main`. |
| `--background` | Ejecuta la auditoría en segundo plano para seguir chateando con Claude. |
| `/codex:cancel` | Cancela un trabajo de auditoría que esté corriendo en background. |
| `npm i -g @openai/codex-security` | Instala el CLI de Codex Security para escaneos fuera de Claude Code. |
| `codex-security scan . --budget 5` | Escaneo de seguridad independiente con tope presupuestario (\$5 USD). |

> Carlos recomienda usar el plugin `/codex:adversarial-review` integrado dentro de Claude Code: permite que Claude lea el reporte directamente en la conversación y aplique los parches sin fricción manual.

---

## Las tres trampas al auditar con LLMs

1. **Filtros de seguridad (Safety filters):** Prompts con palabras como "hackea" o "haz un pentest" son bloqueados por las políticas de OpenAI. Debe enmarcarse como *análisis estático defensivo de seguridad OWASP*.
2. **Secuestro por directivas (`AGENTS.md` / `CLAUDE.md`):** Si tu archivo dice "la autenticación ya es segura con Supabase", el auditor asume la premisa como un hecho y no revisa. Ejecuta con `--project-doc-max-bytes 0` o aísla el archivo a auditar.
3. **El auditor que parcha:** Si dejas que Codex aplique los fixes, asume el rol de constructor y queda ciego ante sus propios errores. Codex lista hallazgos; Claude Code corrige.

---

## Auditoría visual de interfaces (UI)

Los LLMs son ciegos al renderizado real (botones de 19px, contrastes fallidos WCAG o layouts rotos). Para darles ojos:
- **Herramientas headless:** Integra **Playwright** o **Station** (alternativa liviana y económica para agentes que captura pantallas y navega flujos).
- **Inspección multimodal:** El agente toma screenshots y el árbol de accesibilidad (AOM), pasándoselos al segundo modelo para auditar estados interactivos y pantallas de error.
- **Higiene de `.gitignore`:** Agrega siempre `screenshots/`, grabaciones `.mp4` y volcados `.csv` de prueba al `.gitignore` para no subir datos sensibles ni basura al repositorio.

---

## 🎯 Ejercicio práctico

**Ejercicio 1 (Reproducción guiada):**
1. Instala el plugin en Claude Code con `/plugin` → `Manage Plugins` → `Codex` y autentica con `!codex login`.
2. En una rama de trabajo, crea o modifica un endpoint con autenticación o consulta SQL.
3. Ejecuta en Claude Code: `/codex:adversarial-review --base main`.
4. Cuando Codex devuelva el reporte de vulnerabilidades, indícale a Claude Code: *"Analiza los hallazgos reportados por Codex y aplica los parches de seguridad estrictamente necesarios sin modificar la lógica de negocio"*.

**Ejercicio 2 (avanzado):** Instala `@openai/codex-security` globalmente y corre un escaneo local de tu proyecto limitando el costo (`codex-security scan . --budget 2 --reasoning low`). Compara el archivo `report.md` generado contra el resultado del plugin integrado.

---

## 💡 Tip

No audites cada línea de código; quema tokens y frena el flujo. Reserva la auditoría adversarial para **checkpoints críticos**: antes de un Pull Request a `main`, al tocar Row Level Security (RLS), al alterar esquemas con migraciones SQL o al publicar endpoints de pagos/auth.

---

## ⚠️ Error común

Pedirle a Claude Code "¿ves algún fallo en este código?" sobre el archivo que él mismo acaba de generar. Claude confirmará que su solución es óptima. Para auditar de verdad, debes forzar el incentivo negativo con un segundo modelo o con un prompt de destrucción explícito.
