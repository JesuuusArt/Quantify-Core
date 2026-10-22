-- ==============================================================================
-- PROYECTO: Quantify Core
-- MÓDULO: Pruebas de Integridad de Base de Datos (PostgreSQL)
-- OBJETIVO: Verificar formalmente claves primarias, foráneas, restricciones UNIQUE,
--           validaciones CHECK y reglas de negocio del modelo relacional.
-- ==============================================================================

\set ON_ERROR_STOP on

SELECT '--- INICIANDO SUITE DE VERIFICACIÓN DE INTEGRIDAD SQL ---' AS test_banner;

-- 1. VERIFICACIÓN DE ESTRUCTURA Y CONTEO DE TABLAS
DO $$
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count FROM profiles;
    ASSERT v_count >= 2, 'FALLO: Se esperaban al menos 2 perfiles creados';
    
    SELECT COUNT(*) INTO v_count FROM habits;
    ASSERT v_count >= 3, 'FALLO: Se esperaban al menos 3 hábitos creados';
    
    SELECT COUNT(*) INTO v_count FROM habit_revisions;
    ASSERT v_count >= 4, 'FALLO: Se esperaban al menos 4 revisiones de hábitos creadas';
    
    SELECT COUNT(*) INTO v_count FROM check_ins;
    ASSERT v_count >= 3, 'FALLO: Se esperaban al menos 3 check-ins creados';
    
    SELECT COUNT(*) INTO v_count FROM check_in_revisions;
    ASSERT v_count >= 4, 'FALLO: Se esperaban al menos 4 revisiones de check-in';

    RAISE NOTICE 'PRUEBA 1 EXITOSA: Tablas base y semillas existen con registros válidos.';
END $$;

-- 2. PRUEBA NEGATIVA: RESTRICCIÓN DE UNICIDAD EN CHECK-IN (habit_id, business_date)
DO $$
BEGIN
    -- Intentar insertar un segundo check-in para el mismo hábito y la misma fecha (2026-10-18)
    BEGIN
        INSERT INTO check_ins (habit_id, profile_id, business_date, time_zone, current_value, progress_status)
        VALUES ('b0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000001', '2026-10-18', 'America/Mexico_City', 15.00, 'partial');
        
        RAISE EXCEPTION 'FALLO: La base de datos permitió duplicar un check-in para la misma fecha de negocio';
    EXCEPTION WHEN unique_violation THEN
        RAISE NOTICE 'PRUEBA 2 EXITOSA: La restricción uq_habit_business_date impidió duplicar el check-in diario.';
    END;
END $$;

-- 3. PRUEBA NEGATIVA: VALOR DE META INVÁLIDO (CHECK target_value > 0)
DO $$
BEGIN
    BEGIN
        INSERT INTO habit_revisions (habit_id, version, target_value, unit, weekdays, effective_from, time_zone)
        VALUES ('b0000000-0000-0000-0000-000000000001', 99, 0.00, 'páginas', ARRAY[1,2,3], '2026-11-01', 'America/Mexico_City');
        
        RAISE EXCEPTION 'FALLO: Se permitió registrar una meta menor o igual a cero';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'PRUEBA 3 EXITOSA: La restricción CHECK impidió una meta no positiva (RN-P12).';
    END;
END $$;

-- 4. PRUEBA NEGATIVA: CORRECCIÓN AUDITABLE SIN MOTIVO (CHECK chk_correction_reason_required)
DO $$
BEGIN
    BEGIN
        INSERT INTO check_in_revisions (check_in_id, version, client_event_id, value, occurred_at, time_zone, actor_id, origin, correction_reason)
        VALUES ('c0000000-0000-0000-0000-000000000001', 2, gen_random_uuid(), 25.00, NOW(), 'America/Mexico_City', 'a0000000-0000-0000-0000-000000000001', 'manual', NULL);
        
        RAISE EXCEPTION 'FALLO: Se permitió crear versión 2 de check-in sin justificación de corrección';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'PRUEBA 4 EXITOSA: La restricción CHECK exigió motivo obligatorio para la corrección (RN-P13).';
    END;
END $$;

-- 5. PRUEBA NEGATIVA: CLAVE FORÁNEA INVÁLIDA (REFERENTIAL INTEGRITY)
DO $$
BEGIN
    BEGIN
        INSERT INTO habits (profile_id, name, unit, time_zone)
        VALUES ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Hábito Huérfano', 'repeticiones', 'UTC');
        
        RAISE EXCEPTION 'FALLO: Se permitió crear un hábito vinculado a un perfil inexistente';
    EXCEPTION WHEN foreign_key_violation THEN
        RAISE NOTICE 'PRUEBA 5 EXITOSA: La clave foránea protegió la integridad referencial frente a perfiles inexistentes.';
    END;
END $$;

-- 6. PRUEBA NEGATIVA: DIAS DE LA SEMANA INVÁLIDOS (CHECK weekdays <@ ARRAY[1..7])
DO $$
BEGIN
    BEGIN
        INSERT INTO habit_revisions (habit_id, version, target_value, unit, weekdays, effective_from, time_zone)
        VALUES ('b0000000-0000-0000-0000-000000000001', 98, 10.00, 'páginas', ARRAY[0, 8], '2026-11-01', 'America/Mexico_City');
        
        RAISE EXCEPTION 'FALLO: Se permitieron días de la semana fuera del rango 1..7';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'PRUEBA 6 EXITOSA: La validación de array de días de la semana rechazó valores fuera de rango.';
    END;
END $$;

-- 7. CONSULTA DE DEMOSTRACIÓN: RELACIÓN COMPLETA HÁBITO -> VERSIÓN VIGENTE -> REGISTROS
SELECT 
    p.email AS usuario,
    h.name AS habito,
    h.status AS estado_habito,
    hr.target_value AS meta_vigente,
    hr.unit AS unidad,
    c.business_date AS fecha_registro,
    c.current_value AS avance_reportado,
    c.progress_status AS estado_cumplimiento,
    c.current_version AS revision_actual
FROM profiles p
JOIN habits h ON h.profile_id = p.id
JOIN habit_revisions hr ON hr.habit_id = h.id AND hr.version = h.current_version
LEFT JOIN check_ins c ON c.habit_id = h.id
ORDER BY p.email, h.name, c.business_date;

SELECT '--- TODAS LAS PRUEBAS DE INTEGRIDAD SE EJECUTARON EXITOSAMENTE ---' AS resultado_final;
