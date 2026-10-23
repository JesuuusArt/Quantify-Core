import { test, describe, before, after } from 'node:test';
import assert from 'node:assert/strict';
import { createApp } from '../src/app.js';

describe('Pruebas de la API inicial', () => {
  let server;
  let baseUrl;

  before(async () => {
    const app = createApp();
    await new Promise((resolve) => {
      server = app.listen(0, () => {
        const port = server.address().port;
        baseUrl = `http://127.0.0.1:${port}`;
        resolve();
      });
    });
  });

  after(async () => {
    await new Promise((resolve, reject) => {
      server.close((err) => (err ? reject(err) : resolve()));
    });
  });

  test('GET /health devuelve HTTP 200 y estado ok', async () => {
    const res = await fetch(`${baseUrl}/health`);
    assert.equal(res.status, 200);

    const body = await res.json();
    assert.equal(body.status, 'ok');
    assert.equal(body.service, 'quantify-api');
    assert.equal(body.version, '1.0.0');
    assert.ok(typeof body.uptime === 'number');
    assert.ok(typeof body.timestamp === 'string');
  });

  test('GET /api/v1/health devuelve HTTP 200 y estado ok', async () => {
    const res = await fetch(`${baseUrl}/api/v1/health`);
    assert.equal(res.status, 200);

    const body = await res.json();
    assert.equal(body.status, 'ok');
  });

  test('GET /docs/openapi.json devuelve la especificacion OpenAPI en JSON', async () => {
    const res = await fetch(`${baseUrl}/docs/openapi.json`);
    assert.equal(res.status, 200);

    const body = await res.json();
    assert.equal(body.info.title, 'Quantify Core API');
    assert.ok(body.paths['/health']);
  });

  test('GET /docs/ devuelve HTTP 200 para la interfaz Swagger', async () => {
    const res = await fetch(`${baseUrl}/docs/`);
    assert.equal(res.status, 200);
    const text = await res.text();
    assert.ok(text.includes('Swagger UI') || text.includes('swagger'));
  });

  test('GET /ruta-que-no-existe devuelve HTTP 404 estructurado', async () => {
    const res = await fetch(`${baseUrl}/ruta-que-no-existe`);
    assert.equal(res.status, 404);

    const body = await res.json();
    assert.ok(body.error);
    assert.equal(body.error.statusCode, 404);
  });
});
