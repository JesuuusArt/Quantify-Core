# Guía para agentes de desarrollo

Estas instrucciones aplican al repositorio Quantify-Core. Complementan las instrucciones de la persona que solicita el trabajo y la documentación del módulo afectado.

## Antes de editar

1. Revisar `git status`, la rama activa y los cambios existentes. Conservar el trabajo de otras personas.
2. Leer `README.md`, `docs/README.md`, `CONTRIBUTING.md` y el README de la carpeta afectada.
3. Consultar requisitos y reglas en `docs/requerimientos/`, decisiones en `docs/arquitectura/` y contratos en `packages/contracts/`.
4. Identificar si la tarea modifica un prototipo académico, documentación o producto. No trasladar cuentas, permisos simulados, datos o umbrales de la demo al producto.

## Base tecnológica

- Web: React, TypeScript y Vite; capacidades PWA por implementar.
- Móvil: Flutter y Dart. Wear OS se incorpora por fases; SDK y protocolo pendientes.
- API de negocio: Node.js, TypeScript y NestJS. Analítica: Python y FastAPI.
- Datos: PostgreSQL transaccional, MongoDB para eventos/telemetría según necesidad, Redis para cache/trabajos; el cliente de colas y ORM requieren decisión.
- Identidad: Keycloak y OIDC con Authorization Code + PKCE. No crear autenticación paralela ni guardar contraseñas en clientes.
- Infraestructura: Docker/Compose; OpenTelemetry y la propuesta Prometheus/Grafana.

Respetar esta base. Un cambio de stack necesita justificación y registro de decisión; una alternativa mencionada en material histórico no autoriza sustituirla.

## Coherencia del trabajo

- La API aplica permisos y propiedad de recursos. Ser administrador no concede acceso general a hábitos ni biometría privados.
- Compartir contratos REST y de eventos desde `packages/contracts/`; no mantener DTO incompatibles por cliente.
- Seguir las reglas de fecha de negocio, zona horaria, idempotencia y concurrencia documentadas. No sumar dos veces un check-in reintentado.
- Conservar el historial al pausar o archivar. Cambios de reglas o modelos tienen versión y pruebas.
- Mantener tokens visuales en `packages/design-tokens/` y sus definiciones en `docs/diseno/`; no copiar la paleta de un sketch como nueva identidad.
- No añadir credenciales, datos personales reales ni `.env` con secretos. No mostrar tokens en resultados o logs.
- No presentar propuestas, mocks o contratos como servicios implementados. No inventar comandos o resultados de pruebas.

## Entrega

Actualizar documentación y pruebas afectadas en el mismo cambio. Ejecutar las comprobaciones existentes que correspondan; señalar los bloqueos reales sin inventar cobertura. Reportar archivos cambiados, resultado de validación y decisiones pendientes.

Seguir el Git Flow de `docs/guias/git-flow.md`. Utilizar la rama acordada y el alcance de publicación solicitado por el usuario. No crear ni publicar ramas ajenas a la tarea, cambiar la identidad Git ni sobrescribir historial compartido como parte de una edición documental.
