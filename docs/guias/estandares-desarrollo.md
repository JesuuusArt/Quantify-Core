# Estándares de desarrollo

Base común para el código futuro de Quantify Core. Complementa los contratos y README de cada componente; no afirma que ya existan herramientas de formato, análisis estático o integración continua configuradas.

## Organización y dependencias

- Mantener presentación en `apps/`, negocio y procesos en `services/`, definiciones compartidas en `packages/` y operación en `infrastructure/`.
- Evitar dependencias entre clientes: React y Flutter consumen contratos equivalentes, sin importar código de interfaz de otro cliente.
- La API aplica las reglas de negocio y permisos. Analítica produce resultados versionados y workers ejecutan trabajos; no redefinen reglas maestras por separado.
- Mantener las migraciones junto al servicio propietario. No editar tablas de otro módulo sin un contrato de acceso y revisión.
- Registrar cambios de stack, persistencia, identidad o compatibilidad en un ADR. La selección de ORM, biblioteca de estado, cola y SDK wearable sigue pendiente.

## Convenciones por lenguaje

| Área | Convención de partida |
|---|---|
| TypeScript en web y API | Tipos explícitos en fronteras, validación de entrada en ejecución y modo estricto al crear la configuración. Evitar `any` para eludir contratos. |
| Dart y Flutter | Respetar el formato y análisis del SDK elegido, nulabilidad explícita y separación de widgets, acceso a datos y estado de presentación. |
| Python y FastAPI | Anotaciones de tipos en interfaces, validación mediante los modelos del servicio y separación de transporte, procesamiento y acceso a datos. |
| JSON compartido | Campos `camelCase` y enums definidos en el contrato; no traducir identificadores por cliente. |
| SQL | Nombres `snake_case`, restricciones de integridad y migraciones versionadas; no depender solo de validaciones de UI. |
| Documentación | Español, UTF-8, `README.md` como entrada y rutas con capitalización exacta. Identificadores de código siguen la convención de su ecosistema. |

Los formateadores, analizadores, versiones y comandos concretos se fijarán en [configuración compartida](../../packages/config/README.md) y en los manifiestos de cada módulo. La forma de ejecutar las comprobaciones debe ser igual en desarrollo y en la automatización.

## Fronteras y errores

Validar datos externos en cada frontera de confianza. Usar esquemas de [contratos](../../packages/contracts/README.md), no interfaces TypeScript como sustituto de validación en ejecución. Separar errores de validación, autenticación, autorización, conflicto, dependencia y fallo interno. Los clientes consumen códigos estables y presentan mensajes claros; no muestran excepciones internas ni stack traces.

Las operaciones con efectos laterales deben explicar qué ocurre si se repiten, si se interrumpen o si dos clientes actúan a la vez. Los check-ins siguen el contrato de idempotencia y control de versión; una confirmación optimista de UI no sustituye la aceptación del servidor.

## Fechas, números y datos

Guardar instantes técnicos en UTC y conservar la fecha de negocio y la zona IANA necesarias para evaluar hábitos. No recalcular historial con la zona actual del dispositivo ni asumir que un día equivale siempre a 24 horas. Documentar unidades, rangos y precisión de valores; los cambios de meta o frecuencia no reescriben el pasado.

Conservar la fuente y versión de las reglas al producir métricas e inferencias. PostgreSQL mantiene maestros transaccionales; MongoDB y Redis tienen responsabilidades específicas, no copias sin control de las mismas entidades. Consultar el [modelo de datos](../datos-ia/modelo-datos.md).

## Diseño y accesibilidad

Usar los [tokens compartidos](../../packages/design-tokens/README.md) y documentar estados de carga, vacío, error, éxito, pendiente de sincronización y conflicto. Mantener equivalencia funcional entre web y móvil donde el alcance coincida. Probar navegación por teclado, foco, etiquetas y contraste en los componentes implementados.

El prototipo académico orienta recorridos; sus valores locales, cuentas ficticias y privilegios de navegación no se convierten en reglas de seguridad ni en dependencias obligatorias del producto.

## Configuración, seguridad y operación

Validar variables al iniciar, describir cuáles son públicas y cuáles secretas y evitar valores implícitos distintos entre ambientes. No incluir secretos en el cliente web, logs, imágenes ni ejemplos. Aplicar permisos por rol y propiedad del recurso en servidor.

Los servicios deben tener comprobación de salud, finalización controlada y manejo limitado de reintentos según su función. Los logs y trazas siguen [observabilidad](../../infrastructure/observability/README.md); no registrar hábitos, biometría, tokens ni cuerpos completos de solicitudes.

## Evidencia y mantenimiento

Asociar las pruebas con comportamiento y riesgos: permisos, idempotencia, fechas, concurrencia, compatibilidad y pérdida de conexión. Evitar pruebas que solo dupliquen la implementación sin comprobar un resultado. Una corrección debe incluir la prueba que detecta su fallo cuando sea aplicable.

Actualizar contrato, implementación, consumidor, ejemplo y documentación cuando cambie una interfaz. Marcar migraciones y cambios incompatibles. No mantener la documentación como una copia de código que nadie puede ejecutar ni presentar propuestas como decisiones ya validadas.
