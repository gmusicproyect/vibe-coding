# SKILL: Construir Web Apps con el Golden Path y Blueprint Unificado

> Guarda este archivo en `/skills/construir-webapp-golden-path/SKILL.md`
> y referencíalo en tu CLAUDE.md para que Claude Code lo use en proyectos de desarrollo web.

---

## Cuándo usar este skill

Cuando el usuario solicite crear una aplicación web completa (SaaS, ERP, dashboard, herramienta interna o MVP), planificar un proyecto con la metodología del 80/20 (Blueprint como única fuente de verdad) o implementar aplicaciones en Claude Code siguiendo el stack estándar: Next.js (App Router), Supabase (PostgreSQL), Tailwind CSS, shadcn/ui y Vercel.

---

## Prerequisitos

- [ ] Node.js 18+ y gestor de paquetes (`npm`, `pnpm` o `bun`)
- [ ] Claude Code CLI en modo auto o bypass (`--dangerously-skip-permissions` / alias `yolo`)
- [ ] Cuenta de Supabase (o instancia local de PostgreSQL / OrbStack)
- [ ] Cuenta de Vercel y repositorio Git inicializado (`git init`)
- [ ] Playwright instalado (`npx playwright install chromium`) para testing visual
- [ ] Servidor MCP de Supabase y/o Agentation (opcional, para feedback interactivo)

---

## Pasos

### Paso 1 — Redactar el Blueprint Unificado (`BLUEPRINT.md`)
Antes de generar una sola línea de código, crea el archivo `BLUEPRINT.md` en la raíz del proyecto. Este documento es la **única fuente de verdad** y debe contener:
1. **Visión y PDR:** Problema que resuelve, público objetivo y alcance estricto del MVP.
2. **Pre-mortem:** Riesgos identificados (seguridad, consistencia de datos, límites de cuota).
3. **Stack Arquitectónico:**
   - Framework: `Next.js 16` con App Router y Server Components.
   - UI: `Tailwind CSS` + componentes copiables de `shadcn/ui`.
   - Backend & DB: `Supabase` (PostgreSQL con RLS).
   - Tipos & Estado: `TypeScript` estricto + `Zod` para validaciones de input + `Zustand` para estado global ligero.
4. **Modelo de Datos y Migraciones SQL:** Tablas con primary keys, foreign keys, tipos exactos y sentencias DDL listas para copiar a Supabase.
5. **Estrategia UI y Mobile-First:** Reglas explícitas de cómo deben colapsar tablas en pantallas móviles (tarjetas apiladas) y paleta de tokens CSS.
6. **User Stories:** Flujos de entrada, procesamiento, salida y validación de casos borde (ej. no permitir stock negativo, unicidad de SKU).
7. **Rúbrica de Validación:** Lista de verificación numerada con criterios verificables para auditar la entrega.

### Paso 2 — Inicializar el Proyecto con Next.js y shadcn/ui
Ejecuta la inicialización estándar del stack:
```bash
npx create-next-app@latest . --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm
npx shadcn@latest init -d
```
Instala las dependencias del Golden Path:
```bash
npm install @supabase/supabase-js zod zustand lucide-react
npx shadcn@latest add button card dialog input table badge toast dropdown-menu
```

### Paso 3 — Ejecución One-Shot con Ultra Code
En la sesión de Claude Code, lanza la construcción invocando los workflows dinámicos:
```
ultra code: Lee BLUEPRINT.md y construye la aplicación completa siguiendo el Golden Path.
Asegúrate de:
1. Crear los esquemas Zod y tipos TypeScript en src/types/.
2. Implementar los componentes UI de shadcn/ui y páginas en src/app/.
3. Crear los Server Actions / rutas API con validación de datos.
4. Exportar el archivo de migración supabase/migrations/001_initial_schema.sql.
5. Ejecutar npm run build y resolver cualquier error de compilación.
```

### Paso 4 — Verificación en Tiempo Real con TurboPack y Playwright
Levanta el servidor de desarrollo local y audita la aplicación:
```bash
npm run dev -- --turbo
```
Utiliza Playwright para navegar la interfaz:
1. Validar que el dashboard cargue KPIs y gráficos sin errores de consola.
2. Probar flujos CRUD completos (creación, edición, eliminación).
3. Provocar intencionalmente casos de error (duplicación de ID, campos vacíos) y certificar que la interfaz responda con toasts claros.

### Paso 5 — Refinamiento Visual y Auditoría Mobile-First
1. Abre las herramientas de desarrollador o activa el MCP de **Agentation** (`agentation self drive`).
2. Verifica la responsividad en viewport móvil (`390×844` px):
   - Menú de navegación colapsado en botón hamburguesa.
   - Tablas transformadas en tarjetas verticales legibles.
   - Botones táctiles con altura mínima de `44px`.
3. Corrige padding excesivo, márgenes rotos o desbordes horizontales de texto.

### Paso 6 — Despliegue en Producción (Vercel)
Conecta el repositorio a Vercel para activar el pipeline de entrega continua:
```bash
git add .
git commit -m "feat: implementacion inicial segun blueprint"
git push origin main
```
Configura las variables de entorno en Vercel (`NEXT_PUBLIC_SUPABASE_URL` y `NEXT_PUBLIC_SUPABASE_ANON_KEY`) y verifica el build en producción.

---

## Outputs esperados

- Archivo `BLUEPRINT.md` exhaustivo y autocontenido.
- Estructura Next.js 16 modular (`src/app/`, `src/components/`, `src/lib/`, `src/types/`).
- Migraciones SQL documentadas en `supabase/migrations/`.
- Aplicación funcional, libre de errores en `npm run build` y 100% responsiva.

---

## Errores comunes

| Error | Causa | Solución |
|-------|-------|----------|
| **Código "Frankenstein" desarticulado** | Construir mediante prompts sueltos sin un Blueprint previo | Redactar siempre el `BLUEPRINT.md` completo antes de pedir código al agente |
| **Tablas cortadas en móvil** | Diseñar tablas pensadas exclusivamente para pantallas anchas | Incluir en el Blueprint la directiva de convertir tablas en cards en viewports menores a 768px |
| **Gasto excesivo de tokens en Fable 5** | Usar el modelo más caro para codificación repetitiva de componentes | Usar Fable solo para planificar y auditar; cambiar a Opus 4.8 o Sonet para programar |
| **Formularios sin validación de tipos** | Confiar solo en validación HTML básica en el cliente | Usar schemas de `Zod` compartidos entre cliente y servidor en cada mutación |

---

## Variaciones

**Variación A — Base de Datos Local (PostgreSQL en Docker / OrbStack):** Cuando se requiera desarrollo offline o se alcancen los límites de proyectos gratuitos en Supabase Cloud. Consume ~40 MB de RAM frente a los 4 GB de una suite Supabase completa.

**Variación B — Landing Estática Ligera (Vite / Astro):** Si el proyecto no requiere base de datos relacional ni Server Components, reemplazar Next.js por Vite o Astro para builds instantáneos a costo cero de servidor.

---

## Notas adicionales

Un buen Blueprint reduce drásticamente el número de turnos necesarios para terminar un software: lo que antes tomaba 15 iteraciones corrigiendo errores de base de datos y UI se completa en 1 o 2 pasadas limpias cuando el agente cuenta con especificaciones inequívocas.

---

*Creado: 2026-09-07 · Basado en la Masterclass Golden Path por Carlos Domínguez y Juaco Malig*
