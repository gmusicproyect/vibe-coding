# Clase 06 — Nueva Ley de Datos: aplica aunque no vivas en Chile

**Tags:** `Privacidad` `Ley 21.719` `RGPD` `Compliance`
**Conecta con:** [Clase 01](clase-01-stack-vibe-coding.md) · [Clase 04](clase-04-adversarial-review.md) · [Clase 05](clase-05-gohighlevel.md)

---

## Idea central

La nueva Ley de Protección de Datos Personales (Ley 21.719 de Chile, homologada al RGPD europeo) sanciona con multas de hasta 20.000 UTM (~1.5M USD) o el 4% de la facturación global a cualquier aplicación que procese datos de usuarios en territorio chileno, incluso si operas desde el extranjero o tu servicio es gratuito. Subcontratar a terceros no elimina tu responsabilidad; el cumplimiento no es un documento estático, sino una arquitectura técnica verificable desde el esquema de base de datos hasta los endpoints de derechos ARCO+.

---

## Mapeo técnico: De los artículos de la ley al código

| Artículos | Requisito legal | Implementación técnica en el repositorio |
|-----------|-----------------|------------------------------------------|
| **Art. 13 y 14 Quater** | Minimización y proporcionalidad | Esquema de BD y formularios limitados a lo estrictamente indispensable. |
| **Art. 14 ter** | Consentimiento explícito | Tabla de logs con `user_id`, `terms_version`, `timestamp` y dirección IP. |
| **Art. 5 al 9** | Derechos ARCO+ (30 días / 2 días) | Endpoints para exportar (JSON), rectificar, bloquear y borrar datos. |
| **Art. 14 Quinquies** | Seguridad y resguardo | Row Level Security (RLS) en BD, cifrado en reposo y backups auditados. |
| **Art. 15 bis, 27-29** | Terceros y transferencias | Inventario de proveedores (evitar proxies como OpenRouter que reentrenen data). |
| **Art. 8 bis y 15 ter** | Fin de cajas negras y EIPD | Explicabilidad algorítmica, soporte humano obligatorio y evaluación previa. |

### Las 3 preguntas de control antes de capturar cualquier dato

Antes de añadir una columna a tu base de datos o un input a un formulario:
1. **¿Para qué se pide?** Debe responder a una necesidad funcional inmediata del producto.
2. **¿Con qué base legal?** Debe sustentarse en ejecución contractual o consentimiento expreso documentado.
3. **¿Es indispensable?** Si el sistema puede operar sin ese dato, pedirlo es una infracción legal sujeta a sanción.

> **Regla de oro de ingeniería:** *"Si el dato no cambia lo que el sistema hace o necesita, ese dato no se pide ni se guarda"*.

---

## Los 6 derechos del titular y la trampa del borrado falso

1. **Acceso:** Descarga completa de los datos personales en formato electrónico estructurado.
2. **Rectificación:** Modificación inmediata de datos inexactos o desactualizados.
3. **Supresión (Borrado real):** Borrar físicamente el registro en la BD (o anonimizarlo de forma irreversible). Un flag `status: deleted` o un mensaje visual en la UI que mantiene los datos en la tabla infringe gravemente la ley.
4. **Oposición:** Desactivar tratamientos secundarios (marketing, perfilamiento publicitario).
5. **Portabilidad:** Exportar el historial en formato estándar (JSON/CSV) para migrar a otro servicio.
6. **Bloqueo temporal:** Congelar el uso de datos en un plazo máximo de **2 días** mientras se resuelve una disputa (frente a los **30 días** del plazo general).

---

## Supervisión humana obligatoria y evaluación de impacto (EIPD)

El Artículo 8 bis prohíbe decisiones 100% automatizadas con efectos jurídicos significativos (scoring crediticio, despidos, filtrado de currículums o admisiones):
- **Vía de escape humana obligatoria:** Toda decisión negativa tomada por un LLM o algoritmo debe ofrecer un botón directo para apelar y ser evaluado por una persona real.
- **Transparencia algorítmica:** Debes documentar en lenguaje no técnico los factores y ponderaciones del modelo. Decir *"lo decidió la IA"* no constituye defensa legal.
- **Los 5 factores de la EIPD previa:** Obligatoria antes de salir a producción al perfilar o tratar datos sensibles: (1) descripción del flujo técnico, (2) finalidad legítima, (3) juicio de necesidad, (4) matriz de riesgos de filtración y (5) controles de mitigación implementados.

---

## 🎯 Ejercicio práctico

**Ejercicio 1 (Auditoría de minimización y borrado real):**
1. Abre el esquema de tu base de datos (ej. `schema.prisma`, migraciones SQL o tablas de Supabase) y lista cada columna de la tabla `usuarios` o `clientes`.
2. Identifica cualquier campo no indispensable para la transacción básica (ej. RUT/DNI, geolocalización o género en servicios generales) y genera una migración para eliminarlo.
3. Prueba tu endpoint de eliminación de cuenta: crea un usuario de test, invoca la acción de borrado y ejecuta un `SELECT * FROM usuarios WHERE id = 'test_id';` confirmando que la información personal ya no reside en el servidor.

**Ejercicio 2 (avanzado):** Instala el skill de auditoría `revisar-datos-personales` en tu agente de Claude Code y córrelo sobre el proyecto. Analiza el reporte de 19 campos e identifica qué variables sensibles carecen de consentimiento explícito en el flujo de registro.

---

## 💡 Tip

Cuando audites cumplimiento en tu repositorio, no le preguntes a tu propio agente *"¿este código cumple la ley?"*, porque confirmará su propio trabajo con complacencia. Pídele que genere un inventario estricto: archivo y número de línea exacto donde se captura cada dato, base legal que lo justifica y endpoint exacto que ejecuta su eliminación.

---

## ⚠️ Error común

Creer que la responsabilidad recae en el proveedor de nube o API que subcontrataste (Supabase, Vercel o proveedores de LLMs). Si tu proveedor sufre una filtración o usa los datos para entrenar modelos sin autorización expresa (como ocurre con ciertos enrutadores multi-modelo), la sanción administrativa y las demandas civiles recaen directamente sobre tu empresa por ser el responsable primario ante el usuario.
