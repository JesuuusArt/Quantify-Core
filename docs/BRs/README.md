# BRs · Reglas de negocio

**BRs** reúne las *Business Rules* de Quantify Core: las condiciones que hacen consistente un hábito, un registro y los permisos de una persona. **Estado:** especificación propuesta para el producto. La definición completa y versionable está en [reglas de negocio](../requerimientos/reglas-negocio.md); esta carpeta ofrece una ruta de lectura y trazabilidad, sin crear otra copia de esas reglas.

```mermaid
flowchart LR
    R[Regla RN-P] --> F[Requisito RF]
    F --> C[Contrato o diseño]
    C --> T[Caso de aceptación]
    T --> E[Evidencia en el cambio]
```

| Grupo | Reglas de referencia | Qué debe quedar consistente |
|---|---|---|
| Identidad y privacidad | RN-P01 a RN-P05 | Pertenencia, consentimiento, estados, versiones y catálogo. |
| Agenda y tiempo | RN-P06 a RN-P10 | Zona del hábito, fecha de negocio y oportunidades programadas. |
| Progreso y conflictos | RN-P11 a RN-P16 | Valor diario absoluto, idempotencia, correcciones y dos dispositivos. |
| Métricas | RN-P17 a RN-P18 | Periodos cerrados, rachas reproducibles y agregados recalculables. |
| Recomendaciones y operación | RN-P19 a RN-P24 | Decisión explícita, autorización de señales y límites administrativos. |

Por ejemplo, reintentar un check-in de 15 minutos debe conservar el resultado de 15, mientras que cambiarlo después a 20 es una corrección con nueva versión. La API, web y móvil deben apoyarse en la misma [semántica del contrato](../api/README.md) y en [CA-05 a CA-07](../requerimientos/aceptacion.md), sin sumar valores por su cuenta.

## Antes de implementar una regla

1. Identificar RN-P, RF y caso de aceptación afectados.
2. Revisar los estados y datos históricos que podría modificar.
3. Resolver los parámetros abiertos en [decisiones pendientes](../arquitectura/decisiones-pendientes.md); no copiar límites de una práctica como política del producto.
4. Actualizar la fuente, contrato, consumidores y pruebas en el mismo cambio.

Las reglas `RN01` a `RN13` del [prototipo de Práctica 07](../practica-07/README.md) pertenecen a esa demo. Su equivalencia con `RN-P` debe revisarse antes de trasladar una conducta al producto.
