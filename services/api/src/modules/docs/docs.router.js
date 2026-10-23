import { Router } from 'express';
import swaggerUi from 'swagger-ui-express';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const openApiPath = path.resolve(__dirname, '../../../openapi.json');
const openApiSpec = JSON.parse(fs.readFileSync(openApiPath, 'utf-8'));

export const docsRouter = Router();

// Servir la especificacion JSON en crudo
docsRouter.get('/openapi.json', (_req, res) => {
  res.json(openApiSpec);
});

// Servir Swagger UI interactivo
docsRouter.use('/', swaggerUi.serve, swaggerUi.setup(openApiSpec));
