# Clase 19 — Claude Code + N8N: Kit, MCP y Skills desde 0

**Tags:** `n8n` `MCP` `Playwright` `Coolify`
**Conecta con:** Clase 02 · Clase 08 · Clase 18

---

## Idea central

Integrar Claude Code con n8n mediante servidores MCP permite diseñar, descargar, auditar y desplegar workflows deterministas de forma autónoma. La clave de esta arquitectura es la doble validación: la API de n8n manipula los nodos en segundo plano mientras Playwright, conectado al perfil activo de Chrome, navega la interfaz visual para verificar conexiones, resolver errores de configuración en vivo y registrar aprendizajes en `MEMORY.md`.

---

## 1. Componentes del Kit de Automatización (n8n-automation-kit)

El kit estandariza el entorno de trabajo agrupando credenciales, reglas y herramientas en la raíz del proyecto:

| Componente | Archivo / Directorio | Función principal |
| :--- | :--- | :--- |
| **Configuración MCP** | `.mcp.json` | Conexión con n8n (API URL con `/` final), Coolify y Playwright |
| **Contexto del Proyecto** | `CLAUDE.md` | Cuestionario con reglas de negocio, credenciales y nodos permitidos |
| **Memoria Evolutiva** | `MEMORY.md` | Registro de errores corregidos, bugs de nodos y setup específico |
| **Skills Especializadas** | `skills/` | `n8n-coolify-fullstack`, `make-to-n8n`, `n8n-sdk-rules` |
| **Subagente Arquitecto** | `agents/workflow-architect` | Diseña la arquitectura completa antes de tocar el lienzo |
| **Plantillas Base** | `workflows/starters/` | Estructuras iniciales con sticky notes y webhook routers |

---

## 2. Workflows Deterministas vs. Agentes de IA

Claude Code alcanza su máxima eficacia en flujos lógicos deterministas con reglas de bifurcación cerradas:

- **Casos ideales para Claude Code:** Generación de contenido con APIs (ej. guion, voz en ElevenLabs, mezcla con FFmpeg en Coolify y subtítulos), webhooks, sincronización con bases de datos y transformaciones JSON complejas.
- **Limitaciones actuales:** Diseñar nodos interactivos de `AI Agent` con múltiples herramientas dinámicas y memorias conversacionales complejas suele requerir intervención humana directa para la configuración fina de prompts y parámetros en la interfaz.

---

## 3. Doble Capa de Validación: API + Playwright

Cuando un nodo falla o genera conexiones inválidas (como discrepancias entre versiones de nodos de Google Sheets o triggers rotos):

1. **Inspección vía API:** Claude Code consulta el JSON del workflow para analizar la estructura de nodos.
2. **Inspección visual con Playwright:** Claude Code abre una sesión de Chromium vinculada al perfil preautenticado del usuario:
   ```bash
   # En .mcp.json apuntando al perfil con sesión iniciada
   --user-data-dir=/Users/TU_USUARIO/Library/Application Support/Google/Chrome/Profile X
   ```
3. **Autocorrección y documentación:** Playwright detecta el error en pantalla, reemplaza el nodo por el componente canónico y documenta el parche en `MEMORY.md` para evitar repetir el error en futuros sprints.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Clona el kit de automatización, vincula tu instancia de n8n y descarga tus workflows existentes:
1. Clona el repositorio y entra al directorio:
   ```bash
   git clone https://github.com/Carlos-Dominguez-faber/n8n-automation-kit mi-n8n-kit
   cd mi-n8n-kit
   ```
2. Genera `.mcp.json` desde la plantilla y configura tu API Key y URL (asegúrate de incluir la barra `/` final en la URL de n8n):
   ```bash
   cp .mcp.json.example .mcp.json
   ```
3. Abre Claude Code en la raíz del proyecto y extrae tus flujos para contextualizar al agente:
   ```text
   Conéctate a mi n8n mediante MCP, lista todos los workflows activos y guarda el JSON de cada uno en la carpeta workflows/.
   ```

**Ejercicio 2 (avanzado):** Exporta un blueprint JSON desde Make, colócalo en `workflows/` y pide a Claude Code que utilice el skill `make-to-n8n` para traducirlo a un workflow nativo de n8n documentado con sticky notes.

---

## 💡 Tip

> **Técnica Rewind (Escape + Escape) ante desvíos:** Si Claude Code inicia un bucle de corrección innecesario o toma un camino erróneo en la interfaz, presiona `Escape` dos veces para activar el comando `/rewind`. Esto te regresa al turno previo sin acumular mensajes fallidos en la ventana de contexto ni inflar el costo de input tokens en turnos futuros.

---

## ⚠️ Error común

> **Omitir la barra diagonal final en N8N_API_URL:** Configurar `"N8N_API_URL": "https://mi-n8n.app"` sin la `/` al final en `.mcp.json` provoca fallos silenciosos en las peticiones REST del servidor MCP. Asegúrate siempre de definir `"https://mi-n8n.app/"` para evitar errores 404 de concatenación.
