# Incidentes y recuperación

Guía de referencia para los ambientes que se implementen. Antes de operar deben asignarse responsables, canales, severidades, objetivos de recuperación y comandos específicos. Las metas de pérdida de datos tolerada (RPO) y tiempo de recuperación (RTO) se acuerdan según el alcance y se comprueban mediante ejercicios.

## Atender un incidente

1. Registrar ambiente, versión, inicio, síntomas, impacto y persona responsable de coordinar la atención.
2. Revisar salud, métricas, logs y trazas autorizados. Evitar copiar datos personales o secretos a tickets, conversaciones o capturas.
3. Determinar si el fallo está en código, configuración, identidad, dependencia, red o datos. Conservar evidencia mínima útil para la investigación.
4. Contener el impacto con una acción documentada: desactivar una función, detener un consumidor, limitar tráfico o recuperar una versión compatible, según el caso.
5. Verificar la recuperación con un flujo sintético y observar las señales acordadas antes de cerrar.

Las comunicaciones a usuarios o terceros se gestionan por los responsables designados y el procedimiento aprobado; una alerta técnica no debe publicar automáticamente información sensible.

## Revertir una entrega

Identificar la versión anterior, su configuración y su compatibilidad con el estado actual de los datos. Una migración destructiva puede impedir volver a ejecutar el artefacto anterior. Documentar la alternativa: corrección hacia adelante, restauración o transición compatible.

Recuperar componentes en el orden que exigen sus dependencias. Confirmar versión efectiva, permisos, integridad y consistencia entre servicios. Registrar qué datos o trabajos pudieron verse afectados durante el incidente.

## Restaurar datos

Seleccionar un respaldo y comprobar su integridad, permisos, cifrado y antigüedad. Ensayar primero en un destino aislado y verificar esquemas, registros y relaciones. Coordinar escrituras y trabajos pendientes antes de reemplazar datos del ambiente afectado para evitar duplicación o pérdida silenciosa.

Después de restaurar, comprobar identidad y consentimiento, compatibilidad de versiones y capacidad de continuar operaciones idempotentes. Comparar el tiempo y pérdida de datos observados con RTO/RPO. Los comandos y la política de reconciliación dependen del almacenamiento seleccionado y deberán existir antes de operar con datos reales.

## Aprendizaje y seguimiento

Documentar causa, impacto, línea temporal, recuperación y acciones con responsable. Actualizar alertas, pruebas y procedimientos que habrían detectado o limitado el fallo. Evitar reportes que atribuyan el incidente únicamente a una persona sin corregir las condiciones técnicas y de proceso.

Consultar [seguridad](../seguridad/README.md) cuando intervengan accesos o información sensible y [observabilidad](../../infrastructure/observability/README.md) para el manejo de señales y evidencias.
