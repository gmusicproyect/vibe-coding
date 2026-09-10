# Clase 38 — Qué es OpenClaw (ex Clawdbot / Moltbot): Autonomía, Memoria y Riesgos

**Tags:** `OpenClaw` `Agentes Autónomos` `Memoria Persistente` `VPS`
**Conecta con:** [Clase 17](clase-17-hermes-vs-openclaw-skills.md) · [Clase 24](clase-24-claude-code-vs-openclaw-agentes.md) · [Clase 26](clase-26-proteger-openclaw-vps-tailscale.md)

---

## Idea central

OpenClaw (anteriormente conocido como Clawdbot y Moltbot) es un agente de IA de código abierto alojado localmente o en un VPS que interactúa mediante aplicaciones de mensajería (Telegram, WhatsApp o Discord). A diferencia de los modelos conversacionales tradicionales que se limitan a rechazar tareas complejas, OpenClaw genera sus propias herramientas de forma autónoma instalando librerías, controlando navegadores y orquestando APIs, apalancándose en una memoria persistente que le permite anticiparse a las necesidades del usuario de forma proactiva.

---

## 1. Identidad de OpenClaw: Qué ES y qué NO ES

El entusiasmo masivo en torno a la herramienta exige delimitar su naturaleza arquitectónica frente a otros productos del ecosistema:

- **Lo que NO es:** No es un sitio web SaaS, no es Claude Code, no es una aplicación con suscripción en la nube ni es un software desarrollado o respaldado por Anthropic (su cambio de nombre de Clawdbot a Moltbot y posteriormente a OpenClaw respondió a requerimientos de marca).
- **Lo que SÍ es:** Una aplicación *open source* creada por un desarrollador independiente que vive en un computador personal o servidor remoto, conectada a los canales cotidianos del usuario.
- **Canal Ubicuo de Comunicación:** Al vincularse con bots de mensajería (Telegram, WhatsApp, Slack o Discord), el usuario imparte instrucciones desde su teléfono móvil en la calle y el agente las ejecuta directamente sobre el sistema operativo anfitrión.

---

## 2. Los Dos Pilares Diferenciadores: Auto-Extensión y Memoria Proactiva

OpenClaw supera las restricciones de los chatbots convencionales mediante dos capacidades estructurales:

| Dimensión | Chatbot Tradicional (ChatGPT / Claude Web) | OpenClaw (Agente Autónomo) |
| :--- | :--- | :--- |
| **Capacidad de Acción** | Responde *"No puedo hacer eso"* ante tareas sin herramientas predefinidas. | **Crea sus propios brazos:** instala Whisper si requiere transcribir audios, descarga `yt-dlp` o toma control del navegador para autenticar servicios. |
| **Arquitectura de Memoria** | Memoria volátil o aislada por hilos de conversación. | **Memory First:** aprendizaje persistente continuo; analiza el contexto y gustos del usuario a lo largo de semanas. |
| **Comportamiento** | Reactivo: opera únicamente cuando el usuario envía un mensaje explícito. | **Proactivo:** reconoce patrones, rastrea tendencias (ej. en X/Twitter) y propone iniciativas o revisa tareas pendientes cada 30 minutos sin solicitud previa. |

- **Casos de Uso Reales:** Desde negociar compras de vehículos comparando precios en Reddit y agendar 27 demos en una hora, hasta conectarse a n8n para editar flujos por chat o auditar pendientes cada 30 minutos de forma desatendida.

---

## 3. Riesgos Operativos y Recomendación de Blindaje en VPS

Otorgar acceso agéntico a nivel de sistema operativo introduce vectores de riesgo críticos que deben mitigarse desde el despliegue inicial:

1. **Acceso Irrestricto al Sistema:** El agente dispone de permisos para leer, modificar y borrar archivos locales; un error de alucinación puede provocar pérdida de datos o envíos accidentales a contactos indebidos.
2. **Puertos Expuestos y Superficie de Ataque:** Como software emergente, abrir puertos directos en redes públicas expone el servidor a escaneos automáticos de Shodan (ver mitigación con Tailscale en [Clase 26](clase-26-proteger-openclaw-vps-tailscale.md)).
3. **Consumo Descontrolado de Tokens:** Tareas mal acotadas pueden atrapar al modelo en bucles infinitos de ejecución, acumulando consumos excesivos de API en pocas horas.
4. **Regla de Oro de Seguridad:** **Nunca instales OpenClaw en tu máquina personal principal** donde residan credenciales maestras o archivos sensibles. Despliégalo en un servidor virtual dedicado (VPS) o hardware secundario aislado, manteniéndolo operativo 24/7 en la nube bajo reglas estrictas de firewall.

---

## 🎯 Ejercicio práctico

Evaluar la conveniencia arquitectónica de un agente autónomo 24/7 y aislar su entorno de pruebas.

**Ejercicio 1:** Diseña un inventario de tareas recurrentes (ej. monitoreo de noticias, depuración de listas de correos o generación de borradores) y clasifica cuáles se benefician de la proactividad de OpenClaw y cuáles deben resolverse con un asistente de código puntual como Claude Code. Define un presupuesto máximo diario con límites de gasto (*spending limits*) en tu proveedor de LLM (OpenRouter u OpenAI) para proteger tu billetera de loops desatendidos.

**Ejercicio 2 (avanzado, opcional):** Configura una instancia básica de VPS en un proveedor cloud (Hetzner, DigitalOcean o similar) con un usuario sin privilegios de root (`openclaw`) para dejar el entorno listo antes de iniciar la instalación de la plataforma.

---

## 💡 Tip

Para prevenir cargos sorpresa en tus facturas de API cuando OpenClaw intente solucionar errores de forma iterativa, configura siempre umbrales duros de corte (*hard spending limits*) en la plataforma donde generas tus API keys (como OpenRouter o la consola de Anthropic). Si el agente entra en un bucle intentando instalar una dependencia fallida, el corte financiero automático detendrá el proceso antes de agotar tus fondos.

---

## ⚠️ Error común

Instalar OpenClaw directamente en tu laptop personal de trabajo del día a día atraído por la comodidad de no contratar un VPS. Además de obligarte a mantener el computador encendido las 24 horas para que el agente responda desde el celular, le otorgas acceso irrestricto de lectura y escritura a tus fotos, documentos privados y sesiones abiertas de navegador.

---
