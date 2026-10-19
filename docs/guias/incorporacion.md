# Incorporación al proyecto

Esta guía ayuda a empezar una tarea en Quantify Core sin confundir el producto previsto con las demostraciones académicas disponibles.

## Qué existe hoy

| Área | Estado |
|---|---|
| Prácticas 04 y 05 | Material académico de modelo de negocio, roles y funcionalidades. |
| Práctica 07 | Prototipo HTML/CSS/JavaScript con datos sintéticos y pruebas de su lógica. |
| Clientes React, Flutter y Wear OS | Documentación y destinos de implementación; todavía sin aplicaciones de producto. |
| API, workers y analítica | Diseño y contratos de desarrollo; todavía sin servicios de producto ejecutables. |
| Infraestructura | Requisitos y procedimientos previstos; todavía sin entorno completo desplegable. |

Un contrato OpenAPI o una carpeta de servicio no significa que haya un endpoint disponible. Los indicadores de terminado de una práctica se interpretan dentro de esa entrega académica.

## Primer recorrido

1. Leer el [README principal](../../README.md) y el [mapa de documentación](../README.md).
2. Identificar el requisito y sus [criterios de aceptación](../requerimientos/aceptacion.md).
3. Leer la [arquitectura](../arquitectura/README.md), el [contrato](../../packages/contracts/README.md) y el README del componente que se modificará.
4. Consultar [diseño](../diseno/README.md) y [seguridad](../seguridad/README.md), incluso si el cambio parece limitado a una sola capa.
5. Revisar la rama acordada, las dependencias de la tarea y las [decisiones pendientes](../arquitectura/decisiones-pendientes.md).

## Trabajar con Git

Ejecutar desde la raíz del repositorio:

```bash
git status
git fetch origin
git branch --all
```

Para obtener una rama publicada y disponible localmente mediante seguimiento, Git permite `git switch develop` o `git switch docs/arquitectura`. Antes de cambiar, revisar los cambios locales y conservarlos. Las instrucciones para crear nuevas ramas y preparar pull requests están en [Git Flow](git-flow.md).

## Explorar lo ejecutable

La [Práctica 07](../practica-07/README.md) explica cómo abrir el prototipo, usar sus cuentas ficticias y reiniciar la demo. Sus vistas de móvil y PWA son representaciones del mismo prototipo, no aplicaciones Flutter ni una PWA instalable.

Las pruebas existentes usan el ejecutor incorporado en Node.js. Desde la raíz:

```bash
node --test docs/practica-07/tests/prototipo.test.cjs
```

Este comando comprueba el prototipo; no comprueba una API, Keycloak, una base de datos o un dispositivo real. La [validación documental](validacion-documental.md) registra el entorno utilizado al revisar esta entrega.

## Preparar el desarrollo del producto

El primer flujo cubre identidad, perfil, hábitos, check-ins y métricas. Antes de instalar dependencias del producto, fijar en su módulo las versiones de runtime, gestor de paquetes y herramientas; crear sus manifiestos y lockfiles; preparar configuración de ejemplo y acordar las dependencias locales. Estos archivos se incorporarán con la implementación y no se simulan en esta guía.

Seguir [Docker](../../infrastructure/docker/README.md) para el entorno local y [configuración compartida](../../packages/config/README.md) para las reglas comunes. Usar únicamente datos sintéticos y credenciales de desarrollo fuera de Git.

## Entrega de la primera tarea

Una tarea inicial debe tener requisito, componente, responsable, contrato o diseño de entrada, criterio de aceptación y verificación. Si una decisión la bloquea, registrar qué hace falta resolver y continuar con las partes independientes. Al cerrar, dejar instrucciones que otra persona pueda repetir y enlazar el resultado desde el pull request.
