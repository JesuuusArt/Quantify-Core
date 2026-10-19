# Historias del primer recorrido · HU-01 a HU-05

**Estado:** listas para desglose técnico, sujetas a los [pendientes de arquitectura](../arquitectura/decisiones-pendientes.md). Las comprobaciones descritas son objetivos futuros, no pruebas del producto ya ejecutadas.

```mermaid
flowchart LR
    A[HU-01 Acceder] --> B[HU-02 Perfil]
    B --> C[HU-03 Crear hábito]
    C --> D[HU-04 Registrar avance]
    D --> E[HU-05 Consultar resultado]
```

## HU-01 · Acceso propio

Como usuario quiero iniciar y recuperar mi sesión para encontrar mis datos en mis dispositivos. La identidad se gestiona con Keycloak; la API valida token y pertenencia. Una sesión inválida se rechaza y un usuario no se asigna permisos administrativos. Relación: [RF-01 y AC-01](../requerimientos/catalogo.md), [seguridad](../seguridad/README.md). La estrategia final de sesión web y suspensión está en D-02.

## HU-02 · Perfil y permisos de datos

Como usuario quiero elegir mi zona y las finalidades autorizadas para controlar el uso de mis registros. La UI explica cada permiso; la revocación bloquea nuevos usos y tareas pendientes. Cambiar zona no reescribe hábitos pasados. Relación: [RF-02 y AC-02](../requerimientos/catalogo.md), [ciclo de vida de datos](../datos-ia/calidad-ciclo-vida.md). Falta el contrato de escritura de perfil y consentimiento.

## HU-03 · Rutina personal

Como usuario quiero definir meta, unidad y días de un hábito para planificarlo. Una edición genera configuración con vigencia y conserva el historial; pausar o archivar necesita un resultado claro. No se crea nada al cancelar. Relación: [RF-03 y AC-03](../requerimientos/catalogo.md), [reglas RN-P03/04/06/09](../requerimientos/reglas-negocio.md). El [contrato inicial](../../packages/contracts/README.md) cubre alta y edición; precisión y ventanas quedan en D-03.

## HU-04 · Progreso confiable

Como usuario quiero indicar el **total alcanzado** en una fecha para conocer mi avance. El cliente conserva una clave al reintentar; la API confirma una única operación y registra correcciones con versión y motivo. Una revisión obsoleta provoca conflicto visible. Relación: [RF-04 y AC-04](../requerimientos/catalogo.md), [CA-03 a CA-07](../requerimientos/aceptacion.md). La sincronización sin conexión se activa solo cuando su almacenamiento y política estén aprobados.

## HU-05 · Métricas comprensibles

Como usuario quiero ver cumplimiento y rachas para entender qué ocurrió. El cálculo considera metas históricas y solo periodos programados cerrados; un periodo sin oportunidades se muestra «sin datos». La interfaz identifica ventana y estado de recálculo. Relación: [RF-05 y AC-05](../requerimientos/catalogo.md), [reglas RN-P17/18](../requerimientos/reglas-negocio.md) y [diseño](../diseno/recorridos.md).

## Puerta de aceptación

El recorrido integrado debe probar dos usuarios, sesión inválida, fechas cercanas a medianoche, reintento con respuesta perdida, conflicto entre dispositivos, archivo con historial y un periodo sin datos. Los casos y su evidencia se registran en [aceptación](../requerimientos/aceptacion.md) y en el PR que los implemente.
