# Clase 02 — Cómo tunear tu Claude Code

**Tags:** `Claude Code` `Hooks` `Configuración` `GLM`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 03](clase-03-segundo-cerebro.md)

---

## Idea central

Usar Claude Code con la configuración de fábrica desaprovecha su arquitectura. Existen tres niveles de control sobre el agente: instrucciones que son sugerencias, configuraciones que son reglas y hooks que son paredes infranqueables. Blindar la terminal con hooks, optimizar la salida para ahorrar tokens y alternar motores según la tarea convierte al agente en una herramienta de ingeniería predecible.

---

## Los tres niveles de control del agente

| Nivel | Mecanismo | Comportamiento | Cuándo usarlo |
|-------|-----------|----------------|---------------|
| **1. Sugerencia** | `CLAUDE.md` | El agente lo lee y lo considera, pero puede olvidarlo al saturarse el contexto. | Estilo de código, flujo de trabajo, convenciones de arquitectura. |
| **2. Regla** | `settings.json` | Configuración dura del arnés; se aplica siempre sin depender de la memoria del LLM. | Estilo de respuesta (`outputStyle`), permisos automáticos, herramientas activas. |
| **3. Pared** | `hooks/` | Scripts locales que se ejecutan antes o después de cada acción y pueden abortarla con error. | Acciones críticas que jamás deben ocurrir (borrado destructivo, tocar `.env`). |

---

## Optimización del arnés: Salida concisa y Statusline

- **Salida concisa (`outputStyle`):** El comando `/output-style` fue deprecado; ahora se define en `settings.json` (o vía `/config`) como `"concise"`, o mediante estilos personalizados en Markdown (`sin-humo.md`). Elimina preámbulos, felicitaciones y verborrea, reduciendo drásticamente el consumo de tokens de salida (los más caros).
- **Línea de estado personalizada (`statusline.sh`):** Muestra de forma visual en la terminal el modelo activo, costo acumulado, porcentaje de ventana de contexto usado, tiempo restante para reinicio de cuota y rama de Git. Solo visible en entornos CLI y extensiones, no en la app de escritorio.

---

## Las cuatro paredes de seguridad (Hooks del taller)

1. **Freno de mano:** Intercepta y cancela comandos destructivos (`rm -rf /`, `git push --force`, `DROP TABLE`). El script aborta la ejecución antes de tocar el sistema y fuerza al agente a auto-corregirse.
2. **Blindaje de secretos:** Prohíbe que el agente escriba o sobreescriba archivos sensibles (`.env`, claves privadas, credenciales de servicio); solo permite lectura para evitar pérdida irreparable de credenciales.
3. **Formateo y auditoría:** Ejecuta linters/formatters (Prettier) o genera comentarios explicativos automáticos tras cada edición de código para facilitar la revisión del desarrollador.
4. **Notificaciones de turno largo:** Dispara un aviso sonoro o notificación push al móvil (vía control remoto) solo cuando un turno largo termina o cuando el agente requiere un input del usuario.

---

## Motor alterno: Claude Code con GLM 5.3

El arnés (interfaz, atajos y herramientas de Claude Code) es independiente del motor (el LLM que procesa). Mediante variables de entorno y un alias interactivo (`cc`), se puede alternar el motor al iniciar la sesión:

- **Usar GLM 5.3:** Boilerplate inicial, refactorings mecánicos masivos, subagentes de exploración, documentación y changelogs. Aprovecha que el horario pico de China es la madrugada en América para operar a mitad de costo.
- **Usar Claude (Opus / Sonnet):** Decisiones de arquitectura, planes iniciales de producto, código financiero o de pagos y revisiones finales de seguridad.

---

## Orquestación entre sesiones con @menciones

Al nombrar sesiones activas con `/rename <nombre>` (ej. `/rename orquestador` y `/rename ejecutor`), las distintas instancias de terminal en el mismo proyecto o proyectos relacionados pueden comunicarse directamente entre sí usando `@nombre`. Esto permite consultar dudas o delegar subtareas sin ensuciar la ventana de contexto de la sesión principal.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Abre la configuración de tu Claude Code con `/config` y cambia el `outputStyle` a `concise`. Ejecuta una consulta técnica y verifica que la respuesta vaya directo al grano sin introducciones ni halagos.

**Ejercicio 2 (el que de verdad importa — construir una pared):** Crea en `~/.claude/hooks/` un script (bash o Python) que reciba el JSON de un evento `PreToolUse` sobre `Write|Edit`, y si el `file_path` termina en `.env`, bloquee la escritura devolviendo `permissionDecision: "deny"`. Referencia ese script en `settings.json`. Pruébalo pidiéndole a Claude Code que escriba algo en un `.env` de prueba: **debe bloquearse solo**, sin que se lo pidas en el chat. Esa es la diferencia real entre una sugerencia (nivel 1) y una pared (nivel 3).

**Ejercicio 3 (avanzado):** Abre dos terminales en el mismo proyecto. Renombra la primera con `/rename orquestador` y la segunda con `/rename ejecutor`. Pídele al orquestador que analice un cambio y le envíe la instrucción de implementación a `@ejecutor` verificando la respuesta en la segunda terminal.

---

## 💡 Tip

Aplica la máxima de seguridad agéntica: **"Lo que no puede pasar, no lo pidas por escrito"**. Nunca confíes en una advertencia textual en tu `CLAUDE.md`. Si una acción puede destruir código, borrar tablas o exponer credenciales, bloquéala siempre mediante un hook ejecutable a nivel de sistema.

---

## ⚠️ Error común

Escribir hooks basados en filtros ingenuos de cadenas que se evaden fácilmente (por ejemplo, buscar la cadena exacta `rm -rf`, la cual se esquiva escribiendo comillas como `rm "-rf"` o rutas con comodines). Un candado que se abre con un truco es peor que no tener candado porque te confías; el hook debe normalizar el comando antes de evaluarlo.
