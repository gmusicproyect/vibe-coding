# Clase 23 — Claude Code: Estructura de proyectos y skills

**Tags:** `Estructura` `Skills` `Agentation` `Remote Control`
**Conecta con:** [Clase 02](clase-02-tunear-claude-code.md) · [Clase 07](clase-07-ui-tokens.md) · [Clase 21](clase-21-como-no-quemar-tokens.md)

---

## Idea central

Dominar Claude Code a nivel profesional exige una arquitectura física de carpetas estricta (`~/developer/software/templates`) con nombres bash-safe (sin mayúsculas, tildes ni espacios) para evitar fallos de terminal, la comprensión de los tres entornos de Anthropic (Claude AI, Cowork con Dispatch y Claude Code con puente remoto `/rc`), la instalación canónica de skills en `.claude/skills/<nombre>/SKILL.md`, y la sustitución de capturas de pantalla ambiguas por herramientas de feedback visual quirúrgico como Agentation y Chrome DevTools MCP en modo mobile-first.

---

## 1. El Ecosistema de Anthropic: Claude AI vs. Cowork vs. Claude Code

Entender qué comparte memoria y qué no evita fricciones y pérdidas de contexto entre dispositivos:

| Herramienta | Entorno | Memoria / Contexto | Caso de Uso Principal |
| :--- | :--- | :--- | :--- |
| **Claude AI** | Web y App móvil | Aislado de Claude Code; memoria de chat en desktop | Brainstorming, análisis de texto y estrategia |
| **Claude Cowork** | App de escritorio (Mac / Win) | Comparte contexto con Claude AI; incluye **Dispatch** | Creación de docs, PPTX y automatización de SO sin terminal |
| **Claude Code** | Terminal CLI, IDEs y Desktop | Autónomo; puente de control remoto con `/rc` | Arquitectura, codificación, refactoring y tests |

- **Aislamiento de memoria y skills:** Claude AI y Claude Cowork comparten la memoria persistente de escritorio y las habilidades instaladas en la app. Claude Code opera de forma desacoplada: no hereda la memoria conversacional de la app de escritorio ni sus skills (deben instalarse explícitamente en `.claude/skills/`). Lo único que conecta sesiones entre móvil/web y la máquina local en Claude Code es el Remote Control (`/rc`) o repositorios compartidos.
- **Remote Control (`/rc`):** Al ejecutar `/rc` en terminal, Claude Code genera un túnel seguro con la nube (`claude.ai/code`). Permite monitorear la compilación o dar nuevas directivas desde el celular sin interrumpir el proceso en la máquina local.

---

## 2. Jerarquía de Carpetas y Convenciones Bash-Safe

Un error en la nomenclatura de rutas rompe scripts de bash y llamadas del agente:

- **Estructura recomendada:**
  - `~/developer/`: Raíz del usuario (icono nativo en macOS).
  - `~/developer/software/`: Proyectos reales conectados a repositorios independientes de GitHub.
  - `~/developer/software/templates/`: Plantilla maestra con `CLAUDE.md`, `.mcp.json`, agentes y skills preconfigurados para clonar a nuevos proyectos.
  - `~/developer/tools/`: CLIs, scripts y utilerías globales — todo lo que usas en múltiples proyectos, fuera de cualquier repositorio individual.
  - `~/developer/playground/`: Directorio aislado para experimentos rápidos sin contaminar repositorios principales.
- **Regla de oro de nomenclatura:** Todo en **minúsculas**, sin espacios (usar guiones medios `-`) y sin caracteres especiales (tildes o eñes). Un espacio obliga a escapar caracteres (`\ `) y rompe llamadas automáticas en subprocesos.

---

## 3. Instalación de Skills y Feedback Visual con Agentation

- **Niveles de instalación de Skills:**
  - *Global / Usuario (`~/.claude/skills/`):* Disponible en cualquier sesión del sistema, sin importar el proyecto.
  - *Organización:* Disponible para todos los miembros de un workspace compartido de Anthropic, sin importar la máquina o el proyecto.
  - *Proyecto (`.claude/skills/<nombre>/SKILL.md`):* Específico del repositorio. Requiere reiniciar la sesión (`/init` o nueva ventana) para ser reconocido.
- **Agentation vs. Capturas de pantalla:** Enviar capturas de pantalla a la terminal confunde a los modelos de texto. Agentation inyecta un inspector interactivo en `localhost`:
  1. Haces clic en el elemento visual exacto.
  2. Escribes el cambio deseado con viewport y coordenadas automáticas.
  3. Presionas `Copy Feedback` y pegas el prompt estructurado en Claude Code, permitiendo cambios quirúrgicos inmediatos en CSS y componentes.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Organiza tu estructura de trabajo e instala un skill a nivel de proyecto:
1. Crea tu estructura en terminal siguiendo las reglas bash-safe:
   ```bash
   mkdir -p ~/developer/software/mi-app/.claude/skills/humanizador-web
   ```
2. Guarda la definición en formato canónico: `.claude/skills/humanizador-web/SKILL.md`.
3. Inicia Claude Code en el directorio y verifica que el comando `/humanizador-web` aparezca en la lista de autocompletado tras reiniciar la sesión.

**Ejercicio 2 (avanzado):** Levanta una app web local con Next.js, activa el control remoto ejecutando `/rc` en la terminal, abre `claude.ai/code` desde tu navegador o celular e interactúa con la sesión remota sin tocar la consola física.

---

## 💡 Tip

> **Diseño Mobile-First por defecto:** Al maquetar con Claude Code, exige siempre la directiva `Mobile-First`. El 95% del tráfico web ocurre en smartphones; diseñar primero para pantallas móviles y expandir mediante breakpoints (tableta, desktop) previene desbordamientos de layout y componentes rotos en producción.

---

## ⚠️ Error común

> **Usar espacios o mayúsculas en rutas de proyecto:** Nombrar carpetas como `Proyecto Final 2.0` provoca fallos silenciosos y errores de sintaxis al ejecutar comandos en terminal (`cd`, `npm`, scripts bash de Claude). Utiliza siempre `proyecto-final-2-0`.
