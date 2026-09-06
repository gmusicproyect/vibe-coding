# Clase 05 — El agente nativo de GHL no basta

**Tags:** `GoHighLevel` `CRM` `MCP` `Automatización`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 04](clase-04-adversarial-review.md) · [Clase 06](clase-06-ley-de-datos.md)

---

## Idea central

GoHighLevel (GHL) centraliza canales de venta, automatizaciones y embudos bajo una arquitectura de agencia multicuenta, pero saturar al cliente o confiar en sus agentes conversacionales nativos degrada la operación. El flujo óptimo de Vibe Coding combina el CRM como capa de persistencia y ejecución de eventos con la inteligencia orquestada por fuera: agentes autónomos conectados mediante MCP o webhooks que leen y actualizan el estado comercial sin sufrir las limitaciones de la plataforma.

---

## Arquitectura de cuentas, tiers y Snapshots

| Nivel de cuenta | Costo ref. | Subcuentas | Capacidades clave y uso |
|-----------------|------------|------------|-------------------------|
| **Starter** | \$97 / mes | Hasta 3 | Pruebas iniciales y operación de 1 negocio propio. |
| **Pro / Agency** | \$297 / mes | Ilimitadas | Marca blanca básica; gestión de clientes en subcuentas separadas. |
| **SaaS Pro** | \$497 / mes | Ilimitadas | Marca blanca total (CSS/JS), API full y re-billing automático de consumos. |

- **Snapshots (`Instantáneas de cuenta`):** Desde la vista de Agencia → `Account Snapshots` → `Crear nuevo snapshot`, se empaqueta toda la estructura de una subcuenta (embudos, workflows, calendarios, campos personalizados y tags). Permite desplegar un nuevo cliente en segundos o vender plantillas empaquetadas.
- **Protección financiera (Re-billing):** Para evitar que la agencia absorba costos variables de telefonía LC, WhatsApp o triggers premium, se activa el enlace de facturación (`re-billing`) al crear la subcuenta para que cada cliente registre su propia tarjeta en Stripe.

---

## Rutas exactas de configuración en pantalla

1. **Rastreo de píxel y CAPI en embudos:**
   - Ve a `Sitios` → selecciona el embudo → `Configuración`.
   - Pega el código en `Código de seguimiento de encabezado` o `del cuerpo`. Los formularios integrados disparan automáticamente los eventos de *Page View* y *Submit*.
2. **Aislamiento de reputación en Email:**
   - Ve a `Configuración` → `Servicios de correo electrónico` → `Añadir dominio`.
   - Agrega siempre un subdominio dedicado (ej. `contacto@lc.midominio.com`) con registros SPF, DKIM y DMARC verificados para que los envíos masivos no quemen tu dominio principal.
3. **Traducción de recordatorios de calendario:**
   - Ve a `Calendarios` → icono de tres puntos → `Configuración avanzada` → `Notificaciones`.
   - Edita la plantilla de confirmación (por defecto en inglés) para traducirla al español, o desactívala y orquesta confirmaciones personalizadas vía `Workflows`.

---

## Conexión agéntica: MCP, Webhooks y límites nativos

- **Actualización multicuenta MCP:** El servidor oficial MCP de GHL permite gobernar múltiples subcuentas desde una única sesión de Claude Code sin alternar tokens privados de integración a mano.
- **Extracción de datos sin bloqueo:** La interfaz web solo exporta contactos en CSV (omite historial de chat). A través de la API/SDK o el conector MCP en Claude Code se extraen historiales completos de conversación y llamadas.
- **La regla de IA externa:** El módulo nativo `Conversation AI` alucina al consultar catálogos dinámicos o disponibilidades complejas (tool calling). La arquitectura robusta procesa el razonamiento en un backend agéntico externo (N8N, Python o Claude) y envía el resultado final a GHL vía webhook (`Disparador de Webhook entrante`) para agendar citas, etiquetar y actualizar campos.

---

## 🎯 Ejercicio práctico

**Ejercicio 1 (Configuración y Webhook entrante):**
1. En tu subcuenta de GHL, entra a `Automatizaciones` → `Crear workflow` → selecciona disparador `Webhook entrante` (`Inbound Webhook`).
2. Copia la URL del webhook que genera GHL.
3. Desde tu terminal o cliente HTTP, dispara un POST simulando la captura de un lead por un agente externo:
   ```bash
   curl -X POST "URL_DE_TU_WEBHOOK" -H "Content-Type: application/json" -d '{"nombre": "Cliente Demo", "email": "demo@correo.com", "telefono": "+56912345678", "interes": "Auditoría Agéntica"}'
   ```
4. En GHL, haz clic en `Recuperar solicitud` para mapear los campos JSON a los campos nativos del contacto y añade la acción `Crear/Actualizar contacto`.

**Ejercicio 2 (avanzado):** Conecta tu sesión de Claude Code al servidor MCP de GoHighLevel. Pídele al agente que consulte la lista de contactos creados en la última hora y aplique automáticamente el tag `Lead Calificado` a quienes tengan teléfono registrado.

*Por qué importa este ejercicio y no usar el `Conversation AI` nativo para lo mismo: el módulo nativo razona con tool calling directo sobre GHL y alucina fácil ante lógica condicional (ej. "solo etiqueta si tiene teléfono Y no ha comprado antes"). Al procesar esa lógica en Claude Code y solo enviar el resultado final por webhook/MCP, el razonamiento complejo queda fuera del módulo que falla.*

---

## 💡 Tip

Si tu cliente ya tiene su web en WordPress, no reconstruyas sus páginas con el maquetador de GoHighLevel. Mantén WordPress para el SEO y diseño, e inserta simplemente el iframe embebido del calendario o formulario de GHL (o dispara un webhook desde Gravity Forms al recibir el envío).

---

## ⚠️ Error común

Almacenar historiales clínicos o datos altamente sensibles en campos personalizados de GoHighLevel sin contratar el add-on de cumplimiento HIPAA (\$97-\$297/mes) ni firmar el BAA. El CRM debe limitarse al seguimiento comercial; los datos sensibles de operación deben residir en bases de datos externas protegidas.
