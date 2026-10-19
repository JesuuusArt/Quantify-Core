# Práctica 07 — Diagrama de secuencia o navegación de sketches del proyecto integrador

**Proyecto:** Quantify Core<br>
**Universidad:** Universidad Tecnológica de Xicotepec de Juárez<br>
**Cuatrimestre:** 10° · **Grupo:** A

Prototipo interactivo de **Quantify Core** para explorar cómo un usuario gestiona su rutina y cómo un administrador supervisa la operación. La práctica conecta los sketches mediante acciones, validaciones, retornos y confirmaciones, con una misma lógica para móvil y PWA.

| Roles                   | Sketches                                          | Formatos    | Implementación               |
| ----------------------- | ------------------------------------------------- | ----------- | ---------------------------- |
| Usuario y Administrador | 24 pantallas: 15 de usuario y 9 de administración | Móvil y PWA | HTML, CSS y JavaScript puros |

## Vista general del prototipo

![Sketch U01, Bienvenida, en formato móvil: inventario de pantallas a la izquierda, presentación de Quantify Core al centro y conexiones hacia inicio de sesión y registro a la derecha.](./assets/prototipo-hoy.png)

_Captura del sketch U01 — Bienvenida en formato móvil. Corresponde a una versión anterior al ajuste de las ilustraciones y los gráficos a recuadros de sketch._

La vista se organiza en tres áreas:

- **Izquierda · Inventario de sketches:** permite localizar las pantallas del rol seleccionado y abrirlas para su revisión.
- **Centro · Prototipo navegable:** presenta el sketch y sus controles. La pantalla de bienvenida introduce Quantify Core y permite comenzar el registro o acceder a una cuenta existente.
- **Derecha · Conexiones y reglas:** explica las acciones disponibles, sus destinos y las condiciones que mantienen al usuario en el mismo sketch.

Los selectores superiores permiten cambiar de rol o de formato. **Ver navegación** abre el mapa de transiciones; **Zonas clicables** resalta los controles interactivos.

## 1. Objetivo

Representar y probar la navegación entre los sketches de Quantify Core mediante un prototipo interactivo. Se definen las pantallas, las acciones que las conectan, sus condiciones y las respuestas del sistema para dos roles: **Usuario** y **Administrador**.

Se eligió un **diagrama de navegación entre sketches**. El mapa representa pantallas y transiciones de interfaz; no es un diagrama UML de llamadas entre servicios.

## 2. Abrir el prototipo

Explora **Quantify Core**: recorre sus pantallas o descubre cómo se conectan. Abre cualquiera de las dos experiencias directamente en tu navegador.

