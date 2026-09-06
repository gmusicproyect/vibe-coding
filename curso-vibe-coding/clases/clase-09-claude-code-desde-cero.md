# Clase 09 — Claude Code desde Cero: Skills, MCPs y seguridad

**Tags:** `Fundamentos` `Contexto` `MCPs` `Seguridad OWASP`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 02](clase-02-tunear-claude-code.md) · [Clase 04](clase-04-adversarial-review.md) · [Clase 08](clase-08-ux-seguridad.md)

---

## Idea central

Claude Code opera como un arnés agéntico cuyo rendimiento depende de la higiene estricta del contexto y de límites de seguridad deterministas. Para evitar alucinaciones y degradación tras superar el 20% de la ventana de contexto o acumular 20-30 peticiones, es crítico aislar subagentes mediante `context: fork`, transferir estados entre sesiones mediante documentos `handoff.md`, desconectar MCPs innecesarios y aplicar los principios de seguridad de OWASP (Row Level Security en base de datos, protección de secretos en `.env` y webhooks firmados) antes de cualquier despliegue a producción.

---

## Comparativa de entornos: CLI vs. VS Code vs. Desktop

| Entorno | Interfaz y control | Ventaja principal | Limitación clave |
|---------|--------------------|-------------------|------------------|
| **Claude CLI** | Terminal pura | Soporte para comandos exclusivos (`/insights`, `/plan`) y bajo consumo de recursos. | Sin explorador visual de archivos interactivo. |
| **VS Code / IDEs** | Explorador lateral + Terminal | Vista del árbol de archivos en tiempo real y edición simultánea con extensiones. | Requiere gestionar extensiones y terminales paralelas. |
| **Claude Desktop** | App de escritorio | Previsualizador integrado y vista previa de artefactos en pantalla. | Sin explorador de sistema de archivos (`file system`) nativo. |
| **Cursor** | Editor con IA integrada | Modelos alternativos (Composer) y reglas `.cursorrules`. | Consume tokens fuera del arnés unificado de Anthropic. |

---

## Skill vs. MCP: la diferencia que confunde a casi todos

| | Skill | MCP |
|--|-------|-----|
| **Qué es** | Instrucciones procedurales — cómo pensar/actuar ante una tarea | Servidor que expone herramientas para conectarte a un servicio externo |
| **Costo** | Se carga bajo demanda, según el tamaño del archivo | Cada *tool call* consume tokens y agrega latencia de conexión |
| **Cuándo crear uno** | Repetiste la misma instrucción más de 2 veces | Necesitas que el agente lea/escriba en un servicio externo (Figma, GHL, etc.) |

Claude Code trae embebido el **Skill Creator**: pídele "usa el skill creator y créame un skill para [tarea]" y te genera la carpeta con `SKILL.md` completo, sin que tengas que escribirlo desde cero.

**Alcance de instalación:** los skills y MCPs a nivel de usuario (`~/.claude/`) están disponibles en cualquier proyecto; los de nivel proyecto solo en esa carpeta. No cargues 500 skills a nivel usuario "por si acaso" — cada uno se lee en cada sesión aunque no lo uses, y satura el contexto desde el primer mensaje.

---

## Higiene de contexto: MCPs, Prompt Caching y subagentes con Fork

Mantener limpia la ventana de contexto es indispensable para evitar que el modelo compacte memoria y empiece a alucinar:

1. **Prompt Caching de Anthropic (Ventana de 5 minutos):** El primer mensaje carga el 100% del contexto. Si respondes en menos de 5 minutos, los mensajes siguientes aprovechan el caché pagando solo ~10% del costo para el 90% del contexto inmutable (`CLAUDE.md`, MCPs y herramientas).
2. **Auditoría con `/context`:** Conectar múltiples MCPs a nivel de usuario puede consumir más del 25% de la ventana antes de enviar el primer prompt. Ejecuta `/context` y deshabilita las herramientas que no se utilicen en la fase actual.
3. **Aislamiento con `context: fork`:** Al definir subagentes, activa la opción `fork` para que el razonamiento y la investigación queden contenidos en su proceso hijo, devolviendo únicamente el resultado consolidado al agente orquestador principal.
4. **Auto-análisis con `/insights`:** Ejecuta `/insights` para escanear el historial local (`.jsonl`) de tus sesiones. Te entregará métricas de tiempo de respuesta, herramientas más utilizadas y sugerencias automáticas de reglas para tu `CLAUDE.md`.

