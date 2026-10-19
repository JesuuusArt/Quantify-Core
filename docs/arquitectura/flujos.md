# Flujos de integración

Los diagramas describen la solución propuesta. Los campos y códigos concretos se revisan con el [contrato de API](../api/README.md). Las flechas de éxito solo ocurren después de validar sesión, permisos y pertenencia.

## RF-04: registrar progreso y repetir una solicitud

```mermaid
sequenceDiagram
    autonumber
    actor U as Usuario
    participant C as Web o Flutter
    participant A as API NestJS
    participant P as PostgreSQL
    participant W as Worker
    U->>C: Establecer progreso acumulado
    C->>C: Guardar operación local autorizada
    C->>A: POST check-ins con clave y expectedVersion
    A->>A: Validar sesión, dueño, agenda y fechas
    A->>P: Buscar operación idempotente
    alt Misma operación ya confirmada
        P-->>A: Resultado original
        A-->>C: Resultado existente
    else Operación nueva
        A->>P: Transacción: dedupe, revisión, consolidado, auditoría y outbox
        alt Versión obsoleta o contenido incompatible
            P-->>A: Conflicto, sin mutación parcial
            A-->>C: Conflicto para resolver
        else Transacción confirmada
            P-->>A: Check-in y versión confirmados
            A-->>C: Resultado confirmado
            W->>P: Leer outbox pendiente
            W->>W: Procesar una vez por eventId
            W->>A: Actualizar derivados por caso de uso
        end
    end
    C-->>U: Sincronizado o conflicto explícito
```

El comando usa `clientEventId`, `businessDate`, `occurredAt`, `timeZone`, `value` y `expectedVersion`. `value` es el total acumulado del día. Una creación usa revisión esperada cero; correcciones indican la revisión recibida. La API genera `receivedAt` y valida que fecha/zona correspondan a la agenda histórica.

La deduplicación por `clientEventId` dura lo que establezca la política de registros; la caché de una clave de solicitud puede tener otra retención. Reutilizar la clave o evento con contenido distinto causa conflicto. La transacción debe resolver carreras con restricciones y control de versión, no solo con un `SELECT` previo.

Si la respuesta se pierde, el cliente conserva el mismo identificador de operación y contenido al reintentar. Ante conflicto de versión muestra el estado confirmado y solicita o aplica una resolución documentada; no crea automáticamente otro incremento.

## RF-07: generar, presentar y aceptar una recomendación

```mermaid
sequenceDiagram
    autonumber
    participant W as Worker autorizado
    participant A as API NestJS
    participant M as FastAPI
    participant P as PostgreSQL
    actor U as Usuario
    W->>A: Solicitar datos mínimos para finalidad
    A->>A: Verificar consentimiento vigente
    A-->>W: Características y contexto versionados
    W->>M: Solicitar inferencia trazable
    alt Datos insuficientes o modelo inhabilitado
        M-->>W: Abstención con motivo
    else Resultado evaluado
        M-->>W: Resultado, evidencia y versión
        W->>A: Proponer persistencia de resultado
        A->>A: Revalidar consentimiento y deduplicación
        A->>P: Guardar recomendación autorizada
    end
    U->>A: Consultar recomendaciones propias
    A-->>U: Resultado permitido y explicación
    U->>A: Guardar hábito desde propuesta
    A->>P: Transacción: crear hábito y enlazar aceptación
    P-->>A: Una aceptación confirmada
    A-->>U: Hábito creado
```

Consultar una lista no exige generar inferencia en esa misma petición. Generación costosa se programa o solicita como trabajo; la consulta retorna estado y resultados ya autorizados. Cancelar la personalización no acepta ni crea el hábito. El servidor vuelve a comprobar consentimiento al servir el resultado para no presentar una recomendación retirada.

## RF-08: ingesta y revocación por fases

```mermaid
flowchart TD
    A[Lote de fuente vinculada] --> B{Identidad y consentimiento vigentes}
    B -->|No| X[Rechazar sin nueva ingesta]
    B -->|Sí| C{Esquema, unidades y tiempo válidos}
    C -->|No| Q[Rechazar o aislar según causa]
    C -->|Sí| D{Evento ya recibido}
    D -->|Sí, igual| E[Retornar recepción existente]
    D -->|Sí, distinto| F[Informar conflicto]
    D -->|No| G[Persistir señal autorizada en MongoDB]
    G --> H[Confirmar recepción y calidad]
    H --> I[Procesar solo con finalidad vigente]
```

Recepción, interpretación y uso analítico son pasos diferentes. La revocación bloquea lotes futuros y trabajos pendientes, también si el dispositivo estuvo offline. Las señales retenidas se eliminan o conservan según política explícita; revocar no debe confundirse con borrar sin seguimiento. Protocolo, SDK, sensores y canal de emparejamiento dependen de D-06.

## RF-10: exportación y eliminación

La solicitud empieza en una sesión verificada, registra alcance y estado, y termina con evidencia por almacén. Exportación crea un artefacto privado con caducidad. Eliminación coordina PostgreSQL, MongoDB, objetos, derivados, cache y credenciales sin asumir una transacción global. Fallos parciales permanecen visibles y reintentables; no informar «eliminado» al recibir únicamente la solicitud. Véase [ciclo de vida de datos](../datos-ia/calidad-ciclo-vida.md).
