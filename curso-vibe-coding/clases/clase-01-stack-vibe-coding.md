# Clase 01 — 3 preguntas antes de elegir tu stack

**Tags:** `Vibe Coding` `Stack` `Next.js` `Supabase`
**Conecta con:** Inicio del curso · [Clase 02](clase-02-tunear-claude-code.md)

---

## Idea central

El Vibe Coding evolucionó de "dejar que la IA programe a ciegas" a orquestar con criterio. En 2026 el stack no se elige solo ni se delega ciegamente al agente: se define en conjunto evaluando qué escribe bien el modelo, qué tan fácil es migrar y si la factura escala con los ingresos o con el tráfico.

---

## Los 3 criterios de decisión

| Criterio | Pregunta clave | Por qué importa |
|----------|----------------|-----------------|
| **Densidad de agente** | ¿Hay tanto código público que el agente lo escribe bien a la primera? | Reduce errores y alucinaciones basándose en estándares de la industria y documentación amplia. |
| **Puerta de salida** | ¿De cuál tecnología me puedo salir mañana si suben precios o cierran? | Evita el encierro (*vendor lock-in*); preferir PostgreSQL abierto sobre formatos propietarios como Firebase. |
| **Costo vs. Ingresos** | ¿La factura sube cuando yo facturo o sube antes con el tráfico? | Protege la rentabilidad: saber cuándo el costo acompaña a los clientes y cuándo es un riesgo descontrolado. |

---

## Ecosistema de herramientas: Terminal, IDEs y ADEs

- **CLI y Terminal:** Warp, Ghostty o terminal nativa con Claude Code / Codex CLI. Menor consumo de RAM con pestañas agrupadas y control directo de procesos.
- **ADEs y Multiagente:** Orca para orquestar varios agentes en paralelo sobre *git worktrees* aislados, evitando que sobreescriban los mismos archivos.
- **IDEs con IA:** Cursor (edición manual de precisión con soporte de agentes) o VS Code / Antigravity IDE para explorar el árbol del proyecto visualmente.
- **Gestión de dependencias:** Priorizar `pnpm` o `bun` para paquetes estables; usar `npx` para herramientas de ejecución única sin ensuciar `package.json`.

---

## El Golden Path para Web Apps

El camino probado para resolver el 90% de los proyectos web con agentes:

1. **Framework & Tipado:** Next.js 16 + React 19 + TypeScript.
2. **UI & Estilos:** Tailwind CSS (versión 3.4 para máxima compatibilidad) + shadcn/ui (copia componentes en `components/ui/` para que el agente pueda editarlos).
3. **Backend & Base de datos:** Supabase (PostgreSQL + Supabase Auth + RLS activo por fila).
4. **Validación & Estado:** Zod (TypeScript promete en compilación, Zod verifica en runtime) + Zustand.
5. **Servicios de producción:** Stripe o Mercado Pago (pagos), Resend (emails transaccionales), Sentry (errores) y PostHog (analítica).

---

## Deploy y hosting: Vercel vs. VPS propio

| Plataforma | Cuándo usarla | Costo y trade-off |
|------------|---------------|-------------------|
| **Vercel** | Arranque rápido, MVPs y proyectos iniciales | Capa gratuita generosa (\$20 Pro); escala rápido con tráfico alto (\$400+/mes). |
| **VPS con Coolify / Docker** | Proyectos consolidados, múltiples clientes o microservicios | Costo fijo (\$17-\$25/mes); requiere que tú seas el soporte y administres backups/restores. |

> **Umbral de migración:** Iniciar en Vercel por velocidad. Considerar migrar a VPS autohosteado solo cuando la factura mensual supere los \$100.

---

## 🎯 Ejercicio práctico

**Ejercicio 1:** Crea un archivo `tech-stack.md` en la raíz de un proyecto web nuevo. Define cada una de las capas (Framework, UI, Backend, Auth y Deploy) justificando la elección con los 3 criterios. Referencia este archivo en las instrucciones de tu agente (`CLAUDE.md`) para que no improvise librerías en cada sesión.

**Ejercicio 2 (avanzado):** Instala un componente con shadcn/ui en tu proyecto y verifica que el archivo `.tsx` quede editable dentro de `components/ui/` en lugar de quedar encerrado como caja negra en `node_modules`.

---

## 💡 Tip

Al pedirle a tu agente que integre un servicio externo (como Sentry o PostHog), usa la palabra restrictiva **"solo"** (ej. *"Agrega Sentry, solo lo mínimo para avisar errores en producción sin métricas de rendimiento"*). Esto acota la instalación, evita código innecesario y te mantiene dentro de las capas gratuitas.

---

## ⚠️ Error común

Crear tablas en la base de datos y no activar **RLS (Row Level Security)**. La seguridad por fila viene desactivada de fábrica; si no se configuran las políticas de acceso por usuario, la base de datos queda completamente pública y cualquier usuario puede consultar o alterar registros ajenos desde el navegador.
