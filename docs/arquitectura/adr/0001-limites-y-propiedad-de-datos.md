# ADR-0001: Límites de componentes y propiedad de datos

- Estado: **propuesto**
- Fecha: 2026-10-18
- Responsables propuestos: arquitectura, backend y administración de BD
- Requisitos afectados: RF-01 a RF-10; RNF-01/02/05/08
- Revisión y aprobación: pendientes; este documento no las presume

## Contexto

El README propone clientes web/móvil, NestJS, FastAPI y persistencia políglota. Algunas flechas históricas permiten interpretar que analítica puede escribir datos maestros o que un check-in solo reside en MongoDB. Se necesita una única definición de quién confirma una operación, cómo se recalcula y qué ocurre al reintentar.

## Opciones consideradas

1. **Backend modular NestJS y analítica FastAPI con contratos limitados:** conserva el stack, separa reglas de negocio y modelos y permite empezar con pocos despliegues. Exige definir eventos y autorización interna.
2. **Microservicio independiente por dominio desde el inicio:** ofrece aislamiento, pero aumenta contratos, operación y consistencia antes de tener evidencia de carga.
3. **Escrituras directas de analítica y workers a todas las tablas:** simplifica pruebas rápidas, pero diluye permisos, invariantes y auditoría; no se recomienda como base.

## Propuesta

- Adoptar la opción 1 como base de implementación sujeta a revisión.
- La API y sus casos de uso son dueños de perfiles, consentimiento, hábitos, check-ins, recomendaciones aceptadas y solicitudes de datos. PostgreSQL es la verdad transaccional.
- Keycloak conserva credenciales y sesiones; la API relaciona la identidad externa con un identificador interno y verifica pertenencia.
- MongoDB conserva eventos biométricos y telemetría de dominio autorizada. No es la única copia del progreso diario confirmado.
- Redis mantiene datos efímeros y coordinación. Operaciones pendientes que no deban perderse se respaldan de forma durable, por ejemplo con outbox transaccional.
- FastAPI recibe características minimizadas por contrato o lecturas restringidas aprobadas. Devuelve resultados trazables; no modifica maestros.
- Workers aplican casos de uso autorizados y deduplican efectos. Las métricas y clientes utilizan la misma versión de reglas.

## Consecuencias

Se puede probar el núcleo sin dispositivo wearable ni inferencia activa. La aceptación de una recomendación mantiene una sola transacción de negocio. Aparecen tareas explícitas de outbox, reintentos, reconciliación y retención; se debe medir su costo antes de ampliar la topología.

Mantener PostgreSQL y MongoDB requiere respaldo y políticas por almacén. El stack propuesto se conserva; retirar un motor o reemplazar un framework exige otro ADR, sin interpretar antecedentes académicos como permiso implícito.

## Evidencia para aceptar

- Prueba de registro reintentado y concurrente con un resultado diario y revisiones auditables.
- Prueba de recuperación tras caída entre confirmación de negocio y publicación de evento.
- Identidad de analítica sin permiso de escritura sobre maestros y sin acceso a usuarios/finalidades no autorizados.
- Revisión conjunta de [componentes](../componentes.md), [modelo](../../datos-ia/modelo-datos.md) y [contrato](../../api/README.md).

No se adjunta evidencia de estas pruebas porque los servicios aún deben implementarse. La revisión deberá registrar resultados y limitaciones antes de cambiar el estado.

## Reversión o reemplazo

Revisar si carga medida, aislamiento o costos requieren extraer un módulo, eliminar un almacén o cambiar la forma de lectura de analítica. Mantener las fuentes de verdad y los contratos durante cualquier migración; registrar un ADR sucesor con plan de datos y recuperación.
