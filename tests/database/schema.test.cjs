const { describe, it } = require('node:test');
const assert = require('node:assert');
const fs = require('node:fs');
const path = require('node:path');

describe('Verificación del Modelo Relacional de Base de Datos (P0)', () => {
  const schemaPath = path.resolve(__dirname, '../../services/api/src/database/schema.sql');
  const seedsPath = path.resolve(__dirname, '../../services/api/src/database/seeds.sql');
  const verifyPath = path.resolve(__dirname, '../../services/api/src/database/verify.sql');
  const composePath = path.resolve(__dirname, '../../infrastructure/docker/compose.yaml');
  const archifyPath = path.resolve(__dirname, '../../docs/datos-ia/modelo-relacional.archify.json');
  const visualizerPath = path.resolve(__dirname, '../../docs/datos-ia/diagrama-modelo-relacional.html');

  it('Los archivos clave de base de datos y diagramas visuales existen y son legibles', () => {
    assert.strictEqual(fs.existsSync(schemaPath), true, 'schema.sql debe existir');
    assert.strictEqual(fs.existsSync(seedsPath), true, 'seeds.sql debe existir');
    assert.strictEqual(fs.existsSync(verifyPath), true, 'verify.sql debe existir');
    assert.strictEqual(fs.existsSync(composePath), true, 'compose.yaml debe existir');
    assert.strictEqual(fs.existsSync(archifyPath), true, 'modelo-relacional.archify.json debe existir');
    assert.strictEqual(fs.existsSync(visualizerPath), true, 'diagrama-modelo-relacional.html debe existir');
  });

  const schemaContent = fs.readFileSync(schemaPath, 'utf8');

  it('Define todas las tablas requeridas por la especificación', () => {
    const requiredTables = [
      'profiles',
      'user_consents',
      'habits',
      'habit_revisions',
      'check_ins',
      'check_in_revisions',
      'idempotency_keys',
      'outbox_events'
    ];

    for (const table of requiredTables) {
      const tableRegex = new RegExp(`CREATE TABLE IF NOT EXISTS ${table}`, 'i');
      assert.strictEqual(
        tableRegex.test(schemaContent),
        true,
        `La tabla ${table} debe estar definida en schema.sql`
      );
    }
  });

  it('Verifica claves foráneas y relaciones entre entidades', () => {
    const requiredForeignKeys = [
      'REFERENCES profiles(id)',
      'REFERENCES habits(id)',
      'REFERENCES check_ins(id)'
    ];

    for (const fk of requiredForeignKeys) {
      assert.strictEqual(
        schemaContent.includes(fk),
        true,
        `El esquema debe contener la clave foránea: ${fk}`
      );
    }
  });

  it('Verifica restricciones críticas de unicidad para evitar duplicados', () => {
    assert.strictEqual(
      schemaContent.includes('CONSTRAINT uq_habit_business_date UNIQUE (habit_id, business_date)'),
      true,
      'Debe existir restricción de unicidad para (habit_id, business_date) en check_ins'
    );
    assert.strictEqual(
      schemaContent.includes('CONSTRAINT uq_profile_habit_name UNIQUE (profile_id, name)'),
      true,
      'Debe existir restricción de unicidad para (profile_id, name) en habits'
    );
    assert.strictEqual(
      schemaContent.includes('CONSTRAINT uq_habit_version UNIQUE (habit_id, version)'),
      true,
      'Debe existir restricción de unicidad para (habit_id, version) en habit_revisions'
    );
    assert.strictEqual(
      schemaContent.includes('CONSTRAINT uq_check_in_version UNIQUE (check_in_id, version)'),
      true,
      'Debe existir restricción de unicidad para (check_in_id, version) en check_in_revisions'
    );
    assert.strictEqual(
      schemaContent.includes('CONSTRAINT uq_profile_operation_idempotency UNIQUE (profile_id, operation, idempotency_key)'),
      true,
      'Debe existir restricción de unicidad para idempotency keys'
    );
  });

  it('Verifica restricciones de validación CHECK de reglas de negocio', () => {
    assert.strictEqual(
      schemaContent.includes("CHECK (status IN ('active', 'paused', 'archived'))"),
      true,
      'Debe validar los estados de hábito active, paused y archived'
    );
    assert.strictEqual(
      schemaContent.includes('CHECK (target_value > 0)'),
      true,
      'La meta del hábito debe ser estrictamente positiva (RN-P12)'
    );
    assert.strictEqual(
      schemaContent.includes('CHECK (current_value >= 0)'),
      true,
      'El progreso registrado no puede ser negativo'
    );
    assert.strictEqual(
      schemaContent.includes('chk_correction_reason_required'),
      true,
      'Debe exigir motivo obligatorio de corrección para revisiones de check-in > 1'
    );
  });

  it('Los datos sintéticos no exponen contraseñas y mantienen integridad de pruebas', () => {
    const seedsContent = fs.readFileSync(seedsPath, 'utf8');
    assert.strictEqual(
      seedsContent.toLowerCase().includes('password'),
      false,
      'seeds.sql no debe contener campos o contraseñas en texto plano de usuarios'
    );
    assert.strictEqual(
      seedsContent.includes('a0000000-0000-0000-0000-000000000001'),
      true,
      'seeds.sql debe contener los identificadores sintéticos predecibles de demo'
    );
  });

  it('Docker Compose expone loopback seguro y enlaza scripts oficiales de BD', () => {
    const composeContent = fs.readFileSync(composePath, 'utf8');
    assert.strictEqual(
      composeContent.includes('127.0.0.1:5432:5432'),
      true,
      'Docker Compose debe restringir el puerto al host local (loopback)'
    );
    assert.strictEqual(
      composeContent.includes('/docker-entrypoint-initdb.d/01-schema.sql:ro'),
      true,
      'Docker Compose debe montar schema.sql en el directorio de inicio'
    );
    assert.strictEqual(
      composeContent.includes('/docker-entrypoint-initdb.d/02-seeds.sql:ro'),
      true,
      'Docker Compose debe montar seeds.sql en el directorio de inicio'
    );
  });
});
