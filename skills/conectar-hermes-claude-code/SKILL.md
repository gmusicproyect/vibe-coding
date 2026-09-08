# SKILL: Conectar Hermes con Claude Code CLI

> Guarda este archivo en `/skills/conectar-hermes-claude-code/SKILL.md`
> y referencíalo en tu CLAUDE.md para que Claude Code lo use.

---

## Cuándo usar este skill

Cuando se desee configurar, auditar o resolver la integración entre un agente orquestador 24/7 (Hermes en Discord o Telegram) y Claude Code CLI instalado en un servidor local (Mac Mini) o VPS Linux, permitiendo controlar el desarrollo de software de forma remota.

---

## Prerequisitos

- [ ] Instancia de Hermes operativa (con interfaz en Telegram o bot en Discord)
- [ ] Claude Code CLI instalado en la misma máquina o contenedor
- [ ] Usuario de sistema no-root dedicado para Hermes y Claude Code
- [ ] GitHub CLI (`gh`) y Git configurados con credenciales SSH o tokens
- [ ] Repositorio del proyecto clonado en el entorno de ejecución

---

## Pasos

### Paso 1 — Configurar el entorno de usuario no-root

Por seguridad, Hermes y Claude Code deben residir en el mismo usuario del sistema operativo con permisos acotados, nunca en la cuenta `root`:

```bash
# Verificar usuario actual
whoami

# Instalar Claude Code en el entorno del usuario
npm install -g @anthropic-ai/claude-code
claude --version
```

### Paso 2 — Implementar sincronización automática de repositorios

Configura un hook o instrucción previa en el agente Hermes para que antes de delegar cualquier tarea a Claude Code, actualice el repositorio local con la rama remota:

```bash
cd /ruta/al/proyecto && git pull origin main
```

### Paso 3 — Integrar el comando de ejecución headless (Print Mode)

En el prompt del sistema o herramienta de ejecución bash de Hermes, configura el formato de llamada a Claude Code:

```bash
# Sintaxis de ejecución directa sin interfaz TTY
claude -p "Contexto: repositorio auditado. [Instrucción específica del usuario]. Reporta únicamente el resumen del resultado."
```

Para tareas de lectura o auditoría:
```bash
claude -p "Revisa las rutas en /src/app y lista qué endpoints faltan documentar en OpenAPI."
```

### Paso 4 — Modo interactivo con multiplexor Tmux (opcional)

Si la tarea requiere interacción continua o permisos paso a paso:

```bash
# Iniciar sesión desacoplada en Tmux
tmux new-session -d -s hermes-claude 'claude --auto'

# Enviar instrucciones y capturar output
tmux send-keys -t hermes-claude "Implementa el test unitario para auth" Enter
tmux capture-pane -pt hermes-claude
```

---

## Outputs esperados

Al terminar este skill, el resultado debe ser:
- Hermes ejecutando comandos de Claude Code CLI ante mensajes en Discord/Telegram
- Respuestas de Claude Code formateadas y devueltas al chat en tiempo real
- Repositorio local sincronizado sin conflictos de permisos
- Operación en entorno seguro de usuario no-root

---

## Errores comunes

| Error | Causa probable | Solución |
|-------|---------------|---------|
| `claude: command not found` en Hermes | Claude Code se instaló en root o PATH no está expuesto al servicio | Instalar con npm global en el usuario Hermes o agregar PATH en `.bashrc` / `.zshrc` |
| Bloqueo indefinido esperando input | Se invocó `claude` interactivo sin `-p` ni multiplexor Tmux | Utilizar siempre la bandera `-p` (print mode) para ejecuciones desatendidas |
| Conflictos de merge o repo desactualizado | El repo local en el VPS divergió del remoto | Forzar `git pull` antes de cada invocación de Claude Code |
| Saturación de tokens en Hermes | El LLM de Hermes (ej. GPT-5 / Opus) procesa outputs gigantes de Claude | Usar modelos económicos para Hermes (DeepSeek V4 Pro en Open Code Go) y pedir outputs concisos |

---

## Variaciones

**Variación A — Orquestación vía Telegram:** Uso de comandos nativos de Telegram (`/models`, `/status`) para alternar el modelo base de Hermes antes de despachar la tarea a Claude Code.

**Variación B — Integración con Agents SDK:** En lugar de invocar el binario CLI vía bash, Hermes invoca un endpoint HTTP interno que expone el Claude Agents SDK en NodeJS.

---

## Notas adicionales

La combinación Hermes + Claude Code representa la separación limpia entre interfaz conversacional ubicua (chat en el celular) y motor de ejecución de código (terminal con herramientas bash y file system). El estándar ACP (Agent Client Protocol) estandarizará esta comunicación en el futuro.

---

*Creado: 2026-09-07 · Última actualización: 2026-09-07*
