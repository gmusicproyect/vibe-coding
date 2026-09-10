# Clase 28 — Instalación y Configuración de Antigravity

**Tags:** `Antigravity` `Setup` `MCP Servers` `Stack MVP`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 25](clase-25-antigravity-claude-code-openclaw.md) · [Clase 27](clase-27-vibe-coding-antigravity-de-idea-a-deploy.md)

---

## Idea central

La puesta en marcha del entorno de Vibe Coding exige aprovisionar las cuentas del stack (GitHub, Supabase, Vercel y Google AI Studio) bajo autenticación unificada antes de instalar el IDE. Google Antigravity, como fork de VS Code, centraliza el flujo de trabajo ofreciendo modos de ejecución (Planning y Fast), asignación estratégica de modelos (Gemini Flash, Pro y Claude) y conexión extensible mediante servidores MCP preconfigurados y personalizados.

---

## 1. Aprovisionamiento Encadenado del Ecosistema

Para agilizar accesos y permisos entre herramientas sin dispersión de credenciales, el orden de creación se articula a partir de GitHub:

1. **GitHub:** Se crea la cuenta base (opción recomendada: vincular con Google). Opera como el proveedor de identidad y el repositorio central.
2. **Supabase:** Se inicia sesión mediante *"Continue with GitHub"*. Se crea la organización gratuita, un nuevo proyecto en región geográfica cercana (ej. Américas) y se define una contraseña maestra segura para PostgreSQL.
3. **Google AI Studio:** Se ingresa con la cuenta de Google. Un GPT personalizado del curso actúa como generador de PRD (Product Requirements Document): produce el metaprompt que luego se entrega a Google AI Studio para maquetar el prototipo.
4. **Vercel:** Registro en plan Hobby con nombre de equipo inicial conectando directamente la cuenta de GitHub, autorizando el acceso a repositorios para despliegue automático.

---

## 2. Instalación y Gobernanza en Antigravity

Antigravity se descarga para el sistema operativo correspondiente (macOS, Windows o Linux) y se inicia con una configuración limpia:

- **Origen de configuración:** Se puede importar la configuración de VS Code o Cursor si ya la tienes armada, o iniciar desde cero (*Start Fresh*) — recomendado para quienes recién comienzan, ya que no arrastra plugins, temas ni carpetas previas que haya que desaprender.
- **Esquema de Gobernanza:**
  - *Secure mode:* Máxima restricción; cuestiona e interrumpe cada paso.
  - *Review-driven development (Recomendado):* El agente propone el código y solicita autorización explícita antes de ejecutar comandos o escrituras.
  - *Agent-driven development:* Ejecución completamente autónoma desatendida; reservada solo para tareas triviales.
  - *Custom configuration:* Políticas granulares por tipo de acción (ej. pedir confirmación solo para esquemas de bases de datos o autenticación).
- **Inicio de sesión y CLI:** Se aprueba la instalación de la herramienta en línea de comandos y se autentica mediante la cuenta de Google.

---

## 3. Interfaz, Modelos y Expansión MCP

El espacio de trabajo divide el control entre el explorador clásico de VS Code y el panel del agente inteligente:

| Elemento / Modelo | Función / Modo | Caso de Uso Óptimo |
| :--- | :--- | :--- |
| **Planning Mode** | Modo analítico / chat | Diseña la arquitectura, razona el plan y no aplica cambios inmediatos. |
| **Fast Mode** | Modo ejecutor | Aplica cambios directos en archivos una vez validado el plan. |
| **Gemini 3.0 Flash** | Modelo rápido | Tareas de lectura, análisis de sintaxis y generación de código directo. |
| **Gemini 3.0 Pro** | Modelo de razonamiento | Tareas de investigación más profundas antes de tomar una decisión. |
| **Claude Opus / Sonnet** | Modelo de precisión | Depuración profunda (*debugging*), errores de lógica y resolución de fallos complejos. |
| **MCP Servers** | Protocolo de contexto | Integraciones preconfiguradas y externas con GitHub, Vercel, Supabase y n8n. |

---

## 🎯 Ejercicio práctico

Instalar el entorno de desarrollo y verificar la gobernanza del agente.

**Ejercicio 1:** Descarga e instala Antigravity seleccionando una configuración limpia (*Start Fresh*) y tema de interfaz preferido. Fija la política de ejecución en *Review-driven development*, inicia sesión con tu cuenta de Google y confirma en el panel lateral que el agente esté disponible alternando entre *Planning Mode* y *Fast Mode*.

**Ejercicio 2 (avanzado, opcional):** Abre el menú superior de *Additional Options → MCP Servers* en Antigravity y localiza los servidores integrados para planificar las conexiones con Supabase y GitHub.

---

## 💡 Tip

Utiliza GitHub como proveedor de inicio de sesión único (OAuth) al registrarte en Supabase y Vercel. Esto no solo reduce la gestión de contraseñas, sino que pre-autoriza la lectura de repositorios para que los despliegues e integraciones se sincronicen en un solo clic.

---

## ⚠️ Error común

Usar el modelo más potente (Claude Opus) para todas las tareas por defecto, incluyendo lectura, análisis o identificación de código simple. Con la cuenta gratuita de Google, esto agota rápido los rate limits disponibles. La asignación estratégica —Flash para leer/analizar, Pro para investigar, Opus solo para depuración de errores complejos— es lo que permite estirar la cuota gratuita durante todo el curso.

---
