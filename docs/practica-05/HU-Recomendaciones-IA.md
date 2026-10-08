# HU-QC-05 — Recomendaciones de Hábitos por IA

## 1. Identificación

| Campo | Definición |
|---|---|
| Código | HU-QC-05 |
| Título | Recomendaciones de Hábitos por IA |
| Versión | 1.0 |
| Estado | Propuesta para análisis |
| Prioridad sugerida | Alta: Core de la propuesta de valor de Quantify Core |
| Módulo | Asistente IA / Seguimiento |

## 2. Historia de usuario

**Como** usuario activo de Quantify Core, **quiero** recibir sugerencias personalizadas de nuevos hábitos basadas en mi historial y rutinas actuales, **para** mejorar progresivamente mi estilo de vida sin tener que pensar en qué hábito implementar a continuación.

## 3. Contexto y descripción

El diferenciador clave de Quantify Core es la capacidad de ayudar a los usuarios no solo a registrar lo que ya hacen, sino a descubrir qué más podrían hacer para mejorar. La Inteligencia Artificial analizará patrones (ej. un usuario que registra hacer ejercicio constantemente por la tarde podría recibir la sugerencia de "Tomar un batido de proteínas" o "Hacer estiramientos de 10 min").

## 4. Actores, precondiciones y disparador

### Actores

- **Actor principal:** Usuario (Estudiante / Profesional).
- **Sistema IA (Soporte):** Analiza datos y genera la recomendación.
- **Administración (Secundario):** Monitorea métricas agregadas sobre qué tan efectivas son las recomendaciones.

### Precondiciones

1. El usuario debe tener al menos 1 semana de datos registrados en la app para generar una sugerencia con sentido.
2. El usuario debe haber aceptado los términos de análisis de datos para IA.

### Disparador

El sistema detecta un patrón consolidado (racha de varios días) y notifica al usuario con una nueva "Sugerencia Inteligente" en la pantalla de inicio.

## 5. Criterios de Aceptación

### CA-01 — Generación de la sugerencia
**Dado** que el usuario ha usado la app por 7 días seguidos, **cuando** ingresa al Dashboard, **entonces** ve una tarjeta de "Sugerencia Inteligente" destacada.

### CA-02 — Aceptación de la sugerencia
**Dado** que el usuario lee la sugerencia, **cuando** presiona "Añadir a mi rutina", **entonces** el hábito se agrega automáticamente a su lista diaria con parámetros predeterminados modificables.

### CA-03 — Rechazo de la sugerencia
**Dado** que el usuario no está interesado, **cuando** presiona "Descartar", **entonces** la sugerencia desaparece y el sistema IA registra la negativa para no sugerir algo similar pronto.
