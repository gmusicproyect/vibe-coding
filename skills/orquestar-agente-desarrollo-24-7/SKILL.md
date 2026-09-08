# SKILL: Orquestar Agente de Desarrollo Autónomo 24/7

> Guarda este archivo en `/skills/orquestar-agente-desarrollo-24-7/SKILL.md`
> y referencíalo en tu CLAUDE.md para que Claude Code lo use.

---

## Cuándo usar este skill

Cuando se configure, opere o audite un entorno de desarrollo desatendido donde un agente orquestador (Hermes, OpenClaw o bots de mensajería) delega tareas de programación, mantenimiento o resolución de bugs a Claude Code CLI de forma autónoma (mientras el usuario duerme o trabaja en remoto).

---

## Prerequisitos

- [ ] Entorno local o VPS siempre encendido (Mac Mini, VPS Linux o PC dedicado)
- [ ] Claude Code CLI instalado y autenticado en la máquina
- [ ] Orquestador o webhook receptor configurado (Hermes, OpenClaw o bot de Telegram)
- [ ] Repositorio Git inicializado con rama `main` protegida
- [ ] GitHub CLI (`gh`) autenticado o PAT con permisos restringidos (solo `contents:write` y `pull_requests:write`)

---

## Pasos

### Paso 1 — Establecer el protocolo de aislamiento Git

Todo trabajo desatendido debe ejecutarse obligatoriamente en una rama secundaria generada dinámicamente. El agente orquestador debe ordenar el checkout antes de tocar cualquier archivo:

```bash
git checkout -b feature/nombre-tarea-$(date +%Y%m%d-%H%M)
# o para correcciones de errores:
git checkout -b fix/sentry-issue-$(date +%Y%m%d-%H%M)
```

### Paso 2 — Inyección de contexto y directiva de alcance acotado

Al invocar Claude Code para la tarea autónoma, pasar la instrucción con límites claros de archivos a tocar y comando de verificación:

```bash
claude "Objetivo: [descripción de la tarea]. Modifica únicamente los archivos relacionados con [módulo]. Al finalizar, ejecuta [npm test / pytest / linter]. Si los tests pasan, crea un commit descriptivo. Si fallan, revierte los cambios y reporta el error sin comitear. Jamás cambies a la rama main."
```

### Paso 3 — Validación y apertura de Pull Request

Una vez concluidos los cambios y verificadas las pruebas locales:

```bash
git push -u origin HEAD
gh pr create --title "[Auto] Implementar tarea X" --body "Pull request generado automáticamente por agente 24/7. Requiere revisión humana antes de merge."
```

### Paso 4 — Notificación al operador remoto

El orquestador extrae la URL del Pull Request y envía un mensaje conciso al canal de mensajería (Telegram/Discord):
- Resumen del cambio (1-2 líneas)
- Archivos modificados y estado de tests locales
- Enlace directo al PR de GitHub para aprobación humana

---

## Outputs esperados

Al terminar este skill, el resultado debe ser:
- Rama Git aislada creada y pusheada al repositorio remoto
- Código modificado con pruebas locales pasando satisfactoriamente
- Pull Request creado en GitHub listo para inspección visual
- Notificación en Telegram/Discord con resumen y enlace al PR
- Rama `main` local y remota intacta

---

## Errores comunes

| Error | Causa probable | Solución |
|-------|---------------|---------|
| Agente commitea directamente en `main` | No se forzó el checkout previo o no hay reglas de protección | Bloquear push a `main` en GitHub y auditar el script del orquestador |
| Loop de comandos que nunca termina | Tarea demasiado ambigua o fallo recurrente en linter | Limitar iteraciones máximas en el prompt y definir timeout en el orquestador |
| Fallo de autenticación en push desatendido | Token de GitHub expirado o sin permisos de PR | Usar GitHub CLI con `gh auth status` y PAT con scope `pull_requests` |
| Conflictos de dependencias entre tareas | Tareas paralelas compartiendo el mismo working directory | Usar `git worktree` o workspaces aislados para cada tarea desatendida |

---

## Variaciones

**Variación A — Auto-fix reactivo con Sentry:** El trigger es un webhook de Sentry ante una excepción 500. El agente recibe el stack trace, crea rama `fix/sentry-[id]`, localiza la línea fallida, aplica test de regresión y abre el PR correctivo.

**Variación B — Mantenimiento nocturno programado:** `[PENDIENTE: confirmar con Juan — no se mencionó explícitamente en la sesión fuente; se infirió como extensión lógica del patrón de Variación A]`.

---

## Notas adicionales

La delegación autónoma 24/7 requiere compuertas de seguridad ("human-in-the-loop gates"). El valor del agente no radica en hacer auto-deploy a ciegas, sino en tener el trabajo preliminar, el análisis y el Pull Request listo para que el humano valide en 30 segundos con un click al despertar.

---

*Creado: 2026-09-07 · Última actualización: 2026-09-07*
