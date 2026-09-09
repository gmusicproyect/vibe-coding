# SKILL: Validación E2E y Pruebas Visuales Autónomas con Playwright MCP

> Guarda este archivo en `/skills/validar-e2e-playwright-claude-code/SKILL.md`
> Referencia en tu CLAUDE.md: `- /skills/validar-e2e-playwright-claude-code/SKILL.md → para validar interfaces web, flujos interactivos y Definition of Done mediante Playwright MCP`

---

## Cuándo usar este skill

Cuando el usuario o el flujo de trabajo requiera:
1. Validar autónomamente componentes web, páginas y flujos interactivos (formularios, modales, descargas) en `localhost`.
2. Tomar screenshots de verificación visual para garantizar que los estilos y el layout no se rompan tras refactors.
3. Establecer un ciclo estricto de Definition of Done (compilación TypeScript + ejecución de build + validación de interfaz en navegador) antes de reportar una tarea como completada.

Basado en las directrices de la **Clase 20 — Cerramos Núcleo: Deploy, GitHub y pruebas en vivo**.

---

## Prerequisitos

- [ ] Node.js y proyecto web (Next.js, Vite, etc.) con script de desarrollo (`npm run dev`) y build (`npm run build`).
- [ ] Servidor Playwright MCP configurado en `.mcp.json` o en la configuración global de MCP de Claude Code:
  ```json
  {
    "mcpServers": {
      "playwright": {
        "command": "npx",
        "args": ["-y", "@executeautomation/playwright-mcp-server"]
      }
    }
  }
  ```
- [ ] Directorio para evidencias visuales (ej. `.screenshots/` o `tests/screenshots/`).

---

## Pasos de Validación E2E

### Paso 1 — Verificación Estática (Gate 1)
Antes de interactuar con el navegador, asegurar que el código compila y tipa correctamente:
1. Ejecutar el linter y typecheck:
   ```bash
   npm run build
   ```
2. Si hay errores sintácticos o discrepancias de tipos en TypeScript, corregirlos inmediatamente antes de avanzar al navegador.

### Paso 2 — Levantamiento y Conexión al Servidor Local (Gate 2)
1. Iniciar el servidor local si no está corriendo:
   ```bash
   npm run dev &
   ```
2. Esperar a que el puerto esté activo (por defecto `http://localhost:3000` o `5173`).
3. Conectar Playwright MCP y navegar a la URL base o ruta específica de la funcionalidad bajo prueba:
   - Llamar a la herramienta de navegación de Playwright (`browser_navigate`) apuntando a la ruta objetivo.

### Paso 3 — Interacción y Pruebas Funcionales (Gate 3)
1. Localizar los elementos clave por rol, texto accesible o selector semántico (evitar selectores frágiles como hashes dinámicos de CSS).
2. Ejecutar las interacciones requeridas:
   - Llenar campos de texto (`browser_type`).
   - Hacer clic en botones o enlaces (`browser_click`).
   - Verificar estados de carga y feedback visual.
3. Confirmar que la mutación o acción se reflejó en el DOM o en la persistencia esperada.

### Paso 4 — Captura de Evidencia Visual y Chequeo de Consola (Gate 4)
1. Capturar un screenshot de la pantalla completa o del componente interactuado (`browser_screenshot`).
2. Guardar la evidencia en una carpeta ignorada por git o específica de pruebas:
   ```text
   .screenshots/e2e_[modulo]_[timestamp].png
   ```
3. Inspeccionar logs de consola del navegador para verificar que no existan errores 4xx/5xx ni advertencias críticas de React/Next.js.

### Paso 5 — Limpieza y Reporte
1. Detener servidores en background si fueron levantados exclusivamente para la prueba.
2. Reportar al usuario el resultado de la validación incluyendo:
   - Estado del build (`npm run build`).
   - Pasos navegados con éxito.
   - Ruta del screenshot generado para inspección humana.

---

## Plantilla de Prompt de Definition of Done

Para exigir esta validación directamente en Claude Code:

```text
Implementa [funcionalidad].
Antes de marcar la tarea como completada, debes cumplir la Definition of Done:
1. Ejecuta 'npm run build' y valida cero errores.
2. Navega a http://localhost:3000 con Playwright MCP y prueba el flujo de [funcionalidad].
3. Captura un screenshot que evidencie el funcionamiento correcto y verifica que la consola del navegador esté libre de errores.
```

---

## ⚠️ Errores comunes a evitar

| Error | Causa | Solución |
| :--- | :--- | :--- |
| **"Funciona en código pero la UI está rota"** | Solo compilar sin probar en navegador | Exigir screenshot obligatorio con Playwright MCP |
| **Selectores rotos por clases Tailwind** | Buscar elementos por cadenas largas de clases utilitarias | Usar data-testid, aria-label o texto accesible |
| **Proceso colgado en segundo plano** | Olvidar cerrar el proceso `npm run dev` | Manejar procesos adecuadamente o usar servidores persistentes |

---

*Creado: Septiembre 2026 · Basado en Clase 20 de Vibe Coding*
