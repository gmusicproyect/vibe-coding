# SKILL: Gestionar Flujo de Ramas e Integración en GitHub

> Guarda este archivo en `/skills/gestionar-flujo-ramas-github/SKILL.md`
> y referencíalo en tu CLAUDE.md para que Claude Code lo use.

---

## Cuándo usar este skill

Cuando se requiera implementar nuevas funcionalidades, corregir bugs o refactorizar código en proyectos colaborativos o asistidos por agentes, aislando el trabajo en ramas atómicas, asociándolo a issues y abriendo Pull Requests listos para revisión y validación CI/CD, sin tocar directamente la rama principal (`main`).

---

## Prerequisitos

- [ ] Git instalado y configurado (`git --version`, `user.name`, `user.email`)
- [ ] GitHub CLI (`gh`) instalado y autenticado (`gh auth status`)
- [ ] Repositorio alojado en directorio local nativo (nunca dentro de Google Drive, Dropbox, iCloud o OneDrive)
- [ ] Archivo `.gitignore` configurado protegiendo secretos (`.env*`, credenciales) y dependencias (`node_modules/`)
- [ ] Rama remota sincronizada (`git fetch origin`)

---

## Pasos

### Paso 1 — Crear o auditar el Issue atómico

Todo cambio debe nacer de un requerimiento claro vinculado a un Epic. Utiliza GitHub CLI para documentarlo:

```bash
gh issue create   --title "feat(auth): soporte para login con Google OAuth"   --body "Epic: Auth V1. Implementar proveedor OAuth, middleware de sesion y pruebas unitarias."   --label "enhancement,priority: high"
```

Apunta el número del issue generado (ej. `#42`).

### Paso 2 — Crear y sincronizar la rama atómica de trabajo

Actualiza tu rama principal local y bifurca una nueva rama con nomenclatura estandarizada (`feat/`, `fix/`, `chore/`):

```bash
git checkout main
git pull origin main
git checkout -b feat/oauth-google-42
```

### Paso 3 — Implementar cambios y registrar commits convencionales

Trabaja en los archivos correspondientes. Mantén los commits pequeños, atómicos y descriptivos:

```bash
# Revisar el estado y las diferencias exactas
git status
git diff

# Agregar archivos puntuales (evita git add .)
git add src/lib/auth.ts src/routes/auth.ts

# Registrar commit convencional
git commit -m "feat(auth): agregar cliente OAuth y persistencia de cookies"
```

### Paso 4 — Ultra Review con Claude Code antes de push

Antes de publicar los cambios, ejecuta una auditoría técnica profunda local para detectar regresiones o problemas de concurrencia:

```bash
claude -p "Haz un ultra review técnico exhaustivo de los cambios en esta rama comparado con main, buscando memory leaks, problemas de concurrencia y edge cases. Lista cualquier observación antes de abrir PR."
```

Si hay observaciones, resuélvelas y añade otro commit (`fix(auth): corregir sanitizacion de redirect URI`).

### Paso 5 — Publicar rama y abrir Pull Request

Sube la rama a GitHub y abre el Pull Request vinculando el issue correspondiente para cierre automático:

```bash
# Publicar la rama en el remoto
git push -u origin feat/oauth-google-42

# Crear el Pull Request mediante gh
gh pr create   --title "feat(auth): integrar Google OAuth (#42)"   --body "Resuelve #42. Implementa proveedor OAuth con Google y middleware de sesion. Validado con tests locales."
```

### Paso 6 — Supervisar verificaciones de GitHub Actions

Monitorea la ejecución del pipeline de CI (linters, type-check, tests Playwright):

```bash
gh pr checks
```

---

## Outputs esperados

Al terminar este skill, el resultado debe ser:
- Rama de trabajo aislada y publicada en GitHub sin haber modificado directamente `main`.
- Historial de commits atómico y compatible con Conventional Commits.
- Pull Request creado, documentado y asociado al issue que resuelve.
- Checks de CI/CD ejecutados y validados.

---

## Errores comunes

| Error | Causa probable | Solución |
| :--- | :--- | :--- |
| **Commit accidental en `main`** | No haber creado la rama antes de empezar a codear | Crea la rama en el punto actual (`git checkout -b feat/tarea`), luego regresa a `main` y haz reset suave al commit remoto (`git checkout main && git reset --hard origin/main`). |
| **Repositorio corrompido** | El proyecto está en Google Drive, Dropbox o iCloud | Mueve inmediatamente la carpeta a un directorio local nativo (ej. `~/Developer/proyecto`). |
| **Credenciales expuestas en commit** | Falta de `.env` en `.gitignore` o uso indiscriminado de `git add .` | Remueve el archivo del índice sin borrarlo (`git rm --cached .env`), agrégalo a `.gitignore`, commitea y rota inmediatamente todas las claves comprometidas. |
| **Fallo en checks de CI/CD** | Linter o tests E2E fallando en el runner remoto | Ejecuta `gh pr checks` para ver el fallo, reproduce el script localmente (`npm run lint` o `npx playwright test`), corrige en tu rama y haz push. |

---

## Variaciones

**Variación A — Hotfix urgente en producción:**
Bifurca directamente desde el último tag de producción o rama `main` usando el prefijo `fix/descripcion-breve` y solicita revisión prioritaria mediante label `priority: critical`.

**Variación B — Flujo headless con agente autónomo:**
Si un agente 24/7 (Hermes) ejecuta este flujo, debe pasar el flag `--fill` en `gh pr create` y no solicitar confirmación interactiva TTY en consola.
