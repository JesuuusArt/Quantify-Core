# Práctica 07 — Diagrama de secuencia o navegación de sketches del proyecto integrador

**Proyecto integrador:** Quantify Core  
**Universidad:** Universidad Tecnológica de Xicotepec de Juárez  
**Cuatrimestre:** 10°  
**Grupo:** A

## 1. Introducción

Quantify Core es una aplicación web y móvil orientada a la creación, el seguimiento y la mejora de hábitos personales. Su propuesta incluye el registro de avances diarios, la consulta de estadísticas, la configuración de recordatorios y las recomendaciones de hábitos mediante inteligencia artificial.

Esta práctica plantea la documentación de la secuencia de interacción y la navegación entre los **sketches**, entendidos como bocetos de las pantallas de la aplicación. El propósito es definir cómo se desplaza el usuario por las funciones principales antes de desarrollar las interfaces.

## 2. Objetivo

Representar el recorrido del usuario entre los sketches de Quantify Core, identificando las pantallas, las acciones que permiten pasar de una a otra y las respuestas esperadas del sistema, para establecer una navegación clara y coherente con las funcionalidades del proyecto integrador.

## 3. Alcance de la práctica

La propuesta de navegación se centra en el usuario final y contempla los siguientes recorridos:

- Acceder a la aplicación mediante el inicio de sesión o el registro de una cuenta.
- Crear y personalizar un hábito.
- Registrar el progreso diario de un hábito.
- Consultar el historial, las rachas y las estadísticas personales.
- Configurar recordatorios.
- Consultar, aceptar o descartar recomendaciones de hábitos por IA.

Las pantallas y transiciones descritas a continuación son una **propuesta de diseño**; no representan funcionalidades implementadas ni sketches terminados.

## 4. Sketches propuestos

| ID    | Pantalla / Sketch        | Propósito                                                            | Acciones principales                                                                  |
| ----- | ------------------------ | -------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| SK-01 | Bienvenida               | Presentar la aplicación y sus opciones de acceso.                    | Iniciar sesión o crear una cuenta.                                                    |
| SK-02 | Registro                 | Capturar los datos necesarios para crear una cuenta.                 | Enviar datos, corregir errores o volver al acceso.                                    |
| SK-03 | Inicio de sesión         | Permitir el acceso del usuario a su cuenta.                          | Enviar credenciales o regresar a bienvenida.                                          |
| SK-04 | Inicio / Mis hábitos     | Mostrar los hábitos y el avance del día.                             | Crear un hábito, abrir su detalle o acceder a estadísticas, recomendaciones y perfil. |
| SK-05 | Crear / Editar hábito    | Definir el nombre, la categoría, la frecuencia y la meta del hábito. | Guardar cambios o cancelar.                                                           |
| SK-06 | Detalle del hábito       | Mostrar la información y el progreso de un hábito.                   | Registrar avance, editar el hábito o configurar recordatorios.                        |
| SK-07 | Historial y estadísticas | Mostrar el progreso, las rachas y la constancia del usuario.         | Consultar periodos y regresar al inicio.                                              |
| SK-08 | Recordatorios            | Configurar los días y horarios de aviso de un hábito.                | Guardar la configuración o cancelar.                                                  |
| SK-09 | Recomendaciones por IA   | Presentar sugerencias de hábitos según la actividad del usuario.     | Revisar, aceptar o descartar una sugerencia.                                          |
| SK-10 | Perfil y ajustes         | Consultar y modificar preferencias de la cuenta.                     | Guardar preferencias o cerrar sesión.                                                 |

## 5. Secuencia de navegación propuesta

### 5.1. Acceso a la aplicación

1. El usuario abre la aplicación y visualiza **Bienvenida (SK-01)**.
2. Si no tiene una cuenta, selecciona la opción de registro y accede a **Registro (SK-02)**.
3. Al completar el registro, continúa a **Inicio de sesión (SK-03)**.
4. El usuario ingresa sus credenciales y el sistema valida la información.
5. Si el acceso es correcto, se muestra **Inicio / Mis hábitos (SK-04)**. Si ocurre un error, permanece en el formulario con un mensaje que le permite corregirlo.

