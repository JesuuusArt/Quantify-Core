# Colaboración en GitHub

Esta carpeta mantiene ayudas para documentar y revisar cambios. La automatización de compilación, pruebas y despliegue se añadirá cuando existan los módulos y comandos correspondientes.

## Disponible

- [Plantilla de pull request](pull_request_template.md): objetivo, alcance, validación y compatibilidad.
- [Plantilla de tarea](ISSUE_TEMPLATE/tarea.md): requisito, entradas y aceptación.
- [Plantilla de error](ISSUE_TEMPLATE/error.md): reproducción, resultado e impacto sin datos sensibles.

Las plantillas están versionadas en la rama de trabajo. GitHub las ofrecerá automáticamente cuando estén disponibles en la rama que consulta para esa función; publicarlas en `docs/arquitectura` no cambia por sí solo la configuración ni la rama predeterminada del repositorio.

## Por configurar con la implementación

Los workflows deberán declarar disparadores, permisos mínimos, requisitos de herramientas, comandos, resultados y secretos utilizados. Las comprobaciones de pull request no deben necesitar credenciales de producción. Separar validación de código de publicación de artefactos y despliegue.

Las protecciones de ramas, revisiones requeridas y permisos se gestionan en la configuración del repositorio. Este documento no las activa. La rama de integración es `develop`; `main` recibe releases y hotfixes conforme al [Git Flow](../docs/guias/git-flow.md).

Consultar [contribución](../CONTRIBUTING.md) y la [estrategia de pruebas](../tests/README.md). No almacenar tokens o credenciales en plantillas, workflows, capturas ni ejemplos.
