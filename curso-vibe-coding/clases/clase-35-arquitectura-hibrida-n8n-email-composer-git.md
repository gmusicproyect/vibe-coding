# Clase 35 — Arquitectura Híbrida con n8n, Email Composer y Buenas Prácticas con Git

**Tags:** `n8n` `Email Composer` `MCP` `Git Best Practices`
**Conecta con:** [Clase 19](clase-19-claude-code-n8n-kit.md) · [Clase 30](clase-30-supabase-mcp-conexiones-antigravity.md) · [Clase 34](clase-34-supabase-tablas-sql-guardado-fixes.md)

---

## Idea central

El modelo híbrido de Vibe Coding desacopla la experiencia de usuario de la ejecución pesada, combinando una interfaz moderna y reactiva construida en Antigravity con flujos de automatización desatendidos en n8n. Al delegar la redacción inteligente del correo al frontend y confinar el rol de n8n exclusivamente al despacho vía webhook y confirmación por Gmail, se evitan puntos de fricción, se garantiza la trazabilidad con tablas de auditoría en Supabase y se asegura la replicabilidad mediante commits atómicos y documentación técnica.

---

## 1. El Patrón Híbrido: Frontend Reactivo + Backend n8n

Para agencias y desarrolladores que operan su lógica de negocio en n8n pero requieren interfaces presentables para clientes, este patrón ofrece ventajas sobre las arquitecturas monolíticas:

- **Frontend en Antigravity:** Gestiona la autenticación, la vista de clientes, el selector de cotizaciones, la generación de textos con IA y el historial de envíos.
- **Automatización en n8n:** Opera como un microservicio sin estado que recibe peticiones HTTP mediante un Webhook Trigger, ejecuta acciones con proveedores externos (ej. Gmail API) y emite un Webhook Response estructurado.
- **Simplificación del Payload:** En lugar de forzar a n8n a procesar diagnósticos complejos, el frontend genera el asunto y cuerpo del mensaje con IA (con el enlace de la cotización ya embebido en el texto), enviando solo tres datos limpios: `subject`, `body` y el correo del cliente.

---

## 2. Nueva Feature: Vista de Cotizaciones y Email Composer

La herramienta incorpora una sección de negocio orientada al cierre comercial dividida en dos paneles sincronizados:

| Componente | Funcionalidad Clave | Interacción y Estado |
| :--- | :--- | :--- |
| **Panel Izquierdo** | *Email Composer* con IA | Selector de cliente con autocompletado de email, redacción de propuesta asistida y botón de envío. |
| **Panel Derecho** | Historial de envíos | Lista cronológica vinculada a la tabla `emails_sent` con timestamp y check verde de confirmación. |
| **Gestión de Clientes** | Edición de contacto | Vista complementaria para auditar y actualizar direcciones de correo faltantes antes del despacho. |
| **Seguridad RLS** | Políticas en Supabase | Creación explícita de la tabla `emails_sent` con permisos de inserción y lectura para usuarios autenticados. |

---

## 3. Protocolo de Integración MCP y Hábitos Profesionales en Git

Para evitar errores de autorización y pérdidas de código durante la iteración asistida:

1. **Credenciales en n8n:** Los errores de autenticación en el MCP de n8n no suelen ser de URL, sino de tipo de llave. No utilices tokens JWT genéricos; genera una API key específica en *Personal Settings → API → Create API Key* y asígnala en `.env.local`.
2. **Confirmación Obligatoria (Two-Way Handshake):** La interfaz web jamás debe marcar un correo como "enviado" de forma optimista; el estado solo se actualiza cuando el Webhook Response de n8n retorna `{ success: true, sent_at: "..." }`.
3. **Disciplina de Commits Atómicos:**
   - Realiza un commit descriptivo tras completar cada feature funcional (ej. tras conectar Supabase o finalizar el composer).
   - Configura reglas en el agente para que solicite autorización antes de commitear grandes lotes de archivos.
   - Mantén un `README.md` operativo que detalle requisitos de instalación, variables de `.env.local` y mapeo de endpoints.

---

## 🎯 Ejercicio práctico

Implementar el compositor de correos en Antigravity y conectarlo a un flujo de despacho en n8n.

**Ejercicio 1:** Agrega en tu aplicación local la vista de cotizaciones con el compositor de correos en dos columnas. Configura en n8n un escenario con un nodo Webhook (POST) que reciba el JSON, un nodo Gmail que envíe el mensaje al destinatario y un nodo Webhook Response que devuelva `{ "success": true }`. Prueba el envío desde la interfaz y verifica que el estado de confirmación se guarde en Supabase y aparezca en el historial visual.

**Ejercicio 2 (avanzado, opcional):** Solicita a tu agente en Antigravity que inspeccione el proyecto y actualice el archivo `README.md` documentando las variables de entorno necesarias (`N8N_WEBHOOK_URL`, `SUPABASE_URL`) y los pasos exactos para levantar el flujo híbrido en local antes de ejecutar un `git commit`.

---

## 💡 Tip

No delegues la redacción ni la lógica de prompting a nodos de IA dentro de n8n si ya cuentas con modelos integrados en el frontend de Antigravity. Generar el asunto (*subject*) y el cuerpo (*body*) directamente en la interfaz permite al usuario revisar y editar el texto antes de enviarlo, reduciendo el webhook de n8n a un simple transportador de correo mucho más rápido, económico y confiable.

---

## ⚠️ Error común

Asumir que el servidor MCP de n8n puede crear flujos complejos y mapear credenciales de servicios externos (como OAuth de Gmail) de forma completamente autónoma desde el chat. El MCP es excelente para listar, activar o inspeccionar nodos, pero la asignación de credenciales sensibles y la conexión física de puertos debe verificarse o completarse manualmente en el lienzo de n8n.

---
