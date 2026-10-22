# Modelo conceptual y relacional de datos

**Estado:** esquema relacional físico de entidades core (P0) implementado y verificado en PostgreSQL ([schema.sql](../../services/api/src/database/schema.sql)). Las entidades de telemetría y biometría continúan en fase de diseño. El contrato público JSON usa `camelCase` y el esquema físico SQL usa `snake_case`.

```mermaid
erDiagram
    PROFILES ||--o{ USER_CONSENTS : "concede (1:N)"
    PROFILES ||--o{ HABITS : "posee (1:N)"
    PROFILES ||--o{ CHECK_INS : "registra (1:N)"
    PROFILES ||--o{ IDEMPOTENCY_KEYS : "restringe (1:N)"
    HABITS ||--o{ HABIT_REVISIONS : "versiona meta/frecuencia (1:N)"
    HABITS ||--o{ CHECK_INS : "consolida por fecha (1:N)"
    CHECK_INS ||--o{ CHECK_IN_REVISIONS : "audita correcciones (1:N)"

    PROFILES {
        uuid id PK
        varchar keycloak_id UK
        varchar email UK
        varchar time_zone
        varchar status
        text_array roles
        timestamptz created_at
        timestamptz updated_at
    }

    USER_CONSENTS {
        uuid id PK
        uuid profile_id FK
        varchar purpose
        varchar source
        varchar text_version
        boolean is_granted
        timestamptz granted_at
        timestamptz revoked_at
    }

    HABITS {
        uuid id PK
        uuid profile_id FK
        varchar name
        varchar unit
        varchar time_zone
        varchar status
        integer current_version
        timestamptz created_at
        timestamptz updated_at
    }

    HABIT_REVISIONS {
        uuid id PK
        uuid habit_id FK
        integer version
        numeric target_value
        varchar unit
        int_array weekdays
        date effective_from
        varchar time_zone
        timestamptz created_at
    }

    CHECK_INS {
        uuid id PK
        uuid habit_id FK
        uuid profile_id FK
        date business_date
        varchar time_zone
        numeric current_value
        varchar progress_status
        integer current_version
        timestamptz created_at
        timestamptz updated_at
    }

    CHECK_IN_REVISIONS {
        uuid id PK
        uuid check_in_id FK
        integer version
        uuid client_event_id
        numeric value
        timestamptz occurred_at
        timestamptz recorded_at
        varchar time_zone
        uuid actor_id FK
        varchar origin
        text correction_reason
    }

    IDEMPOTENCY_KEYS {
        uuid id PK
        uuid profile_id FK
        varchar idempotency_key
        varchar operation
        varchar request_hash
        integer response_status_code
        jsonb response_body
        timestamptz created_at
        timestamptz expires_at
    }

    OUTBOX_EVENTS {
        uuid id PK
        varchar aggregate_type
        uuid aggregate_id
        varchar event_type
        jsonb payload
        varchar trace_id
        timestamptz created_at
        timestamptz published_at
    }
```

## Propiedad y ubicación propuestas

| Entidad lógica | Almacén y dueño | Campos mínimos y restricciones de diseño |
|---|---|---|
| Perfil | PostgreSQL, API | Identificador interno opaco, sujeto Keycloak, zona IANA, estado. El IdP gestiona credenciales y sesiones; el perfil no almacena contraseñas. |
| Consentimiento | PostgreSQL, API | Dueño, finalidad, fuente, versión del texto, instante de aceptación/revocación y estado. La autorización se reevalúa al usar datos. |
| Hábito | PostgreSQL, API | Dueño, estado `active/paused/archived`, identificador y revisión actual. El archivo conserva el historial. |
| Revisión de hábito | PostgreSQL, API | Meta, unidad, frecuencia, zona, vigencia `effectiveFrom` y versión. Las revisiones antiguas conservan el significado de periodos anteriores. |
| Check-in | PostgreSQL, API | Hábito, fecha de negocio y versión actual; una consolidación por hábito y fecha. Restricción única y pertenencia comprobada en servidor. |
| Revisión de check-in | PostgreSQL, API | Valor absoluto, actor, fecha de servidor, origen, motivo de corrección y versión. Nunca sumar reintentos como avance nuevo. |
| Clave idempotente | PostgreSQL, API | Actor, operación, clave, huella de petición y resultado durable. Retención alineada con el máximo periodo offline que se apruebe. |
| Evento de salida y auditoría | PostgreSQL, API | Hecho confirmado, versión, actor o servicio, recurso, resultado y correlación no sensible; el outbox precede a su publicación. |
| Dispositivo | PostgreSQL, API | Dueño, fuente, estado y consentimiento vinculado. Identificadores y credenciales con acceso limitado. |
| Lote de señal | MongoDB si se justifica, ingesta autorizada | Fuente, esquema, periodo, instante recibido, calidad y referencia de consentimiento. Señales biométricas se limitan a finalidad aprobada. |
| Recomendación | PostgreSQL, API/analítica según contrato | Dueño, resultado, evidencia mínima, versión de regla/modelo, expiración y decisión explícita del usuario. |

La ubicación del dato biométrico y la conveniencia de MongoDB requieren prueba técnica y [decisión D-04](../arquitectura/decisiones-pendientes.md). No duplicar perfiles, hábitos o consentimientos como maestros en MongoDB. Los agregados y caches son derivados y necesitan una forma de reconstrucción.

## Tiempo y cambios

```mermaid
sequenceDiagram
    participant C as Cliente
    participant A as API
    participant P as PostgreSQL
    C->>A: Progreso absoluto, fecha de negocio, zona, versión esperada, clave
    A->>P: Comprobar dueño, agenda vigente, versión y deduplicación
    P-->>A: Confirmación con nueva revisión y outbox
    A-->>C: Resultado confirmado
    C->>A: Reintento con la misma intención y clave
    A->>P: Leer resultado ya confirmado
    A-->>C: Mismo resultado
```

Un instante técnico se representa en UTC; la fecha de negocio y la zona IANA del hábito se guardan por separado. No derivar el histórico con la zona actual del teléfono o del perfil. Un cambio de meta, frecuencia, unidad o zona crea una nueva revisión con vigencia definida; no reescribe periodos cerrados. Las reglas numéricas y el máximo plazo para corregir quedan en [decisión D-03](../arquitectura/decisiones-pendientes.md).

El cliente envía una versión esperada para resolver dos dispositivos. Ante conflicto, la API conserva el estado confirmado e informa al cliente para revisar antes de una nueva intención. Una petición repetida con la misma clave devuelve el resultado original tras comprobar permiso; la clave repetida con otro contenido se rechaza. El [contrato HTTP](../../packages/contracts/README.md) fija los campos públicos y códigos exactos.

## Integridad y acceso

La API es dueña de las transacciones de negocio. Analítica lee una vista o interfaz con datos mínimos autorizados y no escribe maestros. Los workers reciben hechos confirmados y pueden reintentar; sus efectos son idempotentes. Proteger recursos por dueño incluso cuando un cliente suministra un identificador válido. Administración gestiona catálogos y estado de cuentas con permisos específicos; no consulta rutinas privadas por defecto.

Antes de crear tablas o colecciones, acordar índices y unicidad, política de migraciones, precisión numérica, volumen previsto, retención y respaldos. Mantener datos sintéticos en ejemplos y pruebas.