| 📱 Vive el prototipo | 🧭 Explora la navegación |
| :---: | :---: |
| Prueba las **24 pantallas**, cambia de rol y alterna entre móvil y PWA. | Consulta el **mapa de recorridos principales** de Usuario y Administrador. |
| [![Abrir prototipo interactivo](./assets/abrir-prototipo.svg)](https://angeljesus13.github.io/Quantify-Core/docs/practica-07/) | [![Ver mapa de navegación](./assets/abrir-navegacion.svg)](https://angeljesus13.github.io/Quantify-Core/docs/practica-07/navegacion.html) |
| [Abrir prototipo ↗](https://angeljesus13.github.io/Quantify-Core/docs/practica-07/) | [Ver navegación ↗](https://angeljesus13.github.io/Quantify-Core/docs/practica-07/navegacion.html) |

> [!TIP]
> **Empieza por el prototipo.** Selecciona un rol y usa los controles del dispositivo para recorrer la demo. Los botones de arriba abren la página publicada en GitHub Pages.

📋 **[Consultar evidencia de validación](./VALIDACION.md)** · Pruebas realizadas y límites de la revisión.

<details>
<summary><strong>💻 Abrir una copia local y consultar la ruta de publicación</strong></summary>

Abrir un archivo `.html` desde la lista de archivos del repositorio en GitHub muestra su código fuente. Para ver la experiencia publicada, utiliza los accesos de arriba.

Para usar una copia descargada, puede abrirse `index.html` directamente en un navegador. Para una vista local con un origen estable para el almacenamiento, ejecutar **desde la raíz del repositorio**:

```sh
python3 -m http.server 8765 --bind 127.0.0.1 --directory docs
```

Después visitar `http://127.0.0.1:8765/practica-07/`.

**Ruta de publicación en GitHub Pages:** [Quantify Core · Práctica 07](https://angeljesus13.github.io/Quantify-Core/docs/practica-07/). La publicación actual sirve el repositorio desde su raíz, por lo que la dirección incluye `/docs/`. El servidor local del comando anterior sirve directamente esa carpeta; por eso su dirección local no incluye `/docs/`.

</details>

### Cómo recorrerlo

1. Elegir **Usuario** o **Administrador**.
2. Usar los botones y formularios del dispositivo para probar el flujo, o el inventario lateral para revisar un sketch directamente.
3. Alternar **Móvil / PWA**: se conserva la pantalla, lo escrito en los formularios y los datos. Cambia la distribución, no las funcionalidades.
4. Activar **Zonas clicables** para identificar controles interactivos.
5. Abrir **Ver navegación**: las flechas muestran las salidas del sketch actual. Las tarjetas detallan todas las conexiones del rol, incluidos retornos y condiciones que permanecen en la misma pantalla.
6. Consultar las reglas en el panel derecho y restablecer los datos con **Restablecer demo** cuando sea necesario.

El inventario lateral y las tarjetas del mapa son herramientas de revisión: permiten saltar directamente a pantallas protegidas para evaluar su diseño. No simulan una autorización de producción.

### Cuentas de ejemplo

| Rol           | Correo                | Contraseña de prueba |
| ------------- | --------------------- | -------------------- |
| Usuario       | `alex@quantify.demo`  | `Demo2026!`          |
| Administrador | `admin@quantify.demo` | `Demo2026!`          |

El código de verificación de registro y recuperación es **`123456`**. Una cuenta nueva debe verificarlo antes de iniciar sesión; si se interrumpe el registro, **Continuar verificación** permite retomarlo desde el acceso. No se envían correos. Una cuenta creada y una contraseña cambiada durante el recorrido solo existen en memoria durante esa visita; las contraseñas no se escriben en el almacenamiento local.

## 3. Dos roles, un recorrido por rol

**Usuario:** gestiona sus hábitos, registra avances parciales o completos, consulta rachas y análisis, configura avisos y decide si incorpora recomendaciones.

**Administrador:** mantiene las plantillas del catálogo, supervisa propuestas de IA, administra el estado de cuentas ficticias y consulta la auditoría. Opera sobre información agregada y no tiene pantallas para consultar o editar rutinas personales.

Cada rol utiliza los mismos sketches en móvil y PWA. **PWA** designa la representación del cliente web adaptable dentro del visor; esta entrega no implementa instalación, manifiesto ni service worker.

## 4. Identidad visual y referencias

Los wireframes compartidos por el equipo orientan el acceso, los formularios de hábitos, el progreso diario, el análisis, IA Coach y los ajustes. Se mejoró la jerarquía visual y se agregó el recorrido administrativo.

Los espacios de imagen, las ilustraciones de acceso y los gráficos se representan con recuadros grises, diagonales y etiquetas entre corchetes, para conservar el aspecto de sketch. El logo, los iconos de los controles, los datos numéricos y la navegación mantienen su función.

| Recurso               | Aplicación                                                    |
| --------------------- | ------------------------------------------------------------- |
| Logo del repositorio  | `../quantifyLogo.jpeg`, usado en el visor y en la aplicación. |
| Azul `#1E54C9`        | Acciones principales, progreso y selección.                   |
| Gris oscuro `#2C3036` | Texto principal, marco móvil y paneles destacados.            |
| Blanco `#FFFFFF`      | Tarjetas y superficies.                                       |
| Fondo `#F1F4F9`       | Área de trabajo del visor.                                    |
| Verde y ámbar         | Estados activos, pausados y confirmaciones.                   |

La interfaz usa tipografías del sistema e iconos SVG locales. No requiere fuentes, librerías ni imágenes de terceros.

## 5. Inventario de sketches

### Usuario — 15 pantallas

| ID  | Sketch                | Función                                                       |
| --- | --------------------- | ------------------------------------------------------------- |
| U01 | Bienvenida            | Presentar la propuesta y elegir acceso o registro.            |
| U02 | Iniciar sesión        | Validar credenciales demo; acceder a registro y recuperación. |
| U03 | Crear cuenta          | Capturar los datos de ejemplo antes de verificar.             |
| U04 | Recuperar acceso      | Iniciar la recuperación simulada.                             |
| U05 | Verificar código      | Resolver el registro o la recuperación según el contexto.     |
| U06 | Hoy / Mis hábitos     | Ver hábitos programados y completar o deshacer el día.        |
| U07 | Crear / editar hábito | Configurar nombre, categoría, meta, días y color.             |
| U08 | Detalle del hábito    | Registrar avances, revisar racha y acceder a edición.         |
| U09 | Recordatorio          | Elegir días y horario de un aviso de ejemplo.                 |
| U10 | Análisis y rachas     | Consultar resultados calculados e historial.                  |
| U11 | IA Coach              | Revisar, personalizar o descartar sugerencias.                |
| U12 | Perfil y ajustes      | Guardar nombre de ejemplo, consentimiento y preferencias.     |
| U13 | Archivar hábito       | Confirmar el retiro de la rutina activa sin borrar historial. |
| U14 | Centro de avisos      | Consultar recordatorios configurados y marcarlos como leídos. |
| U15 | Nueva contraseña      | Finalizar la recuperación verificada.                         |

### Administrador — 9 pantallas

| ID  | Sketch                     | Función                                                        |
| --- | -------------------------- | -------------------------------------------------------------- |
| A01 | Acceso administrador       | Validar la cuenta administrativa demo.                         |
| A02 | Resumen operativo          | Consultar métricas agregadas ilustrativas y accesos a módulos. |
| A03 | Catálogo de hábitos        | Revisar, crear, editar, pausar o reactivar plantillas.         |
| A04 | Editar plantilla           | Validar datos y documentar el motivo de creación o edición.    |
| A05 | Supervisión de IA          | Revisar propuestas y pausarlas o reactivarlas con motivo.      |
| A06 | Auditoría                  | Consultar y filtrar cambios administrativos de la demo.        |
| A07 | Control de accesos         | Revisar el estado de cuentas ficticias por código.             |
| A08 | Configuración global       | Ajustar límites de IA y registrar el motivo.                   |
| A09 | Confirmar cambio de acceso | Suspender o reactivar una cuenta con confirmación.             |

Las confirmaciones de pausa de plantillas e IA son diálogos dentro del sketch correspondiente. Cancelar no aplica cambios ni crea eventos de auditoría.

## 6. Recorridos principales

| Recorrido          | Secuencia                   | Condición o alternativa                              |
| ------------------ | --------------------------- | ---------------------------------------------------- |
| Acceso de usuario  | U01 → U02 → U06             | Credenciales incorrectas mantienen U02 con un error. |
| Registro           | U01 → U03 → U05 → U06       | Datos o código incorrectos mantienen el formulario.  |
| Recuperación       | U02 → U04 → U05 → U15 → U02 | U15 solo guarda después de verificar el código.      |
| Crear hábito       | U06 → U07 → U08             | Guardar valida; cancelar vuelve a U06 sin crear.     |
| Editar hábito      | U08 → U07 → U08             | Se conserva el historial anterior al día de ejemplo. |
| Registrar progreso | U06 → U08 → U08             | El avance parcial actualiza el registro del día.     |
| Recordatorio       | U08 → U09 → U08             | Guardar valida; cancelar no modifica.                |
| Revisar resultados | U06 → U10 → U08             | El periodo cambia sin salir de Análisis.             |
| Incorporar IA      | U06 → U11 → U07 → U08       | Solo guardar crea el hábito; cancelar no acepta.     |
| Archivar hábito    | U08 → U13 → U06             | Cancelar devuelve U08 y conserva el hábito activo.   |
| Catálogo           | A01 → A02 → A03 → A04 → A03 | Los cambios requieren datos válidos y motivo.        |
| Supervisión IA     | A02 → A05 → diálogo → A05   | Pausa o reactivación confirmada genera auditoría.    |
| Cambiar acceso     | A02 → A07 → A09 → A07       | Cuenta actual protegida; motivo obligatorio.         |
| Consultar cambios  | A02 → A06                   | Filtrado local de eventos sin edición ni borrado.    |

La navegación global de cada rol permite volver a sus módulos principales. El mapa integrado contiene el detalle de todas las transiciones definidas en `data.js`.

## 7. Reglas de negocio propuestas

Estas **13 reglas** concretan las decisiones del prototipo y permiten revisar tanto los recorridos correctos como sus alternativas. Para las recomendaciones de IA se establece una confianza mínima del **80%**, que el administrador puede elevar.

| Regla                         | Comportamiento                                                                                                                                                                          |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| RN01 · Alcance por rol        | Usuario opera su rutina. Administración opera catálogo, accesos, auditoría y métricas agregadas.                                                                                        |
| RN02 · Acceso y verificación  | Validación demo de credenciales y código; registro público sin cuentas administrativas.                                                                                                 |
| RN03 · Hábito válido          | Nombre de 3 a 60 caracteres, meta entera de 1 a 100000 y al menos un día. Sin nombres activos duplicados, ignorando acentos y mayúsculas.                                               |
| RN04 · Registro diario único  | Avance por hábito y fecha, limitado a la meta. Completar o deshacer actualiza el mismo registro.                                                                                        |
| RN05 · Rachas y cumplimiento  | La racha considera días programados. El porcentaje diario cuenta hábitos activos programados; el análisis conserva metas y frecuencias históricas al editar.                            |
| RN06 · Archivo con historial  | Confirmación previa; conserva registros, desactiva recordatorios y bloquea nuevas marcas.                                                                                               |
| RN07 · Avisos voluntarios     | Horario válido y días compatibles con la frecuencia. Desactivar avisos no modifica el progreso.                                                                                         |
| RN08 · IA con consentimiento  | Al menos 7 días distintos con registros, consentimiento activo, confianza mínima del 80% y hasta 2 sugerencias pendientes. El administrador puede elevar el umbral o reducir el máximo. |
| RN09 · Aceptación explícita   | Se crea el hábito solo al guardar. Se excluyen hábitos activos y archivados en los últimos 30 días. Descartar oculta la propuesta durante 21 días.                                      |
| RN10 · Catálogo independiente | Pausar o reactivar exige motivo y confirmación. Las futuras propuestas cambian; los hábitos ya creados permanecen intactos.                                                             |
| RN11 · Auditoría              | Cambios administrativos con fecha, actor, entidad, acción y motivo. Sin controles para editar o borrar eventos.                                                                         |
| RN12 · Accesos controlados    | Suspender o reactivar exige motivo; el administrador actual está protegido. Solo se modifica el estado de cuentas ficticias.                                                            |
| RN13 · Paridad de formatos    | Móvil y PWA conservan pantallas, datos, acciones y formularios en curso al alternar el formato.                                                                                         |

Los datos diarios usan la fecha fija **14 de octubre de 2026** para hacer reproducible la demostración. Las rachas y los resultados de usuario se calculan sobre registros locales de ejemplo. Los horarios de auditoría sí corresponden al momento del cambio y se muestran en la zona `America/Mexico_City`.

## 8. Alcance de la simulación

Funciona en el navegador: navegación, formularios, validaciones, creación y edición de hábitos, avances, archivo, análisis, preferencias, filtros, decisiones de IA, gestión de plantillas, estados de cuentas y auditoría. Los datos de ejemplo se conservan en `localStorage` cuando el navegador lo permite.

No incluye backend, autenticación real, envío de correos, notificaciones del dispositivo, sincronización remota ni inferencia real de IA. Las cifras globales del administrador son ilustrativas. La suspensión de una cuenta es un cambio de estado de ejemplo, no una revocación de sesiones reales. La auditoría local puede restablecerse junto con la demo y no tiene las garantías de un registro de producción.

## 9. Archivos entregados

| Archivo                                                | Contenido                                                                |
| ------------------------------------------------------ | ------------------------------------------------------------------------ |
| [index.html · abrir prototipo](https://angeljesus13.github.io/Quantify-Core/docs/practica-07/) | Visor, controles de revisión y diálogos. |
| [styles.css](./styles.css)                             | Identidad visual y distribución adaptable móvil/PWA.                     |
| [data.js](./data.js)                                   | Inventario de 24 sketches, conexiones y 13 reglas.                       |
| [app.js](./app.js)                                     | Pantallas, navegación y lógica de simulación.                            |
| [navegacion.html · abrir diagrama](https://angeljesus13.github.io/Quantify-Core/docs/practica-07/navegacion.html) | Diagrama general independiente generado con Archify. |
| [navegacion.archify.json](./navegacion.archify.json)   | Especificación editable del diagrama general.                            |
| [assets/prototipo-hoy.png](./assets/prototipo-hoy.png) | Captura de U01 — Bienvenida en formato móvil, incluida en este README. |
| [tests/prototipo.test.cjs](./tests/prototipo.test.cjs) | Pruebas de lógica con Node.js, sin dependencias.                         |
| [VALIDACION.md](./VALIDACION.md)                       | Resultados de comprobación y recibo de Archify.                          |

El prototipo no requiere instalación ni compilación. Para ejecutar las pruebas de lógica desde la raíz, con Node.js compatible con `node:test`:

```sh
node --test --test-timeout=10000 docs/practica-07/tests/prototipo.test.cjs
```

El diagrama de Archify mantiene su interfaz fija en inglés y su atributo `lang` en inglés, conforme al soporte de esa herramienta. Sus contenidos están redactados en español; el prototipo principal está íntegramente en español.

## 10. Relación con las prácticas anteriores

Se retoman las funciones y responsabilidades de la [Práctica 05](https://github.com/angelJesus13/Quantify-Core/blob/main/docs/Practica05/README.md) y la [historia de usuario de recomendaciones](https://github.com/angelJesus13/Quantify-Core/blob/main/docs/Practica05/HU-Recomendaciones-IA.md). Esta entrega transforma esa base en recorridos visuales verificables y agrega validaciones, cancelaciones y confirmaciones para orientar el posterior desarrollo.
