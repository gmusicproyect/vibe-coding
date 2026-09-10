# Clase 30 — Supabase y MCP: Conexiones Dinámicas en Antigravity

**Tags:** `Supabase` `MCP` `Antigravity` `Integraciones`
**Conecta con:** [Clase 25](clase-25-antigravity-claude-code-openclaw.md) · [Clase 28](clase-28-instalacion-configuracion-antigravity.md) · [Clase 29](clase-29-dominando-antigravity-manual-del-1.md)

---

## Idea central

El Model Context Protocol (MCP) estandariza la interacción entre modelos de IA y herramientas externas actuando como un puerto universal sin requerir conectores ad-hoc manuales. Al acoplar Supabase como backend relacional estructurado (1 a N) junto a los servidores MCP de GitHub, Supabase, Vercel y n8n en Antigravity, el agente adquiere capacidad operativa para auditar repositorios, manipular esquemas de bases de datos, gestionar despliegues y disparar automatizaciones directamente desde el chat.

---

## 1. Supabase como Backend Relacional para MVPs

Supabase provee una alternativa open-source a Firebase sobre PostgreSQL puro, eliminando el vendor lock-in e integrando autenticación, almacenamiento y APIs generadas automáticamente:

- **Cuándo utilizarlo:** Aplicaciones con usuarios que requieran sesiones reales, políticas de seguridad a nivel de fila (RLS) y entidades fuertemente vinculadas.
- **Cuándo prescindir de él:** Sitios estáticos sin captura de datos o backends con microservicios de extrema complejidad arquitectónica.
- **Estructura Relacional (1 a N):** El flujo del proyecto garantiza trazabilidad histórica y auditoría encadenando:
  - Clientes → Diagnósticos (un cliente posee múltiples diagnósticos).
  - Diagnósticos → Cotizaciones (cada diagnóstico genera diversas propuestas).
  - Cotizaciones → Correos enviados (cada cotización registra su historial de envíos en n8n).

---

## 2. Métodos de Conexión de Servidores MCP en Antigravity

No existe una única vía de integración; Antigravity admite configuraciones nativas, ajustes vía NPX, sesiones cacheadas y repositorios clonados:

| Herramienta | Modalidad | Procedimiento de Configuración | Verificación Obligatoria |
| :--- | :--- | :--- | :--- |
| **GitHub** | Nativo / NPX | Instalar desde menú MCP, generar Personal Access Token clásico y migrar el comando de Docker a `npx` en el JSON. | Pedir al agente: *"Lístame mis repositorios"*. |
| **Supabase** | Nativo directo | Instalar MCP nativo, generar Personal Access Token en Supabase y pegar en el prompt del IDE. | Pedir al agente: *"Confirma acceso a mi proyecto"*. |
| **Vercel** | Manual / CLI | Agregar bloque `npx` en configuración cruda JSON; autenticar con `npx vercel login` vía browser. | Pedir al agente: *"Revisa mis proyectos y último deploy"*. |
| **n8n** | Asistido / Repo | Clonar repo oficial del MCP con el agente, definir URL del servidor y API key generada en settings. | Pedir al agente: *"Lístame mis workflows activos"*. |

---

## 3. Protocolo de Validación y Gobernanza de Integraciones

Para garantizar que los fallos futuros provengan de la lógica de negocio y no de desconexiones silenciosas en las herramientas:

1. **Aislamiento de Tokens:** Configura siempre los Personal Access Tokens con caducidad corta (ej. 7 días en fases de prueba) y restringe los permisos (*scopes*) estrictamente a repositorios, flujos de trabajo y lectura de proyectos.
2. **Edición Manual de Configuración:** Ante errores con contenedores Docker locales, abre `Manage MCP Servers → View Raw Config` para forzar la ejecución liviana mediante ejecutores `npx`.
3. **Regla de Oro (Prueba de Humo Inmediata):** Cada vez que conectes un servidor MCP, guarda el archivo de configuración, refresca el panel y ejecuta una consulta de lectura básica en lenguaje natural antes de escribir código.

---

## 🎯 Ejercicio práctico

Conectar y verificar los servidores MCP esenciales dentro del espacio de trabajo de Antigravity.

**Ejercicio 1:** Abre Antigravity y dirígete a `Manage MCP Servers`. Conecta el MCP nativo de Supabase ingresando tu Personal Access Token. Luego, abre el archivo de configuración cruda (`View Raw Config`), añade manualmente el conector de Vercel vía `npx` y autentica tu sesión local ejecutando `npx vercel login` en la terminal integrada. Confirma ambas conexiones solicitando al agente que liste tu proyecto de base de datos y tus despliegues activos.

**Ejercicio 2 (avanzado, opcional):** Genera una API key en tu instancia de n8n, solicita a un agente de Antigravity que configure el conector oficial de n8n en el JSON de MCPs y valida la comunicación pidiéndole que extraiga la lista de flujos de automatización configurados.

---

## 💡 Tip

Si Antigravity intenta ejecutar el MCP de GitHub a través de un contenedor Docker local y falla la inicialización, abre `View Raw Config` y reemplaza el bloque por una llamada directa mediante `npx` especificando la variable de entorno `GITHUB_PERSONAL_ACCESS_TOKEN`. Es mucho más liviano, no depende del demonio de Docker y opera de inmediato en macOS, Windows o Linux.

---

## ⚠️ Error común

Conectar múltiples servidores MCP en serie y comenzar a programar la aplicación sin haber verificado individualmente cada uno con una consulta de lectura. Cuando una operación falle más adelante, será imposible determinar si el origen del error radica en la lógica del código, en permisos insuficientes del token o en un fallo de transporte del protocolo MCP.

---
