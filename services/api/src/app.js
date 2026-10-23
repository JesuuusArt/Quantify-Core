import express from 'express';
import { healthRouter } from './modules/health/health.router.js';
import { docsRouter } from './modules/docs/docs.router.js';
import { notFoundHandler } from './middlewares/notFound.js';
import { errorHandler } from './middlewares/errorHandler.js';

export function createApp() {
  const app = express();

  app.use(express.json());

  // Rutas de healthcheck (directa y con prefijo de API)
  app.use('/health', healthRouter);
  app.use('/api/v1/health', healthRouter);

  // Documentacion OpenAPI accesible
  app.use('/docs', docsRouter);
  app.use('/api/docs', docsRouter);

  // Manejador de rutas no encontradas (404)
  app.use(notFoundHandler);

  // Manejador global de errores (500)
  app.use(errorHandler);

  return app;
}
