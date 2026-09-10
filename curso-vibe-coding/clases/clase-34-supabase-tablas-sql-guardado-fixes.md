# Clase 34 — Supabase Real: Creación de Tablas SQL, Guardado y Fixes de UI

**Tags:** `Supabase` `SQL` `Antigravity` `Troubleshooting`
**Conecta con:** [Clase 08](clase-08-ux-seguridad.md) · [Clase 30](clase-30-supabase-mcp-conexiones-antigravity.md) · [Clase 33](clase-33-clonar-repo-plan-desarrollo-local-fixes.md)

---

## Idea central

La conexión práctica de una base de datos en un MVP requiere distinguir entre los permisos de lectura del MCP y las operaciones de administración estructural. Ante las restricciones de permisos para ejecutar DDL desde el agente en Antigravity, la vía más robusta consiste en aplicar el esquema mediante el SQL Editor de Supabase y articular el guardado real de clientes y diagnósticos resolviendo inconsistencias de fallback, botones desvinculados y legibilidad de contraste en modo oscuro mediante auditoría visual asistida.

---

## 1. Troubleshooting de Permisos: MCP vs. SQL Editor

Al intentar crear la estructura de datos directamente desde el chat de Antigravity mediante el MCP de Supabase, suele arrojarse un error de *no autorizado*:

- **Origen del Error:** El servidor MCP utiliza credenciales de contexto que frecuentemente carecen de privilegios DDL (*Data Definition Language*) para alterar esquemas en el motor PostgreSQL remoto.
- **Tipos de Llaves en Supabase:**
  - *Personal Access Token (Account Preferences):* Token de usuario con caducidad para autorizar herramientas externas.
  - *Publishable Key / Anon Key:* Llave cliente para interactuar con la API pública, restringida por Row Level Security (RLS).
  - *Legacy Anon Key:* Credencial de proyecto utilizada en entornos de prueba para solventar incompatibilidades de autenticación local (nunca exponer en producción ni versionar en GitHub).
- **Vía Rápida Operativa:** Se solicita al agente redactar el script DDL íntegro, se copia el bloque, se abre el *SQL Editor* en el panel de Supabase y se ejecuta manualmente para instanciar las tablas de inmediato.

---

## 2. Esquema Relacional del MVP en Supabase

El esquema SQL define la persistencia de las entidades nucleares requeridas por el wizard de diagnósticos:

| Tabla | Propósito en el Negocio | Campos Clave |
| :--- | :--- | :--- |
| `clients` | Almacenar datos de la empresa y contacto | `id` (UUID), `name`, `company`, `industry`, `created_at` |
| `diagnostics` | Registrar respuestas y transcripciones de audio | `id` (UUID), `client_id` (FK), `tools_used`, `pain_points`, `audio_url` |
| `quotes` | Cuantificar horas de automatización y precios | `id` (UUID), `diagnostic_id` (FK), `token` (público), `services`, `total_price` |

Tras ejecutar el script, se valida en *Table Editor* la creación de las tablas y se pide al agente en Antigravity realizar una consulta de verificación (*quick scan*) para sincronizar el estado del backend.

---

## 3. Resolución de Bugs Críticos en el Flujo de Producto

Con el backend operativo, la prueba de humo del wizard revela fallos funcionales y de renderizado que deben subsanarse:

1. **Error de Enlace Compartible ("No hay diagnóstico guardado"):**
   - *Causa:* La función de generación de link público intentaba enlazar el reporte buscando al cliente por correo electrónico, pero el formulario inicial no solicitaba dicho campo.
   - *Solución:* El agente implementa un mecanismo de fallback: si no existe correo, utiliza el nombre de la empresa como identificador único para persistir el registro antes de emitir la URL compartible.
2. **Navegación Rota en Botón "Editar":**
   - *Causa:* El elemento de interfaz carecía de manejador de eventos o ruta asignada.
   - *Solución:* Se vincula el botón a la vista de edición del diagnóstico permitiendo alterar las recomendaciones generadas.
3. **Contraste Ilegible en Modo Oscuro:**
   - *Causa:* Clases con colores fijos en títulos, inputs y barras de progreso del wizard.
   - *Solución:* El agente lanza el navegador controlado, captura evidencias visuales de los pasos del formulario y sustituye los colores estáticos por variables semánticas de Tailwind.

---

## 🎯 Ejercicio práctico

Ejecutar el esquema SQL en Supabase y verificar el guardado persistente del diagnóstico.

**Ejercicio 1:** Solicita al agente en Antigravity el código SQL para crear las tablas `clients`, `diagnostics` y `quotes`. Abre el panel de Supabase, ejecuta el script en el *SQL Editor* y confirma su presencia en el *Table Editor*. En tu app local, completa un diagnóstico completo, genera la propuesta pública y comprueba que se haya generado el enlace compartible y que el registro aparezca reflejado en las filas de Supabase.

**Ejercicio 2 (avanzado, opcional):** Activa el modo oscuro en el wizard de la app e interactúa con los selectores de industria. Si algún texto no contrasta adecuadamente, pide al agente que lance la herramienta de navegador para capturar el componente y corregir la clase semántica de color.

---

## 💡 Tip

No pierdas tiempo depurando configuraciones complejas de permisos para que un MCP cree tablas de base de datos en fases de prototipado. Pide al agente que te entregue el bloque SQL con las sentencias `CREATE TABLE IF NOT EXISTS`, pégalo en el *SQL Editor* de Supabase y ejecútalo con un solo clic. Deja las operaciones del MCP para lectura, inserción y auditoría de datos en tiempo de ejecución.

---

## ⚠️ Error común

Asumir que porque una maqueta muestra datos en pantalla, estos ya están persistidos en la base de datos. Si la lógica del frontend no maneja *fallbacks* para campos opcionales (como asumir que siempre habrá un email de contacto), las operaciones de guardado fallarán en silencio impidiendo generar enlaces compartibles o cotizaciones.

---
