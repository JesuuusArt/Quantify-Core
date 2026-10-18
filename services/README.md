# Servicios

Agrupa los componentes de servidor de Quantify Core. La arquitectura propuesta separa la API de negocio, el servicio de analítica y los trabajos asíncronos para mantener responsabilidades claras.

- [`api/`](api/README.md): API principal y reglas de negocio.
- [`analytics/`](analytics/README.md): analítica e inferencia con Python y FastAPI.
- [`workers/`](workers/README.md): tareas programadas y procesamiento asíncrono.

La estructura documenta destinos previstos; no implica que los servicios estén implementados.
