-- ==============================================================================
-- PROYECTO: Quantify Core
-- MÓDULO: Persistencia Relacional Core (PostgreSQL 16)
-- TAREA: P0 - Diseñar modelo relacional de usuarios, hábitos y registros
-- ALCANCE: RF-01, RF-02, RF-03, RF-04, RNF-01, RNF-02, RNF-03
-- ==============================================================================

-- 1. Extensiones requeridas
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Función de utilidad para actualizar timestamps automáticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ==============================================================================
-- TABLA: profiles (RF-01 / RF-02)
-- Perfil interno transaccional. La autenticación y contraseñas residen en Keycloak.
-- ==============================================================================
CREATE TABLE IF NOT EXISTS profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    keycloak_id VARCHAR(64) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    time_zone VARCHAR(50) NOT NULL DEFAULT 'UTC',
    status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'suspended')),
    roles TEXT[] NOT NULL DEFAULT ARRAY['user'],
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_profile_email_format CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE TRIGGER trg_profiles_updated_at
BEFORE UPDATE ON profiles
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ==============================================================================
-- TABLA: user_consents (RF-02 / RN-P02)
-- Consentimientos explícitos granulares por finalidad y versión de texto legal.
-- ==============================================================================
CREATE TABLE IF NOT EXISTS user_consents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    purpose VARCHAR(50) NOT NULL CHECK (purpose IN ('ai_recommendations', 'biometric_data', 'push_notifications', 'telemetry')),
    source VARCHAR(50) NOT NULL,
    text_version VARCHAR(20) NOT NULL,
    is_granted BOOLEAN NOT NULL DEFAULT TRUE,
    granted_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    revoked_at TIMESTAMPTZ,
    CONSTRAINT chk_consent_revocation_coherence CHECK (
        (is_granted = TRUE AND revoked_at IS NULL) OR
        (is_granted = FALSE AND revoked_at IS NOT NULL)
    ),
    CONSTRAINT uq_profile_purpose_source UNIQUE (profile_id, purpose, source)
);

CREATE INDEX idx_user_consents_profile ON user_consents(profile_id, purpose);

-- ==============================================================================
-- TABLA: habits (RF-03 / RN-P03)
-- Entidad cabecera del hábito. El historial se conserva aún archivado.
-- ==============================================================================
CREATE TABLE IF NOT EXISTS habits (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    name VARCHAR(60) NOT NULL CHECK (char_length(trim(name)) >= 3),
    unit VARCHAR(30) NOT NULL CHECK (char_length(trim(unit)) >= 1),
    time_zone VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'paused', 'archived')),
    current_version INT NOT NULL DEFAULT 1 CHECK (current_version >= 1),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_profile_habit_name UNIQUE (profile_id, name)
);

CREATE TRIGGER trg_habits_updated_at
BEFORE UPDATE ON habits
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE INDEX idx_habits_profile_status ON habits(profile_id, status);

-- ==============================================================================
-- TABLA: habit_revisions (RF-03 / RN-P04)
-- Historial inmutable de configuración de metas, unidades y frecuencias por vigencia.
-- ==============================================================================
CREATE TABLE IF NOT EXISTS habit_revisions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    habit_id UUID NOT NULL REFERENCES habits(id) ON DELETE CASCADE,
    version INT NOT NULL CHECK (version >= 1),
    target_value NUMERIC(10,2) NOT NULL CHECK (target_value > 0),
    unit VARCHAR(30) NOT NULL,
    weekdays INT[] NOT NULL CHECK (
        cardinality(weekdays) >= 1 AND 
        cardinality(weekdays) <= 7 AND
        weekdays <@ ARRAY[1,2,3,4,5,6,7]
    ),
    effective_from DATE NOT NULL,
    time_zone VARCHAR(50) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_habit_version UNIQUE (habit_id, version)
);

CREATE INDEX idx_habit_revisions_lookup ON habit_revisions(habit_id, effective_from DESC);

