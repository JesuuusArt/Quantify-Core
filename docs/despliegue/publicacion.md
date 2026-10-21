# Procedimiento de publicación

Plantilla operativa para convertir una entrega revisada en una versión verificable. Debe completarse con comandos y permisos de la plataforma elegida antes del primer despliegue. No constituye una orden de ejecución ni evidencia de un ambiente disponible.

## Ficha de entrega

| Campo | Valor que debe registrarse |
|---|---|
| Alcance | Requisitos incluidos y componentes afectados. |
| Origen | Commit, versión y revisión de configuración. |
| Artefactos | Identificador inmutable de cada imagen o paquete, junto con su procedencia. |
| Destino | Ambiente, región o ubicación y recursos afectados. |
| Responsable | Persona que ejecuta y contacto de operación. |
| Compatibilidad | Contratos, esquema y migraciones que exige la versión. |
| Recuperación | Versión anterior compatible, respaldos necesarios y procedimiento probado. |

## Preparación

Revisar el resultado de pruebas y cambios incompatibles. Confirmar capacidad, configuración, secretos y conectividad. Registrar el estado previo y comprobar que la restauración de datos es posible cuando el cambio afecta persistencia. Definir las señales y la ventana de observación que determinan éxito o recuperación.

## Publicación

Ejecutar las migraciones conforme al servicio propietario, con coordinación para impedir ejecuciones simultáneas. Publicar el artefacto identificado y comprobar que el ambiente está usando exactamente esa revisión. Si hay clientes antiguos activos, preservar la compatibilidad declarada durante la transición.

Los comandos concretos se añadirán cuando existan los archivos de configuración y se hayan probado en el ambiente de validación. Una etiqueta de Git identifica código; no demuestra qué artefacto quedó ejecutándose.

## Comprobación posterior

Verificar salud de componentes y dependencias, autenticación, autorización y un flujo sintético de creación de hábito, check-in y consulta de métricas. Confirmar que reintentar el check-in no lo duplica. Revisar errores, duración de operaciones y trabajos pendientes según los objetivos definidos para esa entrega.

El flujo sintético debe usar una cuenta de prueba y recursos identificables, con limpieza prevista. No utilizar datos de usuarios reales para comprobar una publicación.

## Cierre

Registrar hora, versión efectiva, evidencia y limitaciones. Ante incumplimiento del criterio de éxito, aplicar [recuperación](recuperacion.md). Actualizar la referencia de versión recuperable y la documentación operativa. No marcar terminado por el solo hecho de que una herramienta de despliegue haya devuelto un código de salida satisfactorio.
