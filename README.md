<h1 align="center">Quantify Core</h1>

<p align="center">
  <img src="assets/images/quantifyLogo.jpeg" alt="Quantify Core Logo" width="180"/>
</p>

<p align="center">
  <em>El motor inteligente para el seguimiento, análisis y optimización de hábitos impulsado por IA.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Estado-En%20desarrollo-yellow" alt="Estado"/>
  <img src="https://img.shields.io/badge/Versión-0.1.0-blue" alt="Versión"/>
  <img src="https://img.shields.io/badge/Grupo-A-success" alt="Grupo"/>
</p>

---

## Sitio del proyecto (GitHub Pages)

<p align="center">
  <a href="https://jesuuusart.github.io/Quantify-Core/">
    <img src="https://img.shields.io/badge/Ver%20sitio%20del%20proyecto-1E54C9?style=for-the-badge&logo=github&logoColor=white" alt="Sitio del proyecto"/>
  </a>
</p>

<p align="center">
  Página principal del proyecto: <a href="https://jesuuusart.github.io/Quantify-Core/"><strong>Página principal del proyecto</strong></a><br/>
  Práctica 04: <a href="https://jesuuusart.github.io/Quantify-Core/Practica04/business-model-canvas.html"><strong>Página de la Práctica 04</strong></a><br/>
  Práctica 05: <a href="https://jesuuusart.github.io/Quantify-Core/Practica05/diagrama-roles-usuario.html"><strong>Página de la Práctica 05</strong></a>
</p>

---

## Stack tecnológico y propuesta arquitectónica

Quantify Core contempla una arquitectura multiplataforma distribuida orientada a clientes **Web y Móvil**, respaldada por microservicios en backend, un esquema de persistencia políglota, servicios cognitivos de Inteligencia Artificial y un flujo de despliegue contenerizado. A continuación se detalla la matriz técnica del proyecto:

| Capa / Dimensión | Tecnologías | Rol y justificación en la arquitectura |
|---|---|---|
| **Frontend Móvil** | Flutter (Dart) | Aplicación móvil nativa multiplataforma (Android e iOS) para el usuario final. Provee interacción táctil fluida, micro-interacciones hápticas, sincronización offline y notificaciones push. |
| **Frontend Web** | React (Vite / Next.js) | Panel administrativo (Backoffice) y cliente web de autoservicio para consulta de analíticas avanzadas, métricas institucionales y gestión de cuentas. |
| **Hosting Web** | Vercel | Plataforma de despliegue continuo (CI/CD) para el frontend web, conectada al repositorio de GitHub con optimización automática de assets y soporte de dominio seguro (SSL). |
| **Backend API** | Node.js (Express / NestJS) | API REST centralizada y servicios asíncronos para lógica de negocio, calendarización de alertas, control de sesiones JWT y comunicación con modelos de IA. |
| **Bases de Datos** | MySQL y MongoDB | Persistencia híbrida: **MySQL** para integridad transaccional ACID (cuentas, suscripciones y roles) y **MongoDB** para telemetría diaria, historial de hábitos y bitácoras no estructuradas. |
| **Inteligencia Artificial** | API LLM (Google Gemini / OpenAI) | Motor generativo de inferencia para análisis de consistencia, sugerencias adaptativas de nuevos hábitos y explicabilidad en lenguaje natural. |
| **Autenticación** | Google OAuth 2.0 + JWT | Inicio de sesión unificado con Google Sign-In en móvil y web, validado en backend con emisión de tokens JWT propios de la plataforma. |
| **Entornos y Contenedores** | Docker y Docker Compose | Estandarización de entornos de desarrollo y producción; orquestación local de backend y bases de datos con scripts reproducibles para la materia. |
| **Gestión y Versiones** | GitHub y Jira | **GitHub** como repositorio central, branching model y pipelines de integración; **Jira** para gestión de sprints ágiles, historias de usuario e incidencias (Scrum). |

## Descripción

**Quantify Core** es una aplicación multiplataforma (web y móvil) diseñada para ayudar a las personas a construir, mantener y mejorar sus hábitos diarios. A través de un seguimiento inteligente y el apoyo de inteligencia artificial, los usuarios pueden:

- Crear y personalizar hábitos según metas específicas.
- Dar seguimiento continuo al progreso diario y rachas de cumplimiento.
- Recibir recomendaciones de nuevos hábitos basadas en sus rutinas actuales.
- Reforzar la constancia mediante recordatorios contextuales y análisis de comportamiento.

## Objetivo del proyecto

Facilitar que cualquier persona pueda convertir sus metas en hábitos sostenibles, empleando tecnología e inteligencia artificial como herramientas para mantener la motivación y cuantificar el progreso real.

## Características principales

| Característica | Descripción |
|---|---|
| Seguimiento de hábitos | Registro diario con rachas, estadísticas e historial detallado. |
| IA de recomendaciones | Sugerencias de nuevos hábitos basadas en la actividad y consistencia del usuario. |
| Multiplataforma | Disponible como aplicación web y aplicación móvil (Android e iOS). |
| Recordatorios inteligentes | Notificaciones adaptadas a las rutinas y momentos óptimos del día. |
| Análisis y métricas | Visualización del progreso personal para reforzar la constancia. |

## Identidad Visual

---

