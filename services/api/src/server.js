import { createApp } from './app.js';
import { config } from './config/env.js';

const app = createApp();

app.listen(config.port, () => {
  console.log(`Servidor de Quantify API corriendo en http://localhost:${config.port}`);
  console.log(`Documentacion OpenAPI disponible en http://localhost:${config.port}/docs`);
  console.log(`Ruta de salud disponible en http://localhost:${config.port}/health`);
});
