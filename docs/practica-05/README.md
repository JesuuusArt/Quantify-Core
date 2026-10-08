# Práctica 05 – Diagrama de Roles de Usuario de Quantify Core

Este directorio contiene los entregables correspondientes a la **Práctica 05: Diagrama de Roles de Usuarios** para el Proyecto Integrador **Quantify Core**.

## 👥 Roles de Usuario Definidos

Para la plataforma de seguimiento de hábitos impulsada por IA (Quantify Core), se han identificado los siguientes roles principales:

1. **Usuario Final (Estudiante / Profesional) - Actor Principal:**
   Es la persona que utiliza la aplicación en su día a día para organizar sus rutinas, alcanzar metas y mantener constancia. Interactúa directamente con la interfaz móvil o web.

2. **Sistema (Backend / IA) - Soporte / Servicio:**
   Es el motor detrás de la aplicación. Se encarga de procesar los datos, analizar el historial del usuario para generar recomendaciones basadas en inteligencia artificial, enviar notificaciones y mantener la integridad y seguridad de la información.

3. **Administración - Actor Secundario:**
   El equipo detrás de Quantify Core. Se encarga de monitorear el uso general de la plataforma (datos agregados y anonimizados), gestionar los modelos de suscripción (Freemium/Premium), y dar mantenimiento a los modelos de IA.

---

## ⚙️ 5 Principales Funcionalidades (Features)

A continuación se describen las 5 funcionalidades principales que los usuarios realizarán en la plataforma, las cuales están representadas en el diagrama de roles:

1. **Creación y Personalización de Hábitos:**
   El usuario puede crear nuevos hábitos indicando nombre, frecuencia (ej. todos los días, 3 veces por semana) y metas específicas.
2. **Registro de Progreso Diario:**
   Permite al usuario marcar un hábito como completado en el día actual, alimentando así el sistema con datos de constancia.
3. **Consulta de Historial y Estadísticas (Rachas):**
   El usuario puede visualizar su progreso a través de gráficos y métricas (como días consecutivos completados o rachas) para mantener la motivación.
4. **Configuración de Recordatorios Inteligentes:**
   El usuario establece notificaciones que le avisen cuándo debe realizar un hábito. El sistema se encarga de enviarlos en el momento óptimo.
5. **Recepción y Aceptación de Recomendaciones de IA:**
   El sistema analiza el comportamiento del usuario y le sugiere nuevos hábitos o ajustes. El usuario puede aceptar estas sugerencias para incorporarlas a su rutina o descartarlas.

---

## 📄 Archivos en este directorio

- `diagrama-roles-quantify.html`: Diagrama interactivo de roles de usuario (basado en el diseño propuesto) con matriz de permisos.
- `HU-Recomendaciones-IA.md`: Historia de usuario detallada para una de las funcionalidades principales (Recomendaciones de IA).
- `README.md`: Este archivo descriptivo.
