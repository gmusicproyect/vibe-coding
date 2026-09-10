# Transcripción Traducida: Vulnerabilidades y Seguridad en Clawdbot / OpenClaw

> **Fuente original:** [Video sobre vulnerabilidades de Clawdbot (YouTube)](https://youtu.be/rPAKq2oQVBs)  
> **Traducción y sincronización temporal:** Español neutro con preservación de marcas de tiempo y capítulos.  
> **Relacionado con:** [Clase 26 — Cómo Proteger OpenClaw en un VPS con Tailscale](../../curso-vibe-coding/clases/clase-26-proteger-openclaw-vps-tailscale.md) y [Skill Proteger VPS OpenClaw con Tailscale](../../skills/proteger-vps-openclaw-tailscale/SKILL.md)

---

## Capítulo 2: La Catástrofe de Clawdbot

**0:00** — Bueno, considerando que no he tenido suficiente drama en los últimos días, esta mañana temprano decidí revisar el descarrilamiento que ha sido Clawdbot. Y lo que encontré casi me hace saltar de la piel.

**0:08** — La situación está muy mal, amigos. Tenemos personas siendo baneadas permanentemente de Claude, otros creando sus propias skills para Clawdbot en Claude Hub obteniendo acceso root al panel de control de los usuarios.

**0:16** — Y en general, probablemente entre varios cientos y quizás un par de miles de instancias de Clawdbot han sido hackeadas hasta ahora.

**0:25** — Para quienes no estén al tanto, esto es básicamente la "Boda Roja" del vibe coding ocurriendo en tiempo real. Presten atención a esto.

**0:32** — Para correr Clawdbot en un VPS (que es como la mayoría de los que no están gastando dinero en Mac Minis a diestra y siniestra lo están haciendo), básicamente tienes que exponerlo en una URL públicamente disponible.

**0:43** — Bueno, resulta que existen servicios allá afuera como Shodan y otros que están constantemente escaneando y rastreando cada dirección URL disponible en todo internet. Las indexan y luego las agregan a una base de datos pública.

**0:51** — Ahora bien, cuando te registras o instalas Clawdbot, te entrega un panel de control de Claude que básicamente te permite hablar con Clawdbot en esta interfaz web, obtener una vista general, ver todos los canales, instancias, sesiones, cron jobs y más.

**1:00** — Y algunas personas personalizan este panel hasta el extremo.

**1:06** — Lo insólito es que si buscas en una de estas bases de datos indexadas públicas un fragmento de texto que aparece en cada una de estas páginas de control de Clawdbot (que son simplemente las palabras "Clawbot" y luego "control"), obtienes una lista de miles de servidores que están corriendo actualmente y a los que puedes acceder literalmente haciendo un solo clic.

**1:15** — Esta de aquí es la página de alguien. Escogí una segura porque, como ven aquí, dice "dispositivo desconectado, se requiere identidad". En realidad no me permite chatear con él.

**1:24** — Además hice esto porque no quiero ser demandado por tener las credenciales de API de otra persona.

**1:31** — Pero resulta que, como descubrió este tipo muy inteligente llamado Jameson, si estos servidores utilizan una herramienta llamada Nginx como proxy inverso (reverse proxy)...

**1:37** — Debido a una peculiaridad en cómo funciona Nginx y cómo se comunica con Clawdbot, obtienes acceso total a la página de control de Clawdbot de cualquiera.

**1:44** — Lo que significa que no solo podrás leer en su totalidad todos los mensajes enviados hacia y desde esta persona...

**1:51** — También obtienes acceso a todas sus skills, toda la información de configuración y todas sus API keys.

**1:59** — Para cualquiera que me conozca, no soy precisamente la persona más obsesionada con la seguridad en la Tierra. Probablemente soy tan descuidado con mis API keys como cualquiera.

**2:06** — Pero la razón por la que esto es un problema tan gigantesco es por la forma en que la mayoría de la gente está usando Clawdbot: suben todas sus API keys, todos sus tokens y todos sus secretos de todas sus plataformas de mensajería y servicios como Anthropic, etcétera.

**2:14** — Y con eso, tienes acceso a la vida entera de esa persona.

**2:22** — Este tipo de aquí, Jameson, es lo que consideraríamos un hacker de sombrero blanco (white hat). Y lo que hizo, porque es muy bueno, fue revisar y encontrar la información de alguien aquí: supuestamente un ingeniero de sistemas de IA.

**2:30** — Lo identificó completamente y además obtuvo todo su historial de mensajes. Ciertamente espero que no haya hecho nada malicioso con esa información, porque Dios sabe qué haría la gente con mi historial de mensajes.

**2:39** — Pero este es solo uno de potencialmente varios cientos de ejemplos de vulnerabilidades en Clawdbot que están ocurriendo ahora mismo.

**2:48** — Tenemos cientos de expertos en ciberseguridad lamentando lo grave que es realmente la situación alrededor de Clawdbot.

**2:55** — Y también tenemos situaciones obvias donde alguien le da acceso root a Clawdbot y el agente se descontrola por completo en el sistema operativo.

---

## Capítulo 3: Riesgos de Seguridad al Descubierto

**3:02** — Entonces, ¿por qué estoy haciendo este video? ¿Es solo para criticar el progreso de alguien que genuinamente ha puesto mucho esfuerzo y trabajo duro en crear un producto para que otros lo usen? No, por supuesto que no.

**3:10** — Pero basta decir que actualmente las cosas no van bien.

**3:18** — Así que lo que me gustaría hacer es mostrarles varias formas en las que pueden salir ganando. Si van a usar este producto, más vale que lo hagamos de forma segura. Este es un aviso de utilidad pública.

---

## Capítulo 4: Mejores Prácticas de Protección

**3:24** — Si vas a configurar esto en un VPS, lo primero que necesitas hacer es blindar tu infraestructura. ¿Cuál es el mayor problema con la infraestructura en este momento? Hay dos o tres puntos clave.

**3:32** — El primero es que el puerto número uno más utilizado en este momento para acceder al control de Clawdbot es el puerto 18789.

**3:40** — El problema de usar este puerto es que es el puerto por defecto. Cuando usas el puerto por defecto en cualquier aplicación que configuras, permites que actores maliciosos que están escaneando cientos de miles de sitios web al mismo tiempo revisen rápidamente una lista corta de puertos de alta probabilidad para ver si están abiertos.

**3:50** — Lo que significa que servicios como Shodan y cualquiera que tenga una conexión de API allí podrán detectarte en el primer barrido.

**3:58** — Si no estás en esa lista de puertos comunes, tu riesgo baja radicalmente. Lo mismo ocurre con los sospechosos de siempre: 443, 80, 8080, 3000.

**4:05** — Elige un generador de números aleatorios, tira unos dados y configura el sistema para usar un puerto alternativo. ¿No sabes de qué demonios estoy hablando? No te preocupes. Dale acceso a Claude Code a tu servidor y pídele: *"Quiero que elijas un puerto no tradicional, por ejemplo el puerto 44892"*.

**4:13** — El segundo punto es: ¡establece tus contraseñas! No las dejes vacías. Servicios como Shodan están escaneando constantemente todas las puertas de enlace públicas. Si pueden acceder a tu panel de control de Clawdbot y no tienes contraseña configurada, estás acabado. La mayoría tiene contraseña por defecto, pero debo señalarlo.

**4:21** — Lo siguiente es actualizar Clawdbot a la versión más reciente disponible. Idealmente esto no causará cambios disruptivos (breaking changes), y solucionará uno de los errores más graves: el problema del proxy inverso con Nginx que mencioné antes.

**4:28** — El problema es que todos están auto-hospedando esto por su cuenta, por lo que no hay actualizaciones automáticas; tienes que hacerlo manualmente.

**4:36** — Si no has actualizado, asegúrate de configurar `gateway.trustedProxies`, especialmente si estás corriendo detrás de Nginx o Caddy.

**4:44** — La razón es que si no configuras `gateway.trustedProxies`, el panel de control de Clawdbot tratará a cualquiera que acceda a esa URL como si viniera desde `localhost`. En términos sencillos: abrirá sus puertas de par en par a cualquiera que entre.

**4:56** — Realmente, si quieres blindar esto a nivel de infraestructura de forma absoluta, debes usar **Tailscale** o una VPN privada. Nuevamente, pídele a Claude Code que te lo configure si no quieres hacerlo manualmente.

**5:04** — Por último: si eres como yo o cualquiera de las decenas de miles de personas que configuraron esto en los últimos 3 días pensando *"voy a terminar el año millonario porque Clawdbot investigará Twitter por mí"*, y expusiste Clawdbot en una URL pública: **ve de inmediato a todos tus servicios y rota todas tus API keys**.

**5:12** — La rotación de llaves es una función que ofrecen casi todos los servicios de renombre y te permite cambiar tus API keys tras haberlas filtrado a todo internet.

---

## Capítulo 5: Vulnerabilidades en la Cadena de Suministro (Supply Chain)

**5:20** — El otro gran vector de ataque ocurre en la llamada **cadena de suministro (supply chain)**: el ecosistema de skills y herramientas que la gente usa para agregar funcionalidad a sus instancias de Clawdbot.

**5:28** — Muchos conocen Claude Hub (que acaban de renombrar a MoltHub). Hay miles de complementos: chat web, notificaciones de audio, árboles de decisión, etcétera.

**5:36** — El problema con estos repositorios es que no son seguros por defecto. Alguien levantó el sitio, se hizo popular rápidamente, pero no hay nada que impida que un atacante suba una skill con instrucciones maliciosas para que tu agente envíe todas tus API keys a un servidor externo.

**5:46** — Y eso fue exactamente lo que hizo Jameson: construyó una skill simulada con puerta trasera (backdoor) para Claude Hub.

**5:55** — Luego infló artificialmente su conteo de descargas a más de 4.000. Como es un servicio nuevo, MoltHub clasifica las skills basándose únicamente en el número de descargas por unidad de tiempo; un algoritmo extremadamente ingenuo.

**6:03** — Con eso, la skill apareció destacada en la página principal. Cuando usuarios desprevenidos entraban, veían una skill popular y la descargaban.

**6:10** — Jameson es un investigador ético y no utilizó esas llaves para fines dañinos, pero demuestra que ninguno de estos directorios es seguro hasta que sea validado por fuentes confiables independientes.

**6:18** — No puedes confiar ciegamente en el conteo de descargas. Cualquiera con Claude Code puede montar un clon de MoltHub, posicionarlo con SEO y hacer que miles de personas descarguen código malicioso.

**6:25** — Cuando trabajamos con agentes autónomos, estos tienen mucha más autonomía y permisos de acceso al sistema. Necesitamos estar completamente seguros de la legitimidad de lo que instalamos.

**6:34** — ¿Cómo verificarlo? Cruza referencias en redes sociales, revisa si personas de confianza están hablando de esa herramienta.

---

## Capítulo 6: Garantizando Descargas Seguras

**6:42** — Lo siguiente agrega fricción, pero es vital: **lee cada archivo de una skill antes de ejecutarla**. No te limites a leer el archivo principal `SKILL.md`.

**6:51** — Mejor aún: pásale todos los archivos de la skill a una sesión limpia de Claude, Gemini, ChatGPT o Codex y pídele que audite si la skill hace exactamente lo que dice hacer o si oculta exfiltración de credenciales.

**6:58** — Si hay información del autor, verifica si tiene reputación real, rostro público y una cuenta de GitHub vinculada con historial verificado de commits.

**7:06** — Los desarrolladores que ponen su nombre real y tienen trayectoria no quieren arriesgar su reputación publicando fraudes o software malicioso.

**7:13** — Para la comunidad de desarrolladores: traten a Claude Hub / MoltHub como el ecosistema inicial de npm. Asuman que nada está auditado y que cualquier paquete no verificado puede contener código malicioso.

**7:21** — Aunque esto agregue fricción a tu flujo de trabajo, garantizará que no formes parte de la lista de miles de servidores comprometidos.

---

## Capítulo 7: Conclusiones Finales sobre Clawdbot

**7:30** — Me encanta esta tecnología, pero en este momento no confiaría todas mis API keys a una instancia expuesta de Clawdbot.

**7:39** — Espero que entiendan la gravedad del mensaje. Mucha suerte protegiendo sus agentes.
