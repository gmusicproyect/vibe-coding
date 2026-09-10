# Clase 36 — Supabase Auth, Verificación por Email y Deploy a Vercel

**Tags:** `Supabase Auth` `Vercel Deploy` `Antigravity` `Producción`
**Conecta con:** [Clase 08](clase-08-ux-seguridad.md) · [Clase 31](clase-31-primera-win-clon-linktree-antigravity.md) · [Clase 35](clase-35-arquitectura-hibrida-n8n-email-composer-git.md)

---

## Idea central

La maduración de un MVP hacia un producto comercialmente viable exige cerrar la brecha de gobernanza mediante autenticación real y despliegue continuo en la nube. Frente a alternativas auto-alojadas como BetterAuth, Supabase Auth simplifica el stack integrando registro, inicio de sesión y validación forzosa por correo electrónico sin infraestructura adicional. El ciclo concluye trasladando las variables de entorno locales hacia Vercel, ejecutando la compilación de producción y validando el flujo operativo en una URL pública.

---

## 1. Criterio de Selección: Supabase Auth vs. BetterAuth

Al evaluar mecanismos de acceso para aplicaciones asistidas por IA, el objetivo consiste en minimizar la fricción de mantenimiento:

- **Supabase Auth (Opción Ganadora):** Ya forma parte del backend PostgreSQL activo. Ofrece infraestructura gestionada de autenticación, plantillas integradas de confirmación por email, manejo nativo de sesiones con tokens JWT y compatibilidad directa con las políticas de Row Level Security (RLS).
- **BetterAuth:** Aunque popular en el ecosistema TypeScript, demanda backend propio, configuración de servidores SMTP para correos y mayor sobrecarga de mantenimiento operativo.
- **Alcance Funcional del Módulo:**
  - Vistas dedicadas de *Sign In* y *Sign Up*.
  - Bloqueo de rutas privadas (redirección al login ante sesiones nulas).
  - Verificación obligatoria: ningún usuario accede al dashboard hasta confirmar el enlace emitido a su bandeja de entrada.

---

## 2. Configuración en Supabase y Flujo de Verificación

Para evitar registros anónimos o descontrolados en la base de datos:

1. **Activación de Proveedor:** En el panel de Supabase, acceder a *Authentication → Providers → Email* y marcar la casilla **Confirm email**.
2. **Plantillas de Mensajería:** Por defecto se utiliza el template estándar del servicio; puede personalizarse posteriormente desde la consola sin alterar el código de la app.
3. **Prueba Maestra de Autenticación:**
   - Registrar una cuenta con credenciales de prueba.
   - Constatar la recepción del correo de activación y pulsar el enlace de verificación.
   - Iniciar sesión en la aplicación y constatar el desbloqueo del dashboard y la barra de navegación del usuario.

---

## 3. Despliegue en Vercel y Sincronización de Variables

El despliegue a producción conecta el repositorio remoto de GitHub con Vercel garantizando que los secretos no se expongan:

| Etapa del Despliegue | Canal Operativo | Procedimiento de Seguridad |
| :--- | :--- | :--- |
| **Control de Versiones** | Push a GitHub | Confirmar que el código esté sincronizado en `main` y que `.env.local` permanezca excluido. |
| **CLI / MCP Vercel** | Terminal o Integración | Autenticar el dispositivo vía `npx vercel login` o enlazar el repositorio directamente en la consola web. |
| **Inyección de Secretos** | *Settings → Environment Variables* | Importar las claves de `.env.local` (`VITE_GEMINI_API_KEY`, `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`). |
| **Redeploy y Smoke Test** | Producción Vercel | Ejecutar *Redeploy* tras guardar las variables y probar en vivo el login, diagnósticos y el webhook de n8n. |

> **Repositorio de Referencia:** El código fuente final de la aplicación completa se encuentra publicado en el repositorio de código abierto [`Automation-Opportunity-Finder`](https://github.com/agenciainsigniaia-oss/Automation-Opportunity-Finder..git).

---

## 🎯 Ejercicio práctico

Implementar el sistema de acceso de usuarios y publicar la versión definitiva en Vercel.

**Ejercicio 1:** En Antigravity, solicita al agente en *Planning Mode* crear las vistas de inicio de sesión y registro protegidas con Supabase Auth. Activa la opción *Confirm email* en tu panel de Supabase, regístrate en local y verifica el acceso. Luego, enlaza tu repositorio en Vercel, carga manualmente tus variables de entorno en la sección *Environment Variables*, dispara el despliegue y valida que puedas autenticarte y enviar correos mediante n8n desde el dominio público.

**Ejercicio 2 (avanzado, opcional):** Configura en tu proveedor de DNS un subdominio personalizado apuntando al registro CNAME provisto por Vercel para dotar a la herramienta de una identidad comercial definitiva.

---

## 💡 Tip

Si tras desplegar en Vercel la aplicación abre pero se queda en blanco o arroja errores al intentar iniciar sesión, no modifiques el código: el 95% de las fallas en producción se debe a variables de entorno faltantes. Recuerda que Vercel no lee tu archivo `.env.local`; debes agregar cada variable en *Settings → Environment Variables* y forzar un nuevo despliegue (*Redeploy*) desde la pestaña *Deployments* para que el nuevo bundle de producción compile con las claves cargadas.

---

## ⚠️ Error común

Quedarse bloqueado intentando que el MCP de Vercel complete todo el despliegue de forma 100% desatendida cuando exige validaciones interactivas de dispositivo o tokens locales. Si la autenticación por terminal consume demasiado tiempo, abre el navegador, conecta el repositorio de GitHub directamente desde el dashboard de Vercel y finaliza el deploy en dos clics. En vibe coding, la meta es la entrega funcional, no el purismo de herramientas.

---
