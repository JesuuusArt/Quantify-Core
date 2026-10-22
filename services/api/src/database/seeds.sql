-- ==============================================================================
-- PROYECTO: Quantify Core
-- MÓDULO: Datos Sintéticos para Demostración Académica y Pruebas
-- NOTA: Datos estrictamente sintéticos; no contienen información personal real
-- ==============================================================================

-- UUIDs fijos y estables para garantizar reproducibilidad en pruebas y demostraciones
DO $$
DECLARE
    v_user1_id UUID := 'a0000000-0000-0000-0000-000000000001';
    v_user2_id UUID := 'a0000000-0000-0000-0000-000000000002';
    
    v_habit1_id UUID := 'b0000000-0000-0000-0000-000000000001';
    v_habit2_id UUID := 'b0000000-0000-0000-0000-000000000002';
    v_habit3_id UUID := 'b0000000-0000-0000-0000-000000000003';
    
    v_checkin1_id UUID := 'c0000000-0000-0000-0000-000000000001';
    v_checkin2_id UUID := 'c0000000-0000-0000-0000-000000000002';
    v_checkin3_id UUID := 'c0000000-0000-0000-0000-000000000003';
BEGIN

    -- 1. Inserción de Perfiles Sintéticos
    INSERT INTO profiles (id, keycloak_id, email, time_zone, status, roles)
    VALUES 
        (v_user1_id, 'kc-user-sub-001', 'demo.estudiante1@quantify.internal', 'America/Mexico_City', 'active', ARRAY['user']),
        (v_user2_id, 'kc-user-sub-002', 'demo.estudiante2@quantify.internal', 'America/Mexico_City', 'active', ARRAY['user'])
    ON CONFLICT (id) DO NOTHING;

    -- 2. Consentimientos Explícitos (RN-P02)
    INSERT INTO user_consents (profile_id, purpose, source, text_version, is_granted, granted_at)
    VALUES 
        (v_user1_id, 'push_notifications', 'mobile_app_v1', 'v1.0.0', TRUE, CURRENT_TIMESTAMP - INTERVAL '10 days'),
        (v_user1_id, 'ai_recommendations', 'web_onboarding_v1', 'v1.0.0', TRUE, CURRENT_TIMESTAMP - INTERVAL '10 days'),
        (v_user2_id, 'telemetry', 'mobile_app_v1', 'v1.0.0', TRUE, CURRENT_TIMESTAMP - INTERVAL '5 days')
    ON CONFLICT (profile_id, purpose, source) DO NOTHING;

    -- 3. Hábitos (RN-P03)
    -- Hábito 1: Lectura diaria (Usuario 1)
    INSERT INTO habits (id, profile_id, name, unit, time_zone, status, current_version)
    VALUES (v_habit1_id, v_user1_id, 'Lectura Técnica Diaria', 'páginas', 'America/Mexico_City', 'active', 1)
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO habit_revisions (habit_id, version, target_value, unit, weekdays, effective_from, time_zone)
    VALUES (v_habit1_id, 1, 20.00, 'páginas', ARRAY[1,2,3,4,5,6,7], '2026-10-01', 'America/Mexico_City')
    ON CONFLICT (habit_id, version) DO NOTHING;

    -- Hábito 2: Ejercicio matutino con cambio de meta versionado (Usuario 1 - RN-P04)
    INSERT INTO habits (id, profile_id, name, unit, time_zone, status, current_version)
    VALUES (v_habit2_id, v_user1_id, 'Ejercicio Matutino', 'minutos', 'America/Mexico_City', 'active', 2)
    ON CONFLICT (id) DO NOTHING;

    -- Versión 1: 30 minutos de lunes a viernes desde el 1 de octubre
    INSERT INTO habit_revisions (habit_id, version, target_value, unit, weekdays, effective_from, time_zone)
    VALUES (v_habit2_id, 1, 30.00, 'minutos', ARRAY[1,2,3,4,5], '2026-10-01', 'America/Mexico_City')
    ON CONFLICT (habit_id, version) DO NOTHING;

    -- Versión 2: Aumento de meta a 45 minutos efectivo desde el 15 de octubre
    INSERT INTO habit_revisions (habit_id, version, target_value, unit, weekdays, effective_from, time_zone)
    VALUES (v_habit2_id, 2, 45.00, 'minutos', ARRAY[1,2,3,4,5], '2026-10-15', 'America/Mexico_City')
    ON CONFLICT (habit_id, version) DO NOTHING;

    -- Hábito 3: Meditación nocturna en estado pausado (Usuario 2 - RN-P03)
    INSERT INTO habits (id, profile_id, name, unit, time_zone, status, current_version)
    VALUES (v_habit3_id, v_user2_id, 'Meditación Guiada', 'minutos', 'America/Mexico_City', 'paused', 1)
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO habit_revisions (habit_id, version, target_value, unit, weekdays, effective_from, time_zone)
    VALUES (v_habit3_id, 1, 15.00, 'minutos', ARRAY[1,2,3,4,5,6,7], '2026-10-10', 'America/Mexico_City')
    ON CONFLICT (habit_id, version) DO NOTHING;

    -- 4. Check-Ins y Revisiones Auditables (RN-P11 / RN-P13)
    -- Día 1: Lectura completa (20 páginas alcanzadas)
    INSERT INTO check_ins (id, habit_id, profile_id, business_date, time_zone, current_value, progress_status, current_version)
    VALUES (v_checkin1_id, v_habit1_id, v_user1_id, '2026-10-18', 'America/Mexico_City', 20.00, 'completed', 1)
    ON CONFLICT (habit_id, business_date) DO NOTHING;

    INSERT INTO check_in_revisions (check_in_id, version, client_event_id, value, occurred_at, recorded_at, time_zone, actor_id, origin)
    VALUES (v_checkin1_id, 1, 'd0000000-0000-0000-0000-000000000001', 20.00, '2026-10-18 21:30:00-06', '2026-10-18 21:30:05-06', 'America/Mexico_City', v_user1_id, 'manual')
    ON CONFLICT (check_in_id, version) DO NOTHING;

    -- Día 2: Lectura parcial (10 de 20 páginas)
    INSERT INTO check_ins (id, habit_id, profile_id, business_date, time_zone, current_value, progress_status, current_version)
    VALUES (v_checkin2_id, v_habit1_id, v_user1_id, '2026-10-19', 'America/Mexico_City', 10.00, 'partial', 1)
    ON CONFLICT (habit_id, business_date) DO NOTHING;

    INSERT INTO check_in_revisions (check_in_id, version, client_event_id, value, occurred_at, recorded_at, time_zone, actor_id, origin)
    VALUES (v_checkin2_id, 1, 'd0000000-0000-0000-0000-000000000002', 10.00, '2026-10-19 22:00:00-06', '2026-10-19 22:00:02-06', 'America/Mexico_City', v_user1_id, 'manual')
    ON CONFLICT (check_in_id, version) DO NOTHING;

    -- Día 3: Corrección auditable de progreso (de 12 a 25 páginas con motivo)
    INSERT INTO check_ins (id, habit_id, profile_id, business_date, time_zone, current_value, progress_status, current_version)
    VALUES (v_checkin3_id, v_habit1_id, v_user1_id, '2026-10-20', 'America/Mexico_City', 25.00, 'completed', 2)
    ON CONFLICT (habit_id, business_date) DO NOTHING;

    -- Versión 1 original
    INSERT INTO check_in_revisions (check_in_id, version, client_event_id, value, occurred_at, recorded_at, time_zone, actor_id, origin)
    VALUES (v_checkin3_id, 1, 'd0000000-0000-0000-0000-000000000003', 12.00, '2026-10-20 20:00:00-06', '2026-10-20 20:01:00-06', 'America/Mexico_City', v_user1_id, 'manual')
    ON CONFLICT (check_in_id, version) DO NOTHING;

    -- Versión 2 corregida con justificación auditable
    INSERT INTO check_in_revisions (check_in_id, version, client_event_id, value, occurred_at, recorded_at, time_zone, actor_id, origin, correction_reason)
    VALUES (v_checkin3_id, 2, 'd0000000-0000-0000-0000-000000000004', 25.00, '2026-10-20 23:15:00-06', '2026-10-20 23:15:10-06', 'America/Mexico_City', v_user1_id, 'manual', 'Completé el capítulo final antes de dormir y actualicé el total')
    ON CONFLICT (check_in_id, version) DO NOTHING;

    -- 5. Clave de Idempotencia almacenada (RN-P14)
    INSERT INTO idempotency_keys (profile_id, idempotency_key, operation, request_hash, response_status_code, response_body, expires_at)
    VALUES (
        v_user1_id,
        'idem-key-lectura-20261020',
        'record_check_in',
        'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
        200,
        '{"status": "confirmed", "checkInId": "c0000000-0000-0000-0000-000000000003", "version": 2, "value": 25.00}'::jsonb,
        CURRENT_TIMESTAMP + INTERVAL '7 days'
    )
    ON CONFLICT (profile_id, operation, idempotency_key) DO NOTHING;

    -- 6. Evento Outbox pendiente de despacho (Patrón Outbox)
    INSERT INTO outbox_events (aggregate_type, aggregate_id, event_type, payload, trace_id)
    VALUES (
        'CheckIn',
        v_checkin3_id,
        'check_in.progress_recorded',
        '{"habitId": "b0000000-0000-0000-0000-000000000001", "businessDate": "2026-10-20", "value": 25.00, "version": 2}'::jsonb,
        'trace-span-001-abc'
    );

END $$;