### 5.2. Creación y personalización de un hábito

1. Desde **Inicio / Mis hábitos (SK-04)**, el usuario selecciona crear un hábito.
2. La aplicación abre **Crear / Editar hábito (SK-05)**.
3. El usuario captura el nombre, la categoría, la frecuencia y la meta.
4. Al guardar, el sistema valida los campos y confirma el registro.
5. La aplicación regresa a **Inicio / Mis hábitos (SK-04)** y muestra el nuevo hábito. Si hay datos inválidos, mantiene el formulario para corregirlos.

### 5.3. Registro del progreso diario

1. El usuario selecciona un hábito desde **Inicio / Mis hábitos (SK-04)**.
2. La aplicación muestra **Detalle del hábito (SK-06)**.
3. El usuario registra su avance del día.
4. El sistema guarda el registro y actualiza el progreso mostrado.
5. El usuario puede regresar al inicio o consultar **Historial y estadísticas (SK-07)** para revisar sus resultados.

### 5.4. Configuración de recordatorios

1. Desde **Detalle del hábito (SK-06)**, el usuario abre **Recordatorios (SK-08)**.
2. Selecciona los días y horarios de aviso.
3. Al guardar, el sistema valida y confirma la configuración.
4. La aplicación regresa al detalle del hábito. Si el usuario cancela, vuelve sin aplicar cambios.

### 5.5. Recomendaciones de hábitos por IA

1. Desde **Inicio / Mis hábitos (SK-04)**, el usuario accede a **Recomendaciones por IA (SK-09)**.
2. El sistema presenta las sugerencias disponibles y una explicación de cada recomendación.
3. Si el usuario acepta una sugerencia, se abre **Crear / Editar hábito (SK-05)** con los datos propuestos para revisarlos y personalizarlos.
4. El hábito se incorpora a la lista únicamente después de que el usuario confirma su creación.
5. Si descarta la sugerencia, permanece en recomendaciones. Si no hay sugerencias disponibles, se muestra un mensaje informativo y la opción de volver al inicio.

## 6. Criterios para el diagrama y los sketches

- Identificar cada pantalla con el mismo código y nombre utilizados en este documento.
- Indicar en cada conexión la acción que provoca la navegación, como **Iniciar sesión**, **Guardar**, **Cancelar** o **Ver estadísticas**.
- Representar las decisiones relevantes: acceso válido o inválido, datos completos o incompletos y aceptación o descarte de recomendaciones.
- Mostrar las opciones de regreso y cancelación para evitar pantallas sin salida.
- Distinguir las acciones del usuario de las validaciones y respuestas del sistema.
- Contemplar estados de carga, ausencia de datos y errores al guardar, conservando la información capturada cuando sea posible.
- Mantener consistencia en los controles y nombres de las pantallas de las versiones web y móvil.

## 7. Entregables previstos

| Entregable                         | Descripción                                                                     | Estado                       |
| ---------------------------------- | ------------------------------------------------------------------------------- | ---------------------------- |
| README de la práctica              | Objetivo, alcance, inventario de pantallas y recorridos propuestos.             | Documentado en este archivo. |
| Sketches de las pantallas          | Bocetos de las interfaces incluidas en el alcance.                              | Pendiente de elaboración.    |
| Diagrama de secuencia o navegación | Representación visual de las conexiones, acciones y decisiones entre pantallas. | Pendiente de elaboración.    |

## 8. Relación con las funcionalidades del proyecto

Esta práctica retoma las funcionalidades descritas en la [Práctica 05: Roles de usuario y funcionalidades principales](../practica-05/README.md) y las traduce en recorridos de interfaz. La funcionalidad de recomendaciones también cuenta con una [historia de usuario de referencia](../practica-05/HU-Recomendaciones-IA.md).

La navegación propuesta servirá como base para elaborar los sketches y su diagrama, revisar la continuidad de los flujos y orientar el posterior desarrollo de las interfaces de Quantify Core.
