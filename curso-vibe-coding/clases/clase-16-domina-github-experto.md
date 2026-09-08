# Clase 16 — Domina GitHub como un experto

**Tags:** `Git` `GitHub` `CI/CD` `GitHub Actions`
**Conecta con:** [Clase 11](clase-11-gestionar-clientes-contexto.md) · [Clase 14](clase-14-tu-agente-programa-solo-duermes.md) · [Clase 15](clase-15-arneses-conectados-hermes-claude-code.md)

---

## Idea central
Git es el motor local offline de control de versiones (tu Time Machine y Ctrl+Z infinito basado en hashes SHA-1), mientras que GitHub es la plataforma colaborativa en la nube para alojar repositorios, coordinar equipos mediante Epics e Issues, automatizar flujos con GitHub Actions y proteger la integridad del código mediante Pull Requests con revisiones técnicas estrictas.

---

## 1. Git vs. GitHub y Regla de Oro de Almacenamiento

| Concepto | Git | GitHub |
| :--- | :--- | :--- |
| **Naturaleza** | Motor local, offline, descentralizado | Plataforma cloud web y colaborativa |
| **Herramienta CLI** | `git` (commits, branches, diffs) | `gh` (issues, PRs, releases) |
| **Identificador** | Hashes SHA-1 inmutables por commit | URLs, forks, pull requests, issues |
| **Peligro Crítico** | Carpetas sincronizadas en la nube | Fugas de secretos por repositorios públicos |

> **Regla de Oro:** NUNCA almacenes repositorios Git dentro de carpetas sincronizadas en la nube (Google Drive, Dropbox, iCloud o OneDrive). Los algoritmos de sincronización de archivos bloquean, modifican o duplican archivos temporales dentro del directorio oculto `.git/`, corrompiendo la base de datos de objetos y causando pérdidas irreparables de código.

---

## 2. Jerarquía Operativa: De la Idea al Código

Para mantener proyectos escalables y limpios con agentes de IA y equipos distribuidos (ej. caso real *Hisha*: 5 desarrolladores en 4 países sin conflictos de fusión):

1. **Repositorio:** Contenedor maestro del proyecto con `.gitignore` riguroso (`.env*`, credenciales, binarios).
2. **Epics (Paraguas Narrativo):** Grandes hitos o bloques funcionales que agrupan múltiples requerimientos.
3. **Issues Atómicos:** Tareas específicas vinculadas a un Epic, documentadas con pasos de reproducción, contexto y etiquetas estandarizadas:
   - Tipo: `bug`, `enhancement`, `documentation`.
   - Prioridad: `priority: critical`, `priority: high`, `priority: medium`.
   - Triggers de automatización: `run: e2e`, `needs-review`.
4. **Ramas Protegidas:** Prohibido commitear directo a `main`. Cada issue se resuelve en una rama aislada (`feat/nombre`, `fix/issue-id`) mediante commits atómicos convencionales (`feat:`, `fix:`, `chore:`).

---

## 3. GitHub Actions y Automatización CI/CD

El pipeline de Integración Continua (CI) actúa como el control de calidad implacable antes del despliegue:

- **Validación Estática:** Linter, formateo y type-checking de TypeScript en cada push y PR.
- **Smoke Tests E2E:** Pruebas de extremo a extremo automatizadas con Playwright headless (ej. 91 pruebas en producción para flujos críticos de usuario).
- **Scheduled Workflows:** Acciones cron que se ejecutan automáticamente cada 24 horas para enviar recordatorios y alertas por correo a postulantes o clientes.

---

## 🎯 Ejercicio práctico

Configura un flujo profesional de trabajo aislado conectando un issue remoto con tu desarrollo local:

1. **Crear y vincular un issue mediante GitHub CLI:**
   ```bash
   gh issue create --title "feat: implementar autenticación OAuth" --body "Epic: Auth V1. Requiere login con Google y persistencia de sesión." --label "enhancement,priority: high"
   ```

2. **Crear y moverte a una rama de trabajo atómica:**
   ```bash
   git checkout -b feat/oauth-google
   ```

3. **Hacer cambios, validar con git diff y registrar commit atómico:**
   ```bash
   git add src/auth/
   git commit -m "feat(auth): agregar proveedor Google OAuth y middleware de sesion"
   ```

4. **Publicar la rama y abrir Pull Request vinculado al issue:**
   ```bash
   git push -u origin feat/oauth-google
   gh pr create --title "feat: integracion Google OAuth" --body "Resuelve issue #1. Implementa flujo OAuth y tipos correspondientes."
   ```

---

## 💡 Tip
> **Ultra Review con Claude Code antes de abrir PR:** Antes de enviar tu código a revisión humana o merge, pídele a Claude Code: `Haz un ultra review técnico exhaustivo de los cambios en esta rama comparado con main, buscando memory leaks, problemas de concurrencia y edge cases`. Resuelve todas las observaciones localmente para garantizar un merge limpio.

---

## ⚠️ Error común
> **Commitear credenciales o confiar ciegamente en extensiones:** Subir variables `.env` a GitHub expone API keys a scrapers automatizados en minutos. Nunca confíes en que un repo privado compensa malas prácticas de seguridad: usa siempre `.gitignore`, gestiona variables en la plataforma de despliegue (ej. Vercel con flags sensibles) y desconfía de extensiones no oficiales de VS Code, que son el principal vector de robo de tokens.
