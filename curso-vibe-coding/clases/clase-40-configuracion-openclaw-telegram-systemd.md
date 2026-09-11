# Clase 40 — Configuración de OpenClaw: Modelo, Telegram, Skills y Servicio Persistente

**Tags:** `OpenClaw` `Telegram` `Systemd` `API Keys`
**Conecta con:** [Clase 26](clase-26-proteger-openclaw-vps-tailscale.md) · [Clase 38](clase-38-que-es-openclaw-autonomia-memoria-riesgos.md) · [Clase 39](clase-39-instalacion-openclaw-vps-seguridad.md)

---

## Idea central

Completar el Quick Start de OpenClaw exige aislar los costos desde el inicio (API Key dedicada en vez de la sesión del plan personal), conectar un canal de comunicación real vía Telegram con BotFather, instalar solo los skills estrictamente necesarios, y — el paso que la mayoría de tutoriales omite — convertir el gateway en un servicio de `systemd` para que el agente siga vivo aunque se cierre la terminal o la sesión SSH.

---

## 1. Selección de Modelo y Aislamiento de Costos

OpenClaw soporta múltiples proveedores (Anthropic, Gemini, OpenRouter, Minimax, Moonshot/Kimi, GLM, Copilot, entre otros). El curso recomienda **Anthropic + Opus 4.5** por calidad de razonamiento y estabilidad para agentes.

- **Regla de oro:** nunca conectes tu sesión personal de Claude (plan Max/Pro). Usa una **API Key dedicada** exclusivamente para OpenClaw.
- **Por qué:** si el agente entra en un bucle o comete un error, solo se consume el saldo de esa key aislada — no tu cuota de suscripción usada para otras herramientas (ej. Antigravity).
- **Recomendación práctica:** cargar entre $5 y $10 USD como presupuesto inicial de prueba.

---

## 2. Conexión con Telegram vía BotFather

Entre los canales disponibles (Telegram, WhatsApp por QR, Slack, Discord), el curso elige Telegram por su estabilidad, facilidad de configuración y buena app de escritorio.

1. En Telegram, buscar **@BotFather** y ejecutar `/newbot`.
2. Asignar un nombre visible (ej. "OpenClaw") y un *username* único que **debe terminar en `bot`** (ej. `openclaw_amigo_bot`).
3. Copiar el token que entrega BotFather y pegarlo en el asistente de OpenClaw cuando lo solicite.

---

## 3. Selección Cuidadosa de Skills e Integraciones

Regla clave: **no instales todo lo disponible**, solo lo que vayas a usar de inmediato — cada skill de terceros puede ejecutar código y representa una superficie de riesgo adicional (ver [Clase 39](clase-39-instalacion-openclaw-vps-seguridad.md)).

| Integración | Estado en esta clase | Requiere |
| :--- | :--- | :--- |
| **ClawHub CLI** | Activada | Acceso a la comunidad de skills (leer antes de instalar de terceros) |
| **Gemini CLI + Nano Banana Pro** | Activada | `GEMINI_API_KEY` (proyecto dedicado en Google Cloud) |
| **OpenAI Whisper** | Activada | `OPENAI_API_KEY` (permite transcribir audios de Telegram) |
| **1Password, Notion, Twitter/X, bases de datos externas** | Pospuestas | Se agregan más adelante solo cuando haya un caso de uso concreto |

---

## 4. Gateway, Túnel de Acceso y Persistencia con Systemd

El dashboard de OpenClaw corre en `localhost` dentro del VPS, por lo que se necesita un túnel para verlo desde tu computadora:

```bash
openclaw gateway --port 18789 --verbose
```

> **Cuidado con el nombre del binario:** por el historial de renombres (Clawdbot → Moltbot → OpenClaw), comandos y tutoriales antiguos usan `cloudbot`; en la versión actual el binario y el servicio se llaman `openclaw`.

Para que el gateway sobreviva al cierre de la terminal o la sesión SSH, se configura como servicio de `systemd` (como el usuario `openclaw`, nunca como `root`):

```bash
sudo nano /etc/systemd/system/openclaw-gateway.service
```

```ini
[Unit]
Description=Openclaw Gateway (always-on)
After=network-online.target
Wants=network-online.target

[Service]
User=openclaw
WorkingDirectory=/home/openclaw
ExecStart=/home/openclaw/.npm-global/bin/openclaw gateway --bind loopback --port 18789 --verbose
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable openclaw-gateway
sudo systemctl start openclaw-gateway
sudo systemctl status openclaw-gateway
```

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Completa el Quick Start de tu OpenClaw usando una API Key dedicada de Anthropic (no tu sesión personal), conecta Telegram mediante BotFather, y activa únicamente Gemini CLI y OpenAI Whisper como skills iniciales. Envía un mensaje de texto y luego una nota de voz por Telegram y confirma que el agente transcribe y responde correctamente.

**Ejercicio 2 (avanzado, opcional):** Crea el archivo de servicio `openclaw-gateway.service`, habilítalo con `systemctl enable` y ciérralo todo (terminal y sesión SSH). Reconéctate minutos después y confirma con `systemctl status openclaw-gateway` y un mensaje de prueba en Telegram que el agente sigue respondiendo sin que tuvieras que volver a ejecutar el comando del gateway manualmente.

---

## 💡 Tip

Antes de copiar cualquier comando de un tutorial o post viejo sobre esta herramienta, verifica el nombre del binario y del servicio. Por los renombres sucesivos (Clawdbot, Moltbot, OpenClaw), un comando con `cloudbot` o `moltbot` fallará silenciosamente con "command not found" en una instalación actual — siempre usa `openclaw`.

---

## ⚠️ Error común

Dejar el gateway corriendo únicamente en primer plano dentro de la terminal SSH, sin configurarlo como servicio de `systemd`. En cuanto se cierra la terminal, se pierde la conexión SSH o el VPS reinicia, el agente deja de responder en Telegram sin ningún aviso — y hay que reconectarse manualmente para volver a ejecutar el comando del gateway cada vez.