---

## Metodología SDD, priorización MoSCoW y protocolo Handoff

Para proyectos complejos o modulares, Carlos recomienda separar la arquitectura del código mediante documentos de control:

- **Spec-Driven Development (SDD):** Dedica un 80% a la planeación (definir `blueprint.md`, historias de usuario y métricas de éxito) y un 20% a la orquestación. Si surge un nuevo requerimiento (ej. agregar facturación a mitad de camino), actualiza el spec antes de tocar el código.
- **Priorización MoSCoW:** Clasifica los requisitos en *Must have* (indispensable), *Should have* (esperable), *Could have* (deseable) y *Won't have* (descartado para esta fase) para no dilatar el desarrollo.
- **Protocolo de Handoff entre sesiones:** Cuando el contexto supere el 20-50% o al concluir una feature, pide a Claude:
  ```text
  Genera un handoff.md resumiendo lo implementado, decisiones arquitectónicas, bloqueadores y los siguientes 3 pasos exactos.
  ```
  Abre una nueva sesión limpia y retoma con: `"Lee handoff.md y dime dónde continuar"`.

---

## Seguridad en Vibe Coding: Reglas duras pre-deploy (OWASP)

Antes de desplegar cualquier aplicación a Vercel, Railway o VPS, valida los 5 pilares de seguridad:

1. **Row Level Security (RLS) en Supabase:** Debe estar activo en cada tabla con políticas estrictas para que el `user_id` solo consulte y modifique sus propios registros, evitando robo de datos mediante enumeración de IDs.
2. **Secretos fuera del frontend:** Nunca almacenes API keys o tokens en variables públicas de cliente ni en el chat de Claude. Guárdalos en el archivo `.env` local e inyéctalos en las variables de entorno del servidor.
3. **Webhooks firmados (Handshake criptográfico):** Toda llamada entrante de servicios externos (ej. WhatsApp, Stripe) debe validar una firma secreta compartida antes de procesar la carga útil.
4. **Rate Limiting:** Implementa límites de peticiones por IP o usuario en endpoints que consuman LLMs o bases de datos para evitar ataques de denegación de servicio o vaciado de saldo.
5. **Autenticación en capas:** En plataformas sensibles, complementa usuario y contraseña con un código OTP temporal enviado por correo (con expiración de 10 minutos).

---

## 🎯 Ejercicio práctico

**Ejercicio 1 (Auditoría de contexto e Insights):**
1. Abre tu proyecto en Claude Code y ejecuta el comando `/context` para verificar qué porcentaje consumen tus MCPs y archivos base.
2. Deshabilita los MCPs que no vayas a utilizar en esta sesión y ejecuta `/insights` para obtener el reporte de rendimiento de tus sesiones previas.
3. Incorpora una de las recomendaciones sugeridas por el reporte directamente en tu archivo `CLAUDE.md`.

**Ejercicio 2 (Generación y prueba de Handoff):**
Al concluir la implementación de una funcionalidad, pide a Claude Code que redacte un `handoff.md`. Abre una nueva pestaña o sesión limpia, indícale que lea el archivo y confirma que pueda retomar la tarea sin necesidad de releer el historial previo.

---

## 💡 Tip

Responde a Claude Code dentro de los primeros 5 minutos tras su respuesta para mantener caliente el caché de Anthropic; ahorrarás hasta un 90% en tokens de contexto fijo frente a respuestas demoradas.

---

## ⚠️ Error común

Mantener todo el ciclo de desarrollo de una aplicación dentro de una misma sesión de chat. Al superar el 20% de la ventana o acumular más de 20 mensajes, el modelo compacta el historial, olvida especificaciones previas y comienza a modificar o eliminar código sin avisar.