-- ==============================================================================
-- TABLA: check_ins (RF-04 / RN-P11 / RN-P13)
-- Consolidado diario de avance por hábito y fecha de negocio.
-- ==============================================================================
CREATE TABLE IF NOT EXISTS check_ins (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    habit_id UUID NOT NULL REFERENCES habits(id) ON DELETE CASCADE,
    profile_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    business_date DATE NOT NULL,
    time_zone VARCHAR(50) NOT NULL,
    current_value NUMERIC(10,2) NOT NULL DEFAULT 0.00 CHECK (current_value >= 0),
    progress_status VARCHAR(20) NOT NULL DEFAULT 'zero' CHECK (progress_status IN ('zero', 'partial', 'completed')),
    current_version INT NOT NULL DEFAULT 1 CHECK (current_version >= 1),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_habit_business_date UNIQUE (habit_id, business_date)
);

CREATE TRIGGER trg_check_ins_updated_at
BEFORE UPDATE ON check_ins
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE INDEX idx_check_ins_habit_date ON check_ins(habit_id, business_date);
CREATE INDEX idx_check_ins_profile_date ON check_ins(profile_id, business_date);

-- ==============================================================================
-- TABLA: check_in_revisions (RF-04 / RN-P06 / RN-P11)
-- Registro auditable inmutable de cada evento de progreso y corrección.
-- ==============================================================================
CREATE TABLE IF NOT EXISTS check_in_revisions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    check_in_id UUID NOT NULL REFERENCES check_ins(id) ON DELETE CASCADE,
    version INT NOT NULL CHECK (version >= 1),
    client_event_id UUID NOT NULL,
    value NUMERIC(10,2) NOT NULL CHECK (value >= 0),
    occurred_at TIMESTAMPTZ NOT NULL,
    recorded_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    time_zone VARCHAR(50) NOT NULL,
    actor_id UUID NOT NULL REFERENCES profiles(id),
    origin VARCHAR(30) NOT NULL DEFAULT 'manual' CHECK (origin IN ('manual', 'device', 'sync', 'admin')),
    correction_reason TEXT,
    CONSTRAINT uq_check_in_version UNIQUE (check_in_id, version),
    CONSTRAINT chk_correction_reason_required CHECK (
        (version = 1) OR 
        (version > 1 AND correction_reason IS NOT NULL AND char_length(trim(correction_reason)) > 0)
    )
);

CREATE INDEX idx_check_in_revisions_checkin ON check_in_revisions(check_in_id, version);
CREATE INDEX idx_check_in_revisions_client_event ON check_in_revisions(client_event_id);

-- ==============================================================================
-- TABLA: idempotency_keys (RNF-02 / RN-P14)
-- Garantiza idempotencia en peticiones de escritura y reintentos offline.
-- ==============================================================================
CREATE TABLE IF NOT EXISTS idempotency_keys (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    idempotency_key VARCHAR(128) NOT NULL,
    operation VARCHAR(50) NOT NULL,
    request_hash VARCHAR(64) NOT NULL,
    response_status_code INT NOT NULL,
    response_body JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMPTZ NOT NULL,
    CONSTRAINT uq_profile_operation_idempotency UNIQUE (profile_id, operation, idempotency_key),
    CONSTRAINT chk_idempotency_expiry CHECK (expires_at > created_at)
);

CREATE INDEX idx_idempotency_lookup ON idempotency_keys(profile_id, operation, idempotency_key);
CREATE INDEX idx_idempotency_expiry ON idempotency_keys(expires_at);

-- ==============================================================================
-- TABLA: outbox_events (RNF-02 / Arquitectura Outbox)
-- Eventos transaccionales para publicación asíncrona hacia workers y analítica.
-- ==============================================================================
CREATE TABLE IF NOT EXISTS outbox_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    aggregate_type VARCHAR(50) NOT NULL,
    aggregate_id UUID NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    payload JSONB NOT NULL,
    trace_id VARCHAR(64),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    published_at TIMESTAMPTZ
);

CREATE INDEX idx_outbox_unpublished ON outbox_events(created_at) WHERE published_at IS NULL;
