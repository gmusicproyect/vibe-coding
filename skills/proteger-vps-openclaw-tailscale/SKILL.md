# SKILL: Proteger Instancias de OpenClaw en VPS con Tailscale y Firewall UFW

> Guarda este archivo en `/skills/proteger-vps-openclaw-tailscale/SKILL.md`
> Referencia en tu CLAUDE.md: `- /skills/proteger-vps-openclaw-tailscale/SKILL.md → para blindar paneles de control de OpenClaw/Clawdbot (puerto 18789) en VPS mediante VPN privada Tailscale y reglas de firewall UFW`

---

## Cuándo usar este skill

Cuando el desarrollador o administrador requiera:
1. Aislar de internet abierta el panel de control de un agente autónomo (OpenClaw, Clawdbot, Moltbot) que corre en el puerto 18789 de un VPS público.
2. Evitar la indexación y ataques de fuerza bruta de motores automatizados (Shodan, Censys).
3. Establecer un túnel VPN punto a punto sin abrir puertos de entrada en el router o proveedor de hosting.
4. Mantener operativas las integraciones salientes (Telegram, WhatsApp, webhooks salientes) garantizando que solo los dispositivos del administrador puedan acceder al panel administrativo.

Basado en las directrices de la **Clase 26 — Cómo Proteger OpenClaw en un VPS con Tailscale**.

---

## Prerequisitos

- [ ] Servidor VPS con Linux (Ubuntu/Debian) y acceso `sudo`.
- [ ] Conexión SSH activa y estable en puerto 22.
- [ ] Cuenta gratuita en Tailscale (soporta login con Google, GitHub, Microsoft).
- [ ] Computadora local o celular para enlazar la red privada.

---

## Pasos de Hardening y Conexión

### Paso 1 — Instalación de Tailscale en el VPS
Conectarse vía SSH (o terminal remota en Antigravity) al servidor:
```bash
# Descargar e instalar el binario oficial
curl -fsSL https://tailscale.com/install.sh | sh

# Iniciar el servicio y generar el enlace de autenticación
sudo tailscale up
```
Copiar el enlace arrojado por la terminal (`https://login.tailscale.com/a/xxxxx`), abrirlo en el navegador e iniciar sesión. Verificar el registro:
```bash
tailscale status
# Salida esperada: 100.x.x.x tu-servidor linux -
```
Anotar la IP privada `100.x.x.x` asignada al VPS.

---

### Paso 2 — Conectar el Cliente Local (Mac / Windows / Linux)
Instalar el cliente de Tailscale en el equipo local:
- **macOS (Homebrew):** `brew install tailscale && brew services start tailscale && tailscale up`
- **Linux:** `curl -fsSL https://tailscale.com/install.sh | sh && sudo tailscale up`
- **Windows / macOS (Instalador GUI):** Descargar desde el sitio oficial de Tailscale y abrir sesión con la **misma cuenta** usada en el VPS.

Validar conectividad bidireccional desde la máquina local:
```bash
tailscale ping <IP_TAILSCALE_VPS>
```

---

### Paso 3 — Validar Acceso Privado al Panel
Antes de cerrar puertos en el firewall, confirmar que el control panel responde a través de la red privada:
```text
http://<IP_TAILSCALE_VPS>:18789/?token=TU_TOKEN
```
Si el panel carga adecuadamente bajo la IP `100.x.x.x`, proceder al cierre perimetral.

---

### Paso 4 — Configuración Estricta de Firewall (UFW)
En la consola del VPS, ejecutar en secuencia:

```bash
# 1. Definir políticas base
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 2. Mantener SSH abierto (crítico para no perder acceso administrativo)
sudo ufw allow 22/tcp

# 3. Permitir tráfico completo exclusivo desde la subred de Tailscale
sudo ufw allow from 100.64.0.0/10

# 4. Eliminar exposición pública del puerto 18789 si existía previamente
sudo ufw delete allow 18789

# 5. Habilitar firewall
sudo ufw --force enable

# 6. Auditar estado
sudo ufw status
```

**Verificación:** La salida debe mostrar `22/tcp ALLOW Anywhere` y `Anywhere ALLOW 100.64.0.0/10`. El puerto `18789` **no** debe aparecer expuesto a `Anywhere`.

---

### Paso 5 — Prueba Externa de Seguridad (Cero Fugas)
Desde un dispositivo desconectado de Tailscale (ej. celular usando datos móviles directos sin VPN):
1. Navegar a `http://<IP_PUBLICA_VPS>:18789/`.
2. **Resultado obligatorio:** La conexión debe fallar por tiempo de espera (*timeout*) o rechazo inmediato.

---

## Automatización con Agente (Prompt de Delegación)

Si tu agente en VPS (OpenClaw / Claude Code CLI) dispone de permisos de terminal, puedes pasarle este bloque de instrucciones:

```text
Necesito que asegures este servidor con Tailscale para que el control panel no quede expuesto a internet.
Sigue estos pasos con estricto cuidado:
1. Instala Tailscale: curl -fsSL https://tailscale.com/install.sh | sh
2. Ejecuta: sudo tailscale up y proporcióname el enlace de autenticación.
3. Espera a que yo autentique y te confirme que tengo Tailscale corriendo en mi máquina local.
4. Cuando te confirme acceso vía IP 100.x.x.x, configura UFW:
   - sudo ufw default deny incoming
   - sudo ufw default allow outgoing
   - sudo ufw allow 22/tcp (obligatorio)
   - sudo ufw allow from 100.64.0.0/10
   - sudo ufw delete allow 18789
   - sudo ufw --force enable
5. NO cierres el puerto 18789 hasta que yo confirme que puedo navegar vía Tailscale.
```

---

## Procedimiento de Rescate ante Contingencias

1. **Pérdida de enlace en el panel:** Acceder por SSH directo al puerto 22 (`ssh usuario@IP_PUBLICA`) ya que quedó explícitamente habilitado.
2. **Apertura de emergencia temporal:** Ejecutar `sudo ufw allow 18789` para recuperar acceso HTTP sin VPN, y volver a cerrarlo con `sudo ufw delete allow 18789`.
3. **Servicio Tailscale caído:** Verificar estado en el host con `sudo systemctl status tailscaled` o reiniciar el daemon con `sudo systemctl restart tailscaled`.
