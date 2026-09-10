# SKILL: Capturar Feedback Visual Quirúrgico con Agentation y DevTools MCP

> Guarda este archivo en `/skills/capturar-feedback-visual-agentation/SKILL.md`
> Referencia en tu CLAUDE.md: `- /skills/capturar-feedback-visual-agentation/SKILL.md → para inspeccionar elementos UI en vivo y pasar feedback estructurado con viewports a Claude Code`

---

## Cuándo usar este skill

Cuando el desarrollador requiera:
1. Modificar elementos específicos de una interfaz web en `localhost` (iconos, espaciados, colores, tipografías) sin enviar capturas de pantalla ambiguas a la consola.
2. Evitar alucinaciones de posición (ej. "el botón de arriba a la derecha") pasando selectores DOM, viewports y coordenadas exactas a Claude Code.
3. Asegurar que las correcciones de diseño respeten el responsive design en breakpoints críticos (mobile, tablet, desktop).

Basado en las directrices de la **Clase 23 — Claude Code: Estructura de proyectos y skills**.

---

## Prerequisitos

- [ ] Proyecto web activo corriendo en desarrollo local (`npm run dev`).
- [ ] Paquete `agentation` instalado en el proyecto o script inyectado en el layout de desarrollo:
  ```bash
  npm i agentation -D
  ```
- [ ] Opcional: servidor MCP de Chrome DevTools configurado en `.mcp.json`.

---

## Pasos de Captura y Aplicación de Feedback

### Paso 1 — Montar el Inspector Visual en el Entorno Local
1. Asegurar que Agentation esté disponible en modo desarrollo en `app/layout.tsx` o `src/App.tsx`:
   ```tsx
   import { Agentation } from 'agentation';

   export default function RootLayout({ children }: { children: React.ReactNode }) {
     return (
       <html lang="es">
         <body>
           {children}
           {process.env.NODE_ENV === 'development' && <Agentation />}
         </body>
       </html>
     );
   }
   ```
2. Iniciar el servidor local:
   ```bash
   npm run dev
   ```

### Paso 2 — Selección de Elementos y Anotación Contextual
1. Abre el navegador en `http://localhost:3000`.
2. Haz clic en el botón flotante de Agentation en la esquina inferior derecha para activar el modo de selección.
3. Pasa el cursor sobre el elemento que deseas corregir (botón, card, icono, contenedor). El inspector resaltará el nodo DOM exacto.
4. Haz clic para anclar un comentario:
   - Especifica la instrucción concisa (ej. "Reemplazar icono por Paintbrush de Lucide", "Aumentar padding vertical a py-4").
5. Repite el proceso para múltiples elementos en el mismo viewport (se numerarán secuencialmente: 1, 2, 3...).

### Paso 3 — Exportar y Pegar el Feedback Estructurado
1. En la barra de Agentation, haz clic en **Copy Feedback**.
2. El portapapeles contendrá un bloque estructurado con:
   - Viewport activo (ej. `390x844` para mobile viewport).
   - Selector CSS / Tag del componente.
   - Lista numerada de cambios requeridos.
3. Pega el contenido directamente en tu sesión de Claude Code:
   ```text
   Aplica los siguientes cambios de diseño capturados con Agentation:
   [Pegar bloque de feedback]
   ```

### Paso 4 — Inspección Alternativa con Chrome DevTools MCP
Si no se tiene Agentation instalado:
1. Abre las herramientas de desarrollador de Chrome (`Cmd + Option + I` / `F12`).
2. Selecciona el elemento en la pestaña Elements.
3. Con el servidor MCP de Chrome DevTools activo, indica a Claude Code:
   ```text
   Inspecciona el elemento actualmente seleccionado en Chrome DevTools y ajusta su clase de espaciado en el componente correspondiente.
   ```

---

## ⚠️ Errores comunes a evitar

| Error | Consecuencia | Solución |
| :--- | :--- | :--- |
| **Pegar capturas de pantalla en la terminal** | Claude Code en CLI no procesa imágenes eficientemente | Usar Agentation para copiar selectores y viewports exactos |
| **Dar feedback sin indicar el viewport** | Rompe la vista móvil al arreglar la vista de escritorio | Capturar en el breakpoint deseado (mobile-first) |
| **Dejar Agentation activo en producción** | Expone herramientas internas a los usuarios | Envolver el componente en `NODE_ENV === 'development'` |

---

*Creado: Septiembre 2026 · Basado en Clase 23 de Vibe Coding*
