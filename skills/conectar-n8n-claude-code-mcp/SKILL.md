# SKILL: Conectar N8N con Claude Code vía MCP y Playwright

> Guarda este archivo en `/skills/conectar-n8n-claude-code-mcp/SKILL.md`
> y referencíalo en tu CLAUDE.md para que Claude Code lo use.

---

## Cuándo usar este skill

Cuando se requiera integrar Claude Code con una instancia de n8n para crear, inspeccionar, auditar o migrar workflows deterministas de automatización, utilizando el servidor MCP oficial y validación visual asistida por Playwright en un navegador con sesión persistente.

---

## Prerequisitos

- [ ] Instancia de n8n operativa (Cloud, VPS o Coolify) con API habilitada y API Key generada
- [ ] Claude Code CLI instalado en la máquina local o entorno de desarrollo
- [ ] Perfil de Google Chrome persistente con sesión ya iniciada en n8n
- [ ] Acceso de escritura al repositorio local del proyecto

---

## Pasos

### Paso 1 — Inicializar el entorno del proyecto

Clona la estructura base del kit de automatización o prepara tu directorio de trabajo con soporte MCP:

```bash
git clone https://github.com/Carlos-Dominguez-faber/n8n-automation-kit mi-proyecto-n8n
cd mi-proyecto-n8n
```

### Paso 2 — Configurar credenciales en `.mcp.json`

Copia la plantilla de configuración MCP y define las variables de entorno. Es imprescindible incluir la barra `/` final en la URL de n8n:

```bash
cp .mcp.json.example .mcp.json
```

Edita `.mcp.json` con los valores de tu entorno:

```json
{
  "mcpServers": {
    "n8n-mcp": {
      "env": {
        "N8N_API_URL": "https://tu-instancia.app/",
        "N8N_API_KEY": "tu_api_key_aqui"
      }
    },
    "playwright": {
      "command": "npx",
      "args": [
        "-y",
        "@executeautomation/playwright-mcp-server",
        "--user-data-dir=/Users/TU_USUARIO/Library/Application Support/Google/Chrome/Profile 2"
      ]
    }
  }
}
```

### Paso 3 — Rellenar el contexto del proyecto y memoria

Completa las secciones críticas de `CLAUDE.md`:
1. **Infraestructura:** URL de n8n, microservicios asociados y credenciales disponibles por su nombre exacto.
2. **Alcance y Reglas de Negocio:** Objetivos de las automatizaciones, límites de ejecución y nodos preferidos.
3. **Inicialización de `MEMORY.md`:** Archivo en la raíz donde Claude Code documentará automáticamente errores de nodos y soluciones comprobadas.

### Paso 4 — Extraer el catálogo de workflows existentes

Antes de crear nuevos flujos, pide a Claude Code que sincronice el estado actual de tu n8n para no duplicar lógica:

```bash
claude -p "Conéctate a n8n vía MCP, lista todos los workflows existentes y guarda el JSON de cada uno en la carpeta workflows/."
```

### Paso 5 — Crear o migrar workflows deterministas

Solicita la construcción del flujo deseado especificando entradas, transformaciones lógicas y salidas:

```bash
claude -p "Crea un workflow determinista en n8n que reciba un webhook, valide el payload, ejecute una consulta a Supabase y envíe notificación a Slack. Usa sticky notes para documentar cada fase."
```

### Paso 6 — Doble capa de validación y autocorrección

Si la API reporta discrepancias o nodos con parámetros obsoletos:
1. Pide a Claude Code que active Playwright con el perfil persistente de Chrome para abrir el lienzo de n8n.
2. Permite que el agente identifique el error visual en el nodo y ajuste las conexiones.
3. Tras la corrección, exige a Claude Code que registre el aprendizaje en `MEMORY.md`:
   ```text
   Documenta en MEMORY.md el error encontrado en el nodo de trigger y cuál fue la solución aplicada para no repetirlo.
   ```

---

## Outputs esperados

Al terminar este skill, el resultado debe ser:
- Servidor MCP conectado y funcional entre Claude Code y la instancia de n8n.
- Workflows deterministas generados y desplegados directamente en el lienzo de n8n.
- Documentación visual mediante sticky notes incorporada en cada workflow.
- Archivo `MEMORY.md` actualizado con el histórico de parches y comportamientos especiales de nodos.

---

## Errores comunes

| Error | Causa probable | Solución |
| :--- | :--- | :--- |
| **Error 404 en llamadas MCP** | Falta la barra `/` final en `N8N_API_URL` | Configura siempre `"https://tu-instancia.app/"` en `.mcp.json`. |
| **Playwright pide login en bucle** | Se utilizó un perfil temporal o no se inició sesión previa | Abre Chrome en el perfil configurado, inicia sesión en n8n manualmente y luego ejecuta Claude Code. |
| **Líneas curvas o nodos desconectados** | Nombres o versiones de nodos incompatibles entre v1 y v2 de n8n | Usa Playwright para inspeccionar el lienzo o reemplaza el nodo por el trigger estándar actual. |
| **Bucle infinito de corrección en chat** | Respuestas acumulativas en lugar de resetear turno | Presiona `Escape + Escape` para activar `/rewind` y reenviar la instrucción depurada. |

---

## Variaciones

**Variación A — Migración automatizada desde Make:**
Coloca el archivo de exportación JSON de Make (blueprint) en la carpeta `workflows/` e invoca a Claude Code con el skill `make-to-n8n` para traducir la lógica a nodos nativos de n8n.

**Variación B — Orquestación con microservicios en Coolify:**
Si requieres procesamiento pesado (ej. transformaciones de video con FFmpeg), configura el MCP de Coolify para levantar contenedores Docker dedicados que n8n consuma vía HTTP Request.
