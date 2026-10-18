/* Inventario, conexiones y reglas: compartidos por el visor, el mapa y el inspector. */
window.QC = (() => {
  const rule = (id, title, text) => ({ id, title, text });
  const rules = [
    rule('RN01', 'Un rol, un alcance', 'El usuario gestiona su rutina. Administración opera catálogos, accesos y métricas agregadas; no consulta registros personales.'),
    rule('RN02', 'Acceso y verificación', 'Acceso simulado con cuentas de ejemplo. Registro y recuperación usan el código demo 123456. Nunca se guardan contraseñas en el navegador.'),
    rule('RN03', 'Hábito válido', 'Nombre de 3 a 60 caracteres, meta mayor que cero y al menos un día. No se permiten nombres activos duplicados, sin distinguir acentos ni mayúsculas.'),
    rule('RN04', 'Un registro por día', 'El avance se actualiza por hábito y fecha, hasta la meta. Completar dos veces no suma dos cumplimientos. Solo se edita el día de ejemplo.'),
    rule('RN05', 'Rachas y cumplimiento', 'La racha cuenta días programados cumplidos; los días no programados no la interrumpen. El cumplimiento diario usa solo hábitos activos programados.'),
    rule('RN06', 'Archivar conserva el historial', 'Archivar requiere confirmación. Retira el hábito de la rutina activa, conserva sus registros y bloquea nuevas marcas.'),
    rule('RN07', 'Recordatorios voluntarios', 'El horario requiere formato válido y al menos un día del hábito. Desactivar avisos no cambia el avance. En esta demo no se envían notificaciones reales.'),
    rule('RN08', 'IA con consentimiento', 'Las sugerencias requieren consentimiento y 7 días con registros. Máximo 2 pendientes y confianza mínima de 80%, configurable hacia arriba.'),
    rule('RN09', 'Aceptar es una decisión', 'La sugerencia se vuelve hábito solo al guardar el formulario. No duplica nombres activos ni archivados en los últimos 30 días. Descartar la oculta por 21 días.'),
    rule('RN10', 'Catálogo independiente', 'Pausar una plantilla o recomendación exige motivo y confirmación. Afecta nuevas sugerencias; los hábitos ya creados permanecen intactos.'),
    rule('RN11', 'Cambios trazables', 'Toda modificación administrativa registra fecha, entidad, acción y motivo en la auditoría local, sin controles para editar o borrar eventos.'),
    rule('RN12', 'Accesos controlados', 'Solo se administran cuentas de ejemplo identificadas por código. Suspender o reactivar exige motivo; la cuenta del administrador actual no puede suspenderse.'),
    rule('RN13', 'Mismos recorridos', 'Móvil y PWA comparten pantallas, acciones y reglas. Cambiar el formato conserva la pantalla, los datos y los formularios en curso.')
  ];
  const s = (id, title, group, description, ids, edges) => ({id,title,group,description,rules:ids,edges:edges.map(([to,label,kind])=>({to,label,kind:kind||'navigate'}))});
  const user = [
    s('U01','Bienvenida','Acceso','Presentación del seguimiento de hábitos y acceso a una rutina más consciente.',['RN02','RN13'],[['U02','Iniciar sesión'],['U03','Crear cuenta']]),
    s('U02','Iniciar sesión','Acceso','Validar las credenciales de ejemplo y continuar a la rutina.',['RN02'],[['U06','Credenciales válidas'],['U02','Credenciales inválidas','state'],['U03','Crear cuenta'],['U04','Olvidé mi contraseña'],['U05','Continuar verificación pendiente'],['U01','Volver']]),
    s('U03','Crear cuenta','Acceso','Capturar los datos y aceptar las condiciones antes de verificar la cuenta.',['RN02'],[['U05','Datos válidos'],['U03','Corregir datos','state'],['U02','Ya tengo cuenta']]),
    s('U04','Recuperar acceso','Acceso','Iniciar una recuperación simulada sin enviar correos.',['RN02'],[['U05','Solicitar código demo'],['U02','Cancelar']]),
    s('U05','Verificar código','Acceso','Verificación demostrativa del registro o de una recuperación.',['RN02'],[['U06','Código válido · registro'],['U15','Código válido · recuperación'],['U05','Código inválido o reenviar','state'],['U02','Cancelar']]),
    s('U06','Hoy / Mis hábitos','Rutina','Visualizar el progreso y los hábitos programados para el día de ejemplo.',['RN04','RN05'],[['U07','Nuevo hábito'],['U08','Abrir hábito'],['U06','Completar o deshacer','state'],['U14','Ver avisos'],['U10','Análisis'],['U11','IA Coach'],['U12','Ajustes']]),
    s('U07','Crear / editar hábito','Rutina','Personalizar la meta, la frecuencia y el color, con validación antes de guardar.',['RN03','RN09'],[['U08','Guardar válido'],['U07','Datos inválidos','state'],['U06','Cancelar creación'],['U08','Cancelar edición']]),
    s('U08','Detalle del hábito','Rutina','Registrar avances parciales, completar el día o revisar la racha.',['RN04','RN05','RN06'],[['U07','Editar'],['U09','Recordatorio'],['U13','Archivar'],['U08','Guardar avance o deshacer','state'],['U10','Ver análisis'],['U06','Volver a Hoy']]),
    s('U09','Recordatorio','Rutina','Definir días y horario de un aviso simulado para el hábito seleccionado.',['RN07'],[['U08','Guardar o cancelar'],['U09','Corregir horario o días','state']]),
    s('U10','Análisis y rachas','Seguimiento','Consultar resultados calculados con los registros locales de ejemplo.',['RN05','RN06'],[['U10','Cambiar periodo','state'],['U08','Ver hábito'],['U06','Hoy'],['U11','IA Coach'],['U12','Ajustes']]),
    s('U11','IA Coach','Seguimiento','Recomendaciones explicables con consentimiento, umbral y control de duplicados.',['RN08','RN09','RN10'],[['U07','Personalizar sugerencia'],['U11','Descartar por 21 días','state'],['U12','Cambiar consentimiento'],['U06','Hoy'],['U10','Análisis'],['U12','Ajustes']]),
    s('U12','Perfil y ajustes','Cuenta','Preferencias de privacidad y avisos. Solo se conservan datos de demostración.',['RN02','RN07','RN08'],[['U12','Guardar preferencias','state'],['U14','Ver avisos'],['U02','Cerrar sesión'],['U06','Hoy'],['U10','Análisis'],['U11','IA Coach']]),
    s('U13','Archivar hábito','Rutina','Confirmar una acción que conserva los registros históricos.',['RN06'],[['U06','Confirmar archivo'],['U08','Cancelar']]),
    s('U14','Centro de avisos','Cuenta','Avisos locales de ejemplo con estado leído y acceso al hábito asociado.',['RN07'],[['U08','Abrir hábito asociado'],['U14','Marcar como leído','state'],['U12','Preferencias'],['U06','Volver']]),
    s('U15','Nueva contraseña','Acceso','Completar la recuperación simulada. La nueva clave vive solo en memoria.',['RN02'],[['U02','Guardar clave válida'],['U15','Corregir clave','state']])
  ];
  const admin = [
    s('A01','Acceso administrador','Acceso','Entrada de demostración para personal autorizado; sin registro público.',['RN01','RN02'],[['A02','Credenciales demo válidas'],['A01','Acceso denegado','state']]),
    s('A02','Resumen operativo','Operación','Indicadores agregados ilustrativos, estado de servicios y accesos a los módulos.',['RN01'],[['A03','Ver catálogo'],['A05','Supervisar IA'],['A06','Auditoría'],['A07','Cuentas'],['A08','Configuración']]),
    s('A03','Catálogo de hábitos','Operación','Gestionar plantillas sin modificar las rutinas personales existentes.',['RN10','RN11'],[['A04','Crear o editar plantilla'],['A03','Confirmar pausa o reactivación','state'],['A02','Resumen'],['A05','IA'],['A06','Auditoría'],['A07','Cuentas'],['A08','Configuración']]),
    s('A04','Editar plantilla','Operación','Validar nombre, categoría y meta antes de guardar y auditar la modificación.',['RN03','RN10','RN11'],[['A03','Guardar o cancelar'],['A04','Corregir datos','state'],['A05','Abrir IA']]),
    s('A05','Supervisión de IA','Operación','Revisar tasas de aceptación ilustrativas y pausar propuestas con un motivo.',['RN08','RN10','RN11'],[['A05','Confirmar pausa o reactivación','state'],['A02','Resumen'],['A03','Catálogo'],['A06','Ver auditoría'],['A07','Cuentas'],['A08','Configuración']]),
    s('A06','Auditoría','Control','Consultar cambios administrativos registrados en esta demostración.',['RN11'],[['A06','Filtrar eventos','state'],['A02','Resumen'],['A03','Catálogo'],['A05','IA'],['A07','Cuentas'],['A08','Configuración']]),
    s('A07','Control de accesos','Control','Administrar el estado de cuentas ficticias identificadas por códigos.',['RN01','RN12'],[['A09','Cambiar estado de cuenta'],['A02','Resumen'],['A03','Catálogo'],['A05','IA'],['A06','Auditoría'],['A08','Configuración']]),
    s('A08','Configuración global','Control','Ajustar límites de sugerencias respetando el mínimo de confianza y auditar cambios.',['RN08','RN11'],[['A08','Validar y guardar','state'],['A02','Resumen'],['A03','Catálogo'],['A05','IA'],['A06','Auditoría'],['A07','Cuentas'],['A01','Cerrar sesión']]),
    s('A09','Confirmar cambio de acceso','Control','Confirmar suspensión o reactivación con un motivo obligatorio.',['RN11','RN12'],[['A07','Confirmar o cancelar'],['A09','Motivo incompleto','state']])
  ];
  return {rules,screens:{usuario:user,admin},date:'2026-10-14'};
})();
