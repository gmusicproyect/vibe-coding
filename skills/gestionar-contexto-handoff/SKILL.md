# SKILL: Gestionar Contexto y Handoff entre Sesiones

> Guarda este archivo en `/skills/gestionar-contexto-handoff/SKILL.md`
> y referencíalo en tu CLAUDE.md para que Claude Code lo use.

---

## Cuándo usar este skill

Cuando una sesión de desarrollo en Claude Code alcance o supere el 20% de la ventana de contexto (o tras 20-30 peticiones iterativas), cuando se concluya una feature o módulo del blueprint, o cuando sea necesario pausar el trabajo para retomarlo más tarde o delegarlo a otro agente o desarrollador sin degradación por alucinación.

---

## Prerequisitos

- [ ] Sesión activa de Claude Code en terminal o IDE.
- [ ] Acceso de lectura y escritura en la raíz del proyecto.

---

## Pasos

### Paso 1 — Auditar el estado del contexto

Antes de cerrar o transferir la sesión, revisa la saturación de la memoria:

```text
/context
```

Si el consumo supera el 20%, o si se observan advertencias de compactación de memoria, no inicies una nueva funcionalidad en este chat: procede inmediatamente a generar el handoff.

### Paso 2 — Generar el archivo de traspaso (`handoff.md`)

Solicita a Claude Code la creación del documento de transferencia con la siguiente estructura fija:

```markdown
# Handoff de Sesión — [Fecha y Hora]

## 1. Estado y Objetivo
- **Módulo / Feature:** [Nombre de la funcionalidad trabajada]
- **Objetivo completado:** [Resumen en 2-3 líneas de lo que se logró]

## 2. Archivos modificados y creados
- `ruta/al/archivo.ext`: [Descripción del cambio puntual]

## 3. Decisiones y Trade-offs técnicos
- [Decisión clave tomada, motivo técnico y librerías utilizadas]
- [Desviaciones del plan original o restricciones encontradas]

## 4. Tareas pendientes y siguientes pasos
1. [Paso 1 inmediato y accionable para la siguiente sesión]
2. [Paso 2]
3. [Paso 3]

## 5. Comandos de verificación
- [Comando de test, build o linter para validar que nada quedó roto]
```

### Paso 3 — Limpiar o reiniciar la sesión

1. Asegúrate de que los cambios estén guardados en disco.
2. Cierra la pestaña de chat actual o ejecuta en el prompt de Claude:
   ```text
   /clear
   ```
   (o abre una nueva terminal/sesión de Claude Code en el mismo directorio).

### Paso 4 — Reanudar en sesión limpia

En la sesión fresca recién iniciada, envía el siguiente prompt exacto:

```text
Lee el archivo handoff.md en la raíz del proyecto, hazme un resumen de 2 líneas de en qué nos quedamos y dime cuál es el primer paso exacto que debemos ejecutar para continuar.
```

---

## Outputs esperados

Al terminar este skill, el resultado debe ser:
- Un archivo `handoff.md` actualizado en la raíz del repositorio con los 5 bloques obligatorios.
- Una nueva sesión de Claude Code con el contexto al 0% de saturación, lista para ejecutar la siguiente tarea sin alucinaciones ni olvido de dependencias.

---

## Errores comunes

| Error | Causa probable | Solución |
|-------|---------------|---------|
| Claude alucina y borra funciones previas | Se continuó trabajando en un chat compactado tras 30+ mensajes | Detener el chat y forzar la generación del `handoff.md` antes de seguir |
| El handoff es ambiguo y la nueva sesión no sabe qué hacer | Se redactó en prosa genérica sin lista numerada de pasos pendientes | Exigir que la sección 4 contenga pasos técnicos concretos y verificables |
| Se pierden variables o decisiones | No se documentaron los trade-offs técnicos en el archivo | Añadir los cambios no evidentes en la sección 3 del handoff |

---

## Variaciones

**Variación A — Handoff entre Frontend y Backend:**
Cuando dos repositorios o carpetas separadas interactúan vía webhooks o APIs (ej. Next.js y N8N/Docker), genera un `handoff-front-to-back.md` con los endpoints exactos y contratos JSON esperados para que el otro agente configure su parte.

---

## Notas adicionales

La compactación automática de memoria en los LLMs es una ilusión de continuidad: descarta detalles finos y corrompe la precisión del código. El `handoff.md` convierte la memoria volátil del chat en documentación persistente y versionable.

---

*Creado: Septiembre 2026 · Vibe Coding — Imperio Digital*
