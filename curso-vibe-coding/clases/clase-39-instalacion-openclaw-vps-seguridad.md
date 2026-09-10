# Clase 39 — Instalación de OpenClaw en un VPS Limpio: Seguridad, Usuario Aislado y Quickstart

**Tags:** `OpenClaw` `VPS` `Hostinger` `Linux Security`
**Conecta con:** [Clase 24](clase-24-claude-code-vs-openclaw-agentes.md) · [Clase 26](clase-26-proteger-openclaw-vps-tailscale.md) · [Clase 38](clase-38-que-es-openclaw-autonomia-memoria-riesgos.md)

---

## Idea central

El despliegue profesional de OpenClaw (anteriormente Clawdbot y Moltbot) exige rechazar imágenes preconfiguradas del hosting para aprovisionar un VPS limpio bajo Ubuntu LTS desde la consola de comandos. El principio fundamental de seguridad radica en crear un usuario de sistema dedicado sin privilegios de root para confinar la ejecución del agente, garantizando que la instalación oficial mediante script mantenga el acceso del modelo aislado del sistema operativo anfitrión.

---

## 1. Aprovisionamiento del VPS en Hostinger

Para garantizar estabilidad a largo plazo y evitar fricciones de compatibilidad:

- **Selección de Plan:** Se recomienda el plan **KVM2** (o superior), el cual provee recursos de cómputo y RAM suficientes para orquestar agentes y herramientas locales.
- **Ubicación Física:** Elegir el centro de datos geográficamente más próximo para reducir latencia de red en las peticiones.
- **Sistema Operativo:** Seleccionar **Ubuntu 24.04 LTS**. Siempre se debe optar por versiones LTS (*Long Term Support*) por su madurez y estabilidad en dependencias.
- **Alineación de Instalación:** Aunque el panel ofrezca plantillas con aplicaciones preinstaladas de OpenClaw, se debe seleccionar una imagen limpia de Ubuntu estándar para mantener control absoluto sobre los paquetes y puertos.
- **Contraseña Maestra:** Generar una clave robusta para `root` mediante un gestor de contraseñas y guardarla antes de finalizar la configuración inicial.

---

## 2. Acceso Remoto por SSH y Paréntesis Crítico de Seguridad

Al conectarse al servidor recién aprovisionado por primera vez:

1. **Acceso Inicial como Root:**
   ```bash
   ssh root@TU_IP_DEL_SERVIDOR
   ```
   Aceptar el fingerprint escribiendo `yes` e ingresar la contraseña de root (el texto permanece oculto en la consola por diseño).
2. **Prohibición de Ejecutar Agentes como Root:**
   - **Regla Estricta:** Jamás instales ni ejecutes OpenClaw bajo el usuario `root`.
   - **Riesgo Operativo:** Dado que OpenClaw tiene la capacidad de autoinstalar librerías y modificar scripts, ejecutarlo como superusuario expone todo el servidor ante una alucinación o código malicioso.

---

## 3. Creación del Usuario Aislado e Instalación Oficial

El aislamiento de privilegios se consolida creando un usuario de sistema exclusivo antes de descargar dependencias:

| Paso Operativo | Comando de Consola | Propósito Técnico |
| :--- | :--- | :--- |
| **1. Crear Usuario** | `adduser openclaw` | Crea el usuario aislado y su directorio `/home/openclaw`. Asignar contraseña distinta a root. |
| **2. Conceder Sudo** | `usermod -aG sudo openclaw` | Permite administrar paquetes del sistema sin operar como superusuario continuo. |
| **3. Cambiar de Sesión** | `su - openclaw` | Conmuta la sesión de terminal a `openclaw@servidor:~$`. |
| **4. Script Oficial** | `curl -fsSL https://clawd.bot/install.sh \| bash` | Descarga e instala OpenClaw de forma oficial dentro del espacio del usuario. |

Durante el asistente de inicialización:
- Leer conscientemente las advertencias sobre software en fase beta y riesgos de seguridad.
- Seleccionar la modalidad **Quick Start** para completar el onboarding base de la herramienta.

---

## 🎯 Ejercicio práctico

Aprovisionar un servidor Linux en la nube y configurar el entorno de ejecución confinado para OpenClaw.

**Ejercicio 1:** Conéctate vía SSH a un VPS limpio con Ubuntu 24.04 LTS como `root`. Crea el usuario dedicado `openclaw` con una contraseña independiente, otórgale permisos en el grupo sudo con `usermod -aG sudo openclaw` y cambia a su sesión con `su - openclaw`. Ejecuta el script oficial de instalación y completa el setup inicial seleccionando la opción *Quick Start*.

**Ejercicio 2 (avanzado, opcional):** Configura una alerta de consumo en la API de tu modelo preferido (Anthropic o proveedor compatible) y verifica que el comando `whoami` dentro de la sesión donde corre OpenClaw devuelva estrictamente `openclaw` y nunca `root`.

---

## 💡 Tip

Al ingresar contraseñas en terminales Linux por SSH (tanto para `root` como para el nuevo usuario `openclaw`), el cursor no se moverá ni mostrará asteriscos. Es el comportamiento estándar del sistema por protección visual; simplemente pega la clave con un clic derecho o atajo de terminal y presiona `Enter` con seguridad.

---

## ⚠️ Error común

Ejecutar el comando `curl -fsSL https://clawd.bot/install.sh | bash` inmediatamente después de acceder por SSH como `root`. Instalar OpenClaw en el usuario root le entrega las llaves maestras de todo el servidor al agente, lo que significa que un error de dependencias, un bucle de comandos o una vulnerabilidad de red comprometerá irreversiblemente el sistema operativo completo.

---