<div align="center">
  <div style="display: inline-block; margin: 12px 24px; text-align: center;">
    <p><strong>Logo Empresarial</strong></p>
    <img src="assets/images/enterpriseLogo.jpeg" alt="Logo Empresarial" width="300" height="224" style="vertical-align: middle;"/>
  </div>
  <div style="display: inline-block; margin: 12px 24px; text-align: center;">
    <p><strong>Logo del Producto</strong></p>
    <img src="assets/images/productLogo.jpeg" alt="Logo del Producto" width="300" height="224" style="vertical-align: middle;"/>
  </div>
</div>

<div align="center">  
    <p style="font-size: 23px; font-weight: bold;">Paleta de colores</p>
</div>

La identidad cromática de Quantify Core se fundamenta en el contraste de **Blanco**, **Obsidian / Negro** y el color distintivo **Laser Blue (`#275BC0`)**. Esta paleta extendida define los tokens visuales para el diseño web, móvil y la lógica analítica de hábitos:

### 1. Colores Primarios de Marca

| Muestra | Tono | Código HEX | Uso principal |
|:---:|---|---|---|
| ![](https://img.shields.io/badge/-%23275BC0-275BC0?style=flat-square) | **Laser Blue (Core)** | `#275BC0` | Botones principales, enlaces y branding central. |
| ![](https://img.shields.io/badge/-%234A7DE8-4A7DE8?style=flat-square) | **Sky Laser** | `#4A7DE8` | Estados hover, selecciones y badges activos. |
| ![](https://img.shields.io/badge/-%23183D87-183D87?style=flat-square) | **Deep Cobalt** | `#183D87` | Estados pressed, encabezados y contrastes clave. |

### 2. Neutros y Superficies (Modo Claro y Modo Oscuro)

| Muestra | Tono | Código HEX | Uso principal |
|:---:|---|---|---|
| ![](https://img.shields.io/badge/-%230B0F17-0B0F17?style=flat-square) | **Obsidian Slate** | `#0B0F17` | Fondo principal en tema oscuro. |
| ![](https://img.shields.io/badge/-%23161F2E-161F2E?style=flat-square) | **Midnight Navy** | `#161F2E` | Tarjetas, modales y paneles en tema oscuro. |
| ![](https://img.shields.io/badge/-%23283548-283548?style=flat-square) | **Steel Border** | `#283548` | Bordes, divisores y líneas de formulario. |
| ![](https://img.shields.io/badge/-%238A99AD-8A99AD?style=flat-square) | **Cool Gray** | `#8A99AD` | Texto secundario, etiquetas y metadatos. |
| ![](https://img.shields.io/badge/-%23F4F7FD-F4F7FD?style=flat-square) | **Pure Mist** | `#F4F7FD` | Fondo general en tema claro. |
| ![](https://img.shields.io/badge/-%23FFFFFF-FFFFFF?style=flat-square) | **Optical White** | `#FFFFFF` | Tarjetas en tema claro y texto sobre fondos oscuros. |

### 3. Colores Semánticos y Analítica de Hábitos

| Muestra | Estado / Función | Código HEX | Uso principal |
|:---:|---|---|---|
| ![](https://img.shields.io/badge/-%2310B981-10B981?style=flat-square) | **Éxito / Rachas (Emerald)** | `#10B981` | Hábitos completados y rachas activas. |
| ![](https://img.shields.io/badge/-%23F59E0B-F59E0B?style=flat-square) | **Advertencia (Amber)** | `#F59E0B` | Recordatorios y hábitos pendientes del día. |
| ![](https://img.shields.io/badge/-%23EF4444-EF4444?style=flat-square) | **Error / Ruptura (Crimson)** | `#EF4444` | Rachas interrumpidas y alertas del sistema. |
| ![](https://img.shields.io/badge/-%230EA5E9-0EA5E9?style=flat-square) | **IA y Métricas (Electric Cyan)** | `#0EA5E9` | Recomendaciones de IA y gráficas de progreso. |

---

## Instalación y ejecución

> Las instrucciones de instalación, dependencias y ejecución local se formalizarán una vez establecido el entorno base del proyecto.

## Tabla de Prácticas

| Práctica | Título | Descripción | Firmas | Estatus |
|---|---|---|---|---|
| Práctica 04 | [Modelo Canvas](docs/Practica04/modelo-canvas-quantify.html) | Los estudiantes elaboraron un prompt para solicitar el business model canvas de su proyecto integrador. | 20 | Terminado |
| Práctica 05 | [Diagrama de Roles de usuario](docs/Practica05/diagrama-roles-quantify.html) | Los estudiantes elaboraron un prompt para generar un diagrama interactivo de roles de usuario del proyecto. | 15 | Terminado |
| Práctica 07 | Diagrama de secuencia | Los estudiantes elaboraron un prompt para generar un diagrama de secuencia. | - | En curso |

## Equipo de desarrollo

| Integrante | Rol |
|---|---|
| Al Farias Leyva | Integrante del equipo |
| Francisco García García | Integrante del equipo |
| Ángel de Jesús Baños Telles | Integrante del equipo |
| Jesús Alejandro Artiaga Morales | Integrante del equipo |

## Información académica

- **Universidad:** Universidad Tecnológica de Xicotepec de Juárez
- **Carrera / Especialidad:** Desarrollo y Gestión de Software
- **Cuatrimestre:** 10°
- **Grupo:** A
- **Asignatura:** Proyecto Integrador

## Licencia

Este proyecto se encuentra en fase de desarrollo académico. Licencia y términos de uso pendientes de definición.
