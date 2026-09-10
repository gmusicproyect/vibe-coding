# SKILL: Gestionar e Inspeccionar Agentes en VPS vía Remote SSH

> Guarda este archivo en `/skills/gestionar-agentes-vps-remote-ssh/SKILL.md`
> Referencia en tu CLAUDE.md: `- /skills/gestionar-agentes-vps-remote-ssh/SKILL.md → para conectar Antigravity/VS Code a servidores remotos y auditar la configuración de agentes (SOUL.md, openclaw.json) de forma visual`

---

## Cuándo usar este skill

Cuando el usuario requiera:
1. Conectar su entorno IDE (Antigravity, VS Code, Cursor) a un servidor VPS remoto para gestionar agentes autónomos (OpenClaw, Hermes, bots de Telegram).
2. Habilitar extensiones propietarias de Microsoft (como `Remote - SSH`) en Antigravity reemplazando el marketplace de Open VSX.
3. Auditar, depurar y editar visualmente la arquitectura cognitiva del agente (`SOUL.md`, `USER.md`, `openclaw.json`) sin depender de terminales SSH lentas o editores de consola (`nano`/`vim`).
4. Verificar la existencia real de subagentes y evitar alucinaciones operativas.

Basado en las directrices de la **Clase 24 — Claude Code vs. OpenClaw: Agentes y Subagentes**.

---

## Prerequisitos

- [ ] IDE instalado (Antigravity o VS Code).
- [ ] Servidor VPS con Linux (Ubuntu/Debian) y acceso SSH por contraseña o llave pública (`ssh-keygen`).
- [ ] Usuario dedicado no-root en el servidor (ej. `openclaw`).

---

## Pasos de Configuración y Auditoría

### Paso 1 — Habilitar el Marketplace de Microsoft en Antigravity
Por defecto, Antigravity apunta a Open VSX, donde la extensión oficial `Remote - SSH` de Microsoft no está disponible:
1. Abrir `Settings` (`Cmd + ,` o `Ctrl + ,`) en Antigravity.
2. Buscar o editar en `settings.json` las siguientes directivas de extension gallery:
   ```json
   {
     "extensions.gallery.serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
     "extensions.gallery.itemUrl": "https://marketplace.visualstudio.com/items"
   }
   ```
3. Abrir el panel de extensiones, buscar `Remote - SSH` (de Microsoft) e instalarla.

### Paso 2 — Conexión Remota al Servidor
1. Hacer clic en el botón verde/icono de Remote en la esquina inferior izquierda del IDE.
2. Seleccionar **Connect to Host...** -> **Add New SSH Host**.
3. Ingresar la cadena de conexión con el usuario aislado:
   ```bash
   ssh openclaw@<IP_DEL_VPS>
   ```
4. Seleccionar el archivo de configuración SSH (`~/.ssh/config`) e introducir la contraseña o clave SSH cuando se solicite.

### Paso 3 — Apertura del Directorio del Agente
Una vez establecida la sesión remota:
1. En el menú del IDE, ir a **File** -> **Open Folder**.
2. Abrir la ruta oculta de configuración del agente:
   ```text
   /home/openclaw/.openclaw
   ```
3. Explorar la estructura de archivos en el árbol lateral exactamente como si fuera un proyecto local.

### Paso 4 — Auditoría y Personalización Cognitiva
1. **Auditar el Alma (`workspace/SOUL.md`):**
   - Verificar tono, límites de ejecución y protocolos de toma de decisiones.
   - Corregir directivas de seguridad para evitar ejecución de comandos destructivos.
2. **Auditar el Perfil de Usuario (`workspace/USER.md`):**
   - Asegurar que el contexto del negocio, stacks utilizados y prioridades estén actualizados.
3. **Auditar Subagentes Reales (`openclaw.json`):**
   - Inspeccionar la sección `"agents"` en `openclaw.json`.
   - Si la lista contiene únicamente `"default"`, no existen subagentes reales; cualquier mención de subagentes por parte del bot en el chat es una alucinación del modelo.

### Paso 5 — Desinstalación o Limpieza Segura
Si el agente se corrompe y se requiere reiniciar:
- **Método limpio:** Eliminar únicamente el directorio `/home/openclaw/.openclaw`.
- **Nunca ejecutar `rm -rf` en el home general** si existen scripts o servicios coexistiendo en la misma cuenta de usuario.

---

## ⚠️ Errores comunes a evitar

| Error | Consecuencia | Solución |
| :--- | :--- | :--- |
| **Conectar como usuario `root`** | Riesgo de seguridad crítico si el agente ejecuta comandos no supervisados | Usar siempre un usuario restringido sin privilegios sudo |
| **Confiar en que existen subagentes sin verificar** | La IA finge delegar tareas que procesa el mismo modelo | Confirmar en `openclaw.json` o con `/subagents` en Telegram |
| **Instalar `Remote - SSH` en Open VSX sin cambiar endpoints** | La extensión no aparece o falla por incompatibilidad | Reconfigurar `serviceUrl` hacia el marketplace de Visual Studio |

---

*Creado: Septiembre 2026 · Basado en Clase 24 de Vibe Coding*
