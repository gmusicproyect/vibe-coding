# Clase 31 — Primera Win: Clon de Linktree con Antigravity y Deploy en Vercel

**Tags:** `Vibe Coding` `Antigravity` `Browser QA` `Vercel Deploy`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 27](clase-27-vibe-coding-antigravity-de-idea-a-deploy.md) · [Clase 30](clase-30-supabase-mcp-conexiones-antigravity.md)

---

## Idea central

El valor del Vibe Coding se consolida al cerrar ciclos completos de desarrollo en tiempo récord pasando de una instrucción en lenguaje natural a una aplicación web publicada en menos de 35 minutos. Prescindiendo de bases de datos pesadas para capturas simples y delegando la lógica de leads a un webhook en n8n, Antigravity genera la interfaz neobrutalista en React/Vite, ejecuta pruebas de usabilidad autónomas mediante control de navegador y comanda el despliegue final en Vercel vía MCP.

---

## 1. De la Idea al Prototipo: Especificación Neobrutalista

En lugar de definir la arquitectura técnica archivo por archivo, el desarrollador orienta al agente en *Planning Mode* mediante un prompt enfocado en identidad visual y objetivos de conversión:

- **Estilo Visual:** Neobrutalismo caracterizado por bordes negros gruesos, tipografía de alto contraste y contenedores asimétricos con paletas sólidas.
- **Entidad Ficticia:** Marca personal *Alex Nova / Nova AI* orientada a automatizaciones y sistemas digitales.
- **Estructura:** Sección biográfica con avatar, enlaces a redes sociales (LinkedIn, Instagram, Facebook, TikTok), llamados a la acción (Toolkit descargable y servicios) y formulario de captura de correos.
- **Stack Autónomo:** El agente selecciona de forma autónoma React + Vite con Tailwind CSS y TypeScript, ejecutando `npm install` y preparando el servidor local en `localhost:5173`.
- **Código Base Disponible:** Se toma como referencia funcional el repositorio público [`nova-bio-link`](https://github.com/agenciainsigniaia-oss/nova-bio-link.git) para clonar o comparar la implementación final.

---

## 2. QA Visual con Agente Autónomo y Captura vía n8n

Antigravity no se limita a editar texto; valida la experiencia de usuario inspeccionando la aplicación en un navegador controlado:

| Fase Operativa | Mecanismo | Acción Concreta |
| :--- | :--- | :--- |
| **Control de Navegador** | Modo *Browser View* | El agente abre la ventana (halo azul), realiza scroll, redimensiona la vista móvil y toma capturas. |
| **Iteración de Interfaz** | Refinamiento guiado | Efecto *flip* 3D en avatar para escritorio, alternancia dinámica cada 2 s en móvil y corrección de enlaces. |
| **Captura Ligera (MVP)** | Webhook a n8n | En lugar de montar tablas en Supabase, el formulario envía un payload JSON a un endpoint de n8n. |
| **Enrutamiento de Leads** | Flujo en n8n | Escenario *"Linktree lista de correos"* que confirma la recepción del webhook (verificado en el log de ejecuciones); conectar el nodo a Gmail, Google Sheets o un CRM queda como paso siguiente. |

---

## 3. Versionado y Despliegue Público con MCPs

Una vez aprobado el comportamiento visual y operativo en local, se aprovechan las integraciones activas para publicar el producto:

1. **Control de Versiones en GitHub:** Se solicita al agente mediante el MCP de GitHub inicializar el repositorio remoto, redactar un `README.md` explicativo con pasos de ejecución y variables de webhook, y realizar el `push` inicial de código.
2. **Compilación y Creación en Vercel:** A través del MCP de Vercel, el agente corre `npm run build`, aprovisiona el proyecto en la organización conectada y dispara el despliegue a producción.
3. **Verificación de Humo en Producción:** El agente navega a la URL pública asignada por Vercel, confirma que los botones abran las rutas correspondientes y prueba el formulario para constatar que el webhook de n8n reciba el evento exitosamente.

---

## 🎯 Ejercicio práctico

Construir y desplegar un clon funcional de Linktree guiado por prompts y cerrado con webhook.

**Ejercicio 1:** En un espacio limpio de Antigravity, utiliza el modo de planificación para pedir una página de bio-links con estilo neobrutalista para tu marca personal. Levanta el servidor con `npm run dev`, solicita al agente que abra el navegador para revisar la vista móvil y pídele que enlace el formulario a un webhook de prueba en n8n. Finalmente, utiliza los comandos de los MCPs de GitHub y Vercel para subir el código a un nuevo repositorio y generar tu URL pública en Vercel.

**Ejercicio 2 (avanzado, opcional):** Configura en n8n un nodo posterior al webhook que inserte automáticamente el correo recibido en una hoja de cálculo de Google Sheets o envíe un correo de bienvenida automático al suscriptor con el enlace de descarga del recurso.

---

## 💡 Tip

Cuando necesites ajustar detalles visuales complejos (como el comportamiento responsivo en móviles o animaciones CSS), indícale al agente: *"Abre el navegador y mira lo que estoy viendo"*. Antigravity abrirá una ventana de navegador controlada (verás un halo azul alrededor), hará scroll, resize y clics de prueba, tomará capturas de la renderización real y ajustará el CSS corrigiendo discrepancias de alineación y color de forma mucho más precisa que mediante descripciones textuales.

---

## ⚠️ Error común

Implementar una base de datos relacional completa con autenticación y tablas complejas para proyectos que solo requieren recolectar un correo o redireccionar tráfico a redes. En fases de validación temprana o herramientas tipo bio-link, sobrecomplicar la arquitectura con backends pesados retrasa el lanzamiento; un simple webhook en n8n resuelve la captura de leads en minutos y mantiene el frontend 100% estático y económico.

---
