# Manual técnico del equipo

Este manual conecta la documentación necesaria para **diseñar, implementar y mantener** Quantify Core. Está dirigido a desarrolladores y agentes; el [manual de usuario](../UserManual/README.md) explica la experiencia visible. **Estado:** procedimientos de desarrollo y operación propuestos, con comprobaciones limitadas a la documentación y al prototipo existentes.

```mermaid
flowchart LR
    H[Historia y aceptación] --> B[Regla y arquitectura]
    B --> C[Contrato y diseño]
    C --> I[Implementación]
    I --> T[Pruebas]
    T --> PR[Revisión e integración]
    PR --> O[Operación documentada]
```

## Recorrido para una tarea

1. Elegir [historia](../UHs/README.md), [requisito funcional](../FRs/README.md), [no funcional](../NFRs/README.md) y [regla de negocio](../BRs/README.md). Identificar el `AC-XX` entregable.
2. Revisar [arquitectura](../arquitectura/README.md), [decisiones pendientes](../arquitectura/decisiones-pendientes.md) y la frontera del módulo en `apps/`, `services/` o `infrastructure/`.
3. Confirmar el [contrato canónico](../../packages/contracts/README.md), [seguridad](../seguridad/README.md) y [diseño](../GUI/README.md) antes de definir campos, permisos o estados por cuenta propia.
4. Preparar el entorno según [Installation](../Installation/README.md). No asumir que los servicios propuestos ya arrancan.
5. Implementar con las [convenciones](../guias/estandares-desarrollo.md), agregar pruebas relevantes y actualizar el README del módulo.
6. Abrir un cambio revisable conforme a [CONTRIBUTING](../../CONTRIBUTING.md) y el [Git Flow](../guias/git-flow.md), con evidencia y limitaciones.

## Responsabilidad por capa

| Capa | Fuente de trabajo | Comprobación básica |
|---|---|---|
| Web y móvil | [Apps](../../apps/README.md), [GUI](../GUI/README.md) | Estados, permisos visuales, accesibilidad y contrato consumido. |
| API y workers | [Servicios](../../services/README.md), [API](../api/README.md) | Validación, autorización, idempotencia, errores y eventos durables. |
| Datos y analítica | [Datos e IA](../datos-ia/README.md) | Propiedad, versiones, consentimiento, calidad y abstención. |
| Operación | [Infraestructura](../../infrastructure/README.md), [despliegue](../despliegue/README.md) | Reproducibilidad, salud, respaldos y recuperación. |

## Cierre y mantenimiento

Una entrega debe enlazar requisito, decisión, contrato, código y pruebas. Un cambio de interfaz modifica consumidores y ejemplos; uno de datos evalúa migración y recuperación; uno de diseño revisa tokens y accesibilidad. El [índice documental](../README.md) evita perder la ruta entre carpetas.

Los comandos de servicios, proveedores, credenciales y objetivos de operación se añadirán cuando estén implementados y verificados. Las guías actuales permiten avanzar en definiciones y tareas independientes sin declarar una plataforma productiva que todavía no existe.
