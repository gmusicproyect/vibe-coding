# Clase 26 — Cómo Proteger OpenClaw en un VPS con Tailscale

**Tags:** `OpenClaw` `VPS` `Tailscale` `Seguridad`
**Conecta con:** [Clase 14](clase-14-tu-agente-programa-solo-duermes.md) · [Clase 24](clase-24-claude-code-vs-openclaw-agentes.md) · [Clase 25](clase-25-antigravity-claude-code-openclaw.md)

---

## Idea central

Desplegar OpenClaw, Clawdbot o Moltbot en un VPS expone su panel de control en el puerto público 18789, dejándolo vulnerable a motores de indexación masiva como Shodan y ataques de fuerza bruta. La protección definitiva consiste en encapsular el servidor en una red privada virtual (VPN) mediante Tailscale y cerrar el tráfico entrante con UFW, manteniendo accesibles únicamente los puertos autorizados desde dispositivos verificados.

---

## 1. El Riesgo de Exposición Pública (Puerto 18789)

Cualquier instancia accesible vía `http://IP_PUBLICA:18789/` queda registrada en bases de datos de escaneo continuo:

- **Vector de ataque y huella Shodan:** Shodan y Censys indexan la cadena literal `"Clawbot control"`, permitiendo que atacantes ubiquen miles de servidores expuestos con un clic.
- **Falla de Reverse Proxy (Nginx/Caddy):** Si se utiliza Nginx o Caddy sin configurar `gateway.trustedProxies`, el panel trata a cualquier visitante externo como si proviniera de `localhost`, saltándose la autenticación y entregando acceso total a mensajes, historial y tokens.
- **Riesgo en Cadena de Suministro (MoltHub/ClaudeHub):** Repositorios públicos de skills sin auditar pueden alojar puertas traseras (*backdoors*) con descargas infladas artificialmente que roban credenciales al instalarse.
- **Mitigaciones básicas adicionales:** Cambiar el puerto por defecto 18789 por uno aleatorio no estándar (evita el primer barrido de escáneres como Shodan), establecer siempre una contraseña en el panel de control, y mantener Clawdbot/OpenClaw actualizado a la última versión disponible.
- **Principio de defensa y mitigación:** Usar VPN privada con Tailscale, auditar el código de cada skill con una sesión limpia de IA antes de ejecutarla, y rotar inmediatamente todas las API keys si la instancia estuvo expuesta públicamente. (Ver análisis detallado en la [transcripción traducida del video](../../recursos/transcripciones/vulnerabilidades-clawdbot-video.md)).

---

## 2. Red Privada con Tailscale y Reglas de Firewall UFW

Tailscale crea una malla VPN segura asignando direcciones privadas `100.x.x.x` a los dispositivos del usuario sin abrir puertos a la internet abierta:

| Parámetro | Instancia sin Protección | Instancia Blindada con Tailscale + UFW |
| :--- | :--- | :--- |
| **Visibilidad** | Indexable por motores de escaneo (Shodan / Censys) | Invisible al tráfico público de internet |
| **Autenticación** | Solo depende del token HTTP en la URL | Doble capa: pertenencia a red privada + token |
| **Punto de Entrada** | IP pública accesible por cualquier navegador | Exclusivo para dispositivos de la cuenta (`100.x.x.x`) |
| **Canales Externos** | Telegram / WhatsApp operativos | Telegram / WhatsApp operan igual (salida `outbound`) |

---

## 3. Protocolo de Blindaje del VPS Paso a Paso

El procedimiento puede delegarse al agente o ejecutarse manualmente desde la terminal SSH:

1. **Instalación de Tailscale en VPS y cliente:**
   ```bash
   curl -fsSL https://tailscale.com/install.sh | sh
   sudo tailscale up
   ```
   Autenticar con la misma cuenta en el servidor y en la computadora local, verificando el enlace con `tailscale status` y `tailscale ping <IP_TAILSCALE_VPS>`.
2. **Validar acceso privado:** Confirmar que el panel cargue en `http://<IP_TAILSCALE_VPS>:18789/?token=TU_TOKEN` antes de modificar el firewall.
3. **Cierre de puertos con UFW:**
   ```bash
   sudo ufw default deny incoming
   sudo ufw default allow outgoing
   sudo ufw allow 22/tcp
   sudo ufw allow from 100.64.0.0/10
   sudo ufw delete allow 18789
   sudo ufw --force enable
   ```
4. **Verificación externa:** Intentar cargar `http://IP_PUBLICA:18789/` desde un celular con datos móviles (fuera de la red Tailscale). Debe arrojar *timeout* o error de conexión.

---

## 🎯 Ejercicio práctico

Blindar un VPS activo que aloje OpenClaw o un servidor de pruebas aislando su puerto web detrás de Tailscale.

**Ejercicio 1:** Instala Tailscale tanto en tu servidor como en tu equipo local. Inicia sesión con el mismo proveedor de identidad, obtén la IP privada del VPS (`tailscale status`) y comprueba la visibilidad mutua mediante `tailscale ping`. Carga el panel administrativo usando la IP `100.x.x.x`.

**Ejercicio 2 (avanzado, opcional):** Aplica las reglas UFW descritas permitiendo el bloque `100.64.0.0/10` y el puerto SSH `22/tcp`. Comprueba con `sudo ufw status` que el puerto 18789 ya no acepte tráfico `Anywhere` y verifica que tu bot de mensajería (Telegram) continúe respondiendo normalmente sin interrupciones.

---

## 💡 Tip

Antes de ejecutar `sudo ufw --force enable`, confirma que la regla `sudo ufw allow 22/tcp` esté activa y que puedas responder al ping de Tailscale. Si alguna vez necesitas abrir el panel temporalmente para emergencias sin Tailscale, basta con ejecutar `sudo ufw allow 18789` y revocarlo luego con `sudo ufw delete allow 18789`.

---

## ⚠️ Error común

Activar el firewall (`ufw enable`) o eliminar el acceso al puerto sin haber configurado explícitamente `allow 22/tcp` y sin validar primero la conexión activa en Tailscale. Esto corta la sesión SSH actual y bloquea de inmediato al administrador fuera del VPS, obligando a usar la consola de rescate VNC del proveedor de hosting para recuperar el servidor.
