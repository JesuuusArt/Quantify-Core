# FRs · Requisitos funcionales

**FRs** organiza las funciones del producto por requisito `RF-XX`. **Estado:** base propuesta, todavía sin servicios o clientes del producto disponibles. El [catálogo](../requerimientos/catalogo.md) define la necesidad, criterios `AC-XX` y dependencias; la [matriz de aceptación](../requerimientos/aceptacion.md) describe cómo comprobarlas.

| ID | Capacidad | Primera evidencia esperada |
|---|---|---|
| RF-01 | Identidad y acceso con Keycloak | Sesión válida, vencida y recursos ajenos denegados. |
| RF-02 | Perfil y consentimiento | Zona horaria, permiso granular y revocación. |
| RF-03 | Hábitos | Creación, edición versionada, pausa y archivo con historial. |
| RF-04 | Check-ins | Valor absoluto, reintento idempotente y conflicto explícito. |
| RF-05 | Métricas y rachas | Cálculo con metas históricas y periodos cerrados. |
| RF-06 | Recordatorios | Preferencias, permisos y entrega sin duplicados. |
| RF-07 | Recomendaciones | Evidencia, abstención y aceptación voluntaria. |
| RF-08 | Wear OS y biometría | Vinculación, señal autorizada y revocación. |
| RF-09 | Administración | Catálogo y cuentas con permisos, motivo y auditoría. |
| RF-10 | Auditoría y derechos de datos | Exportación y eliminación controladas y trazables. |

```mermaid
flowchart LR
    RF01[RF-01 Acceso] --> RF02[RF-02 Perfil]
    RF02 --> RF03[RF-03 Hábito]
    RF03 --> RF04[RF-04 Check-in]
    RF04 --> RF05[RF-05 Métricas]
    RF05 --> O[RF-06 a RF-10 por fase]
```

RF-01 a RF-05 forman el primer recorrido de implementación. Los demás requisitos se añaden según las dependencias del [plan](../requerimientos/README.md). Seguridad y derechos sobre datos acompañan las funciones que tratan información personal; el orden del gráfico no permite dejarlos para después de un piloto real.

## Ficha que acompaña cada entrega

Indicar `RF-XX`, `AC-XX`, regla `RN-P`, historia `HU-XX`, pantalla o consumidor, operación del contrato, decisión pendiente, responsable y prueba con resultado. Un mock o pantalla aislada demuestra solo su alcance. Los [requisitos no funcionales](../NFRs/README.md) también se comprueban en cada función.
