# Clase 08 — UX + Seguridad en Web Apps con IA

**Tags:** `UX` `Seguridad OWASP` `Supabase RLS` `Web Apps`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 04](clase-04-adversarial-review.md) · [Clase 07](clase-07-ui-tokens.md)

---

## Idea central

La inteligencia artificial programa por defecto para el "Happy Path": asume que todo sale bien, que los datos cargan rápido y que el usuario nunca se equivoca. Sin embargo, un producto listo para producción exige diseñar los cuatro estados de cada pantalla (Loading, Empty, Error y Success), aplicar reglas de UX que reduzcan la fricción (validación inline y la Ley de Jacob) y blindar la aplicación contra ataques mediante los pilares de OWASP: Row Level Security (RLS) activo en Supabase, verificación de permisos exclusivamente en el servidor y sanitización total de errores para no regalar información arquitectónica a un atacante.

---

## Filosofía de UX: La culpa nunca es del usuario

El diseño centrado en el humano nació en 1943 cuando los bombarderos B-17 se estrellaban en el aterrizaje porque las palancas del tren de aterrizaje y de los flaps eran idénticas y estaban contiguas. Alphonse Chapanis demostró que no era error del piloto, sino error de diseño, y lo resolvió con *shape coding* (una rueda de goma en una palanca y una cuña en la otra):

- **Puertas Norman (Don Norman, 1988):** *"Si una puerta necesita un letrero de empuje o jale, el diseño ya falló"*. Si tu interfaz requiere explicaciones obvias, el flujo debe rediseñarse.
- **Ley de Jacob (Jacob Nielsen, 2000):** Los usuarios pasan el 90% de su tiempo en otras aplicaciones; esperan que la tuya funcione con los mismos patrones conocidos. En escritorio el carrito de compras va arriba a la derecha; en móvil, en la barra de navegación inferior. Innovar en la ubicación de convenciones estándar no es creatividad: es fricción innecesaria.

---

## Los 4 estados obligatorios de toda pantalla

La IA suele construir únicamente el estado exitoso. Es obligatorio exigir y validar los cuatro estados antes de considerar terminada cualquier vista:

| Estado | Cuándo aplica | Implementación técnica requerida |
|--------|---------------|----------------------------------|
| **1. Loading** | Datos en tránsito | Skeletons que reflejen el layout real (para páginas grandes); spinner inline para 2-5s; barra de progreso para >10s; jamás spinner si tarda <1s. |
| **2. Empty** | Cero registros o búsqueda vacía | Mensaje explicativo con acción primaria inmediata (*"Aún no tienes proyectos. Crea tu primer proyecto"*), nunca pantalla blanca. |
| **3. Error** | Fallo de conexión, API o lógica | 3 elementos obligatorios: qué pasó, por qué pasó y botón de reintento/acción (*"Tu tarjeta fue rechazada. Revisa los datos o usa otro método"*). |
| **4. Success** | Acción confirmada | Feedback visual inmediato (toast temporal, confetti o vibración háptica) para dar certeza al usuario. |

> **Graceful Degradation:** Cada componente de la vista debe cargar y fallar de manera independiente. Si el feed de noticias falla, el menú lateral y el panel de usuario deben permanecer 100% operativos.

---

## 6 Reglas para formularios sin fricción

1. **Validación inline al desenfocar (`onBlur`):** Avisa al instante si un email es inválido; no esperes a que el usuario complete todo el formulario y presione Enviar.
2. **Requisitos de contraseña visibles:** Muestra la lista de condiciones (mínimo 8 caracteres, mayúscula, número) tachándose en tiempo real mientras teclea.
3. **Botón deshabilitado con opacidad:** Mantén el botón visible pero inactivo hasta que los campos obligatorios cumplan las validaciones.
4. **Contador de caracteres:** Si existe un límite en un campo de texto, muestra el saldo restante en tiempo real.
5. **Autocompletado de datos conocidos:** Si el usuario ya inició sesión, no le vuelvas a pedir su correo o nombre en formularios internos.
6. **Tolerancia de formatos:** Permite números telefónicos con o sin espacios, paréntesis o guiones; procesa la limpieza en el código.

---

## Seguridad defensiva: Los 7 pilares OWASP en Vibe Coding

Un mal manejo de errores no es solo mala UX: es un agujero crítico de seguridad. El caso de McDonald's (panel de contratación protegido con `123456` e IDs secuenciales sin validar) expuso millones de postulantes por ignorar los principios básicos:

1. **Row Level Security (RLS) en Supabase:** Por defecto viene apagado. Debe encenderse en **todas las tablas** con políticas (`auth.uid() = user_id`). Sin RLS, cualquiera con la API key pública de Supabase puede descargar la base de datos completa mediante un simple `curl`.
2. **Nunca confíes en el cliente:** Un redirect en React/Next.js (`if (!user) router.push('/login')`) no protege nada; un atacante dispara peticiones vía terminal sin ejecutar tu JavaScript. La autenticación y autorización se validan en el servidor en cada endpoint o Server Action.
3. **Errores sanitizados:** Jamás expongas errores crudos del motor de base de datos (`internal server error`, nombres de tablas o rutas de archivos). Devuelve mensajes neutros al usuario y envía el stack trace detallado a herramientas de monitoreo como Sentry.
4. **Secretos en `.env`:** Las API keys solo existen en el servidor; nunca en el frontend ni pegadas en el chat del agente.
5. **Validación estricta de inputs:** Trata todo input entrante como hostil; valida y sanitiza esquemas en el backend (ej. con Zod).
6. **Rate Limiting (Límites por IP/Usuario):** Configura límites de peticiones (ej. con Upstash) en endpoints de IA y especialmente en rutas de login/registro para bloquear ataques de fuerza bruta y enumeración de cuentas.
7. **Paginación obligatoria:** Nunca ejecutes `SELECT *` de miles de filas para mostrar 5 elementos; aplica paginación desde la base de datos.

---

## 🎯 Ejercicio práctico

**Ejercicio 1 (Auditoría de los 4 estados en una vista):**
1. Abre una vista de tu aplicación (ej. lista de tareas, clientes o productos) e introduce un retraso artificial de 3 segundos en el fetch de datos para verificar que renderice un skeleton representativo y no un spinner genérico.
2. Limpia la base de datos de esa entidad y comprueba que muestre un estado vacío con botón de acción (*"Crear nuevo..."*).
3. Fuerza un error de red y verifica que la interfaz muestre el mensaje explicativo con un botón funcional de reintentar.

**Ejercicio 2 (Auditoría de RLS y fuga de datos):**
Abre tu terminal y ejecuta una petición `curl` directa al endpoint REST de Supabase de tu proyecto sin cabecera de autenticación. Verifica que la respuesta devuelva `0` filas. Si devuelve datos, activa inmediatamente RLS en la tabla desde el panel de Supabase y añade la política restrictiva de lectura.

---

## 💡 Tip

Antes de enviar cualquier proyecto a producción, abre la consola del navegador (`F12` o clic derecho → Inspeccionar → Consola) y realiza un recorrido completo. Elimina cualquier `console.log` o mensaje de depuración que exponga rutas internas, nombres de tablas o tokens.

---

## ⚠️ Error común

Creer que tu aplicación es segura porque el botón de eliminar o el panel administrativo están ocultos en la interfaz visual. Cualquier atacante puede inspeccionar el código del frontend, encontrar la URL del endpoint y enviar peticiones directas. Si el backend no valida la sesión y los permisos fila por fila, ejecutará la acción sin importar la interfaz.
