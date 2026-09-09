# Clase 20 — Cerramos Núcleo: Deploy, GitHub y pruebas en vivo

**Tags:** `Deploy` `Playwright` `InsForge` `GitHub`
**Conecta con:** [Clase 16](clase-16-domina-github-experto.md) · [Clase 18](clase-18-estructurar-sesiones-agentes.md) · [Clase 19](clase-19-claude-code-n8n-kit.md)

---

## Idea central

Para culminar y desplegar una aplicación fullstack (Núcleo) de forma profesional con Claude Code, no basta con generar código: se exige un ciclo autónomo de validación con Definition of Done estricta, pruebas E2E visuales con Playwright MCP en `localhost`, backends optimizados para agentes (InsForge) con RLS obligatorio, documentación actualizada en tiempo real con Context 7 y despliegue a producción controlado mediante ramas atómicas de Git.

---

## 1. Definition of Done y Pruebas E2E con Playwright MCP

Evita prompts vagos tipo "agrega esta función". Exige condiciones de completitud explícitas antes de que el agente dé por cerrada una tarea:

1. **Compilación y tipado:** Ejecución obligatoria de `npm run build` y validación estricta de TypeScript sin advertencias.
2. **Inspección en vivo:** Claude Code levanta el servidor local (`localhost:3000`) y se conecta mediante el servidor Playwright MCP.
3. **Validación visual y funcional:** El agente navega la vista, hace clic en botones, completa formularios, verifica la persistencia en base de datos y captura screenshots como evidencia irrefutable antes de finalizar el turno.

---

## 2. InsForge vs. Supabase y Documentación Viva con Context 7

Elegir la infraestructura adecuada y mantener sincronizadas las APIs evita alucinaciones y optimiza el consumo de tokens:

| Característica | Supabase | InsForge (`insforge.dev`) |
| :--- | :--- | :--- |
| **Enfoque principal** | BaaS general basado en PostgreSQL | Backend as a Service nativo para agentes de IA |
| **Interacción con Agentes** | CLI estándar + Dashboard web manual | CLI y endpoints optimizados para llamadas MCP |
| **Ahorro de Contexto** | Schemas y logs voluminosos en prompts | Reducción de hasta un 40% en tokens consumidos |
| **Capacidades nativas** | Auth, Storage, Postgres, Realtime | Postgres, Auth, Storage, Realtime y PGVector integrado |

- **Context 7 (`context7.com`):** Conecta repositorios de documentación oficial actualizada en tiempo real mediante MCP o CLI. Permite que Claude Code consulte firmas de métodos y parámetros de librerías modernas (Next.js, Playwright, Stripe) sin inventar funciones obsoletas.

---

## 3. Seguridad Crítica y Despliegue con Ramas Git

Antes de desplegar en Vercel, Docker o Coolify, audita los tres pilares de seguridad y mantén la disciplina de control de versiones:

- **Row Level Security (RLS) mandatorio:** Cada tabla en Supabase o InsForge debe tener RLS activo (`ENABLE ROW LEVEL SECURITY`) con políticas explícitas vinculadas al `auth.uid()`.
- **Sesiones en cookies `httpOnly`:** Nunca almacenes tokens JWT en `localStorage` (vector crítico para ataques XSS). Utiliza cookies seguras del lado del servidor.
- **Ramas atómicas y Pull Requests:** Nunca envíes código directamente a `main`. Trabaja en ramas `feat/*` o `fix/*`, inspecciona los cambios con `git diff` y fusiona mediante Pull Request verificado por pruebas automáticas.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Implementa un flujo con Definition of Done y verificación visual con Playwright MCP en un proyecto local:
1. Asegúrate de tener configurado Playwright MCP en tu `.mcp.json`.
2. Ejecuta Claude Code en tu repositorio y dale la siguiente consigna de trabajo:
   ```text
   Implementa la exportación de marcadores en CSV en Núcleo. Antes de terminar:
   1. Ejecuta 'npm run build' y corrige cualquier error de tipos.
   2. Levanta 'npm run dev', abre 'http://localhost:3000' usando Playwright MCP.
   3. Haz clic en el botón de exportación, captura un screenshot de la confirmación visual y guárdalo en /screenshots.
   ```
3. Revisa el screenshot generado y los diffs con `git diff` antes de hacer commit en tu rama.

**Ejercicio 2 (avanzado):** Integra Context 7 para que Claude Code consulte las políticas RLS recomendadas de tu proveedor de base de datos antes de escribir los scripts de migración.

---

## 💡 Tip

> **Screenshots obligatorios como comprobante de entrega:** Condiciona el cierre de cada tarea visual solicitando a Claude Code una captura de pantalla tomada con Playwright MCP. Si el componente compila pero se rompe visualmente (ej. superposición de estilos o z-index incorrecto), el agente lo detectará de inmediato al ver la imagen antes de reportar la tarea como completada.

---

## ⚠️ Error común

> **Omitir RLS o almacenar tokens de autenticación en localStorage:** Guardar credenciales de sesión en `localStorage` o dejar tablas de base de datos sin políticas RLS permite que cualquier script inyectado o consulta maliciosa acceda a los datos privados de todos los usuarios. Aplica siempre cookies `httpOnly` y prueba tus políticas RLS con usuarios no autenticados antes de desplegar.
