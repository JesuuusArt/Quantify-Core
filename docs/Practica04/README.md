# Práctica 04 — Modelo Canvas Interactivo

> Business Model Canvas Interactivo del Proyecto Integrador **Quantify Core**, generado con **Archify** y validado con revisión visual automatizada.

## Descripción

Este documento presenta el **Business Model Canvas del proyecto Quantify Core**, una aplicación de seguimiento y refuerzo de hábitos con inteligencia artificial. El modelo describe cómo la aplicación llega a sus usuarios, qué problema resuelve, qué propuesta de valor ofrece, qué recursos requiere y cómo genera ingresos sostenibles. Fue estructurado de forma colaborativa por el equipo y transformado en un diagrama interactivo con Archify.

<p align="center">
  <a href="https://angeljesus13.github.io/Quantify-Core/docs/Practica04/business-model-canvas.html">
    <img src="https://img.shields.io/badge/Ver%20el%20Modelo%20Canvas%20Interactivo%20en%20vivo-1E54C9?style=for-the-badge&logo=github&logoColor=white" alt="Abrir canvas"/>
  </a>
</p>

<p align="center">
  <a href="https://angeljesus13.github.io/Quantify-Core/docs/Practica04/business-model-canvas.html">
    <img src="business-model-canvas.visual-check.2048x1320.light.png" alt="Modelo Canvas Interactivo" width="800"/>
  </a>
</p>

<p align="center"><em>Haz clic en la imagen o en el enlace superior para abrir el canvas interactivo.</em></p>

## Interpretación del modelo

- **Lado derecho (mercado):** Segmentos de clientes, canales de distribución, relación con clientes y fuentes de ingreso. Define a quién se dirige el servicio y cómo se monetiza.
- **Centro (valor):** La propuesta de valor (seguimiento inteligente y refuerzo de hábitos con IA), núcleo central del modelo.
- **Lado izquierdo (operación):** Recursos clave, actividades principales y socios estratégicos que posibilitan la entrega de valor.
- **Base (finanzas):** Estructura de costos que sostiene la infraestructura y operación del proyecto.
- Cada bloque es interactivo: al seleccionarlo se abre una **ficha descriptiva** con el detalle de ese componente (ver «Ficha descriptiva por bloque»).

## Ficha descriptiva por bloque

Al hacer clic en cualquiera de las nueve tarjetas del canvas se abre un panel editorial con el detalle completo del bloque. No es un resumen de una línea: es la explicación de qué significa ese bloque dentro del modelo de negocio de Quantify Core.

Cada ficha contiene:

- **Cabecera fija** con la categoría del bloque, la posición en la lectura del modelo (`Bloque NN de 09`) y los controles de navegación.
- **Riel de progreso** con los nueve bloques; permite saltar a cualquiera de ellos con un clic.
- **Encabezado** con antetítulo, título, párrafo de entrada y etiquetas de los conceptos clave del bloque.
- **Ilustración propia** del bloque: un dibujo SVG original, dibujado para este canvas (no es una imagen de stock ni una captura), con etiquetas de texto visibles para que se entienda sin leer la ficha. Se adapta automáticamente a las cuatro paletas de tema disponibles.
- **En qué consiste este bloque:** cuatro pilares que desglosan el alcance del bloque desde el punto de vista del proyecto.
- **Trazabilidad en el proyecto:** referencias a los requisitos y reglas de negocio del repositorio (`RF-xx` del catálogo, `RN-Pxx` y `RNF-xx` de las reglas y los requisitos no funcionales) que sustentan cada bloque.
- **Indicadores del bloque:** tres métricas propuestas para medir el desempeño de esa sección.
- **Riesgos y mitigación:** tres riesgos identificados con su respuesta prevista.
- **Bloques relacionados:** botones que saltan a las fichas vecinas del modelo.
- **Fuentes en el repositorio:** archivos del proyecto que documentan ese bloque.
- **Tablas de datos** (solo en los bloques donde aplican): cifras comparables con su base de cálculo y la fuente de cada dato.

Navegación disponible: clic en la tarjeta, clic en el riel, botones `Anterior`/`Siguiente`, teclas `←` y `→` para recorrer los bloques y `Esc` para cerrar (el foco vuelve a la tarjeta de origen). La ficha indica explícitamente que describe **un modelo de negocio propuesto** y su trazabilidad documental, no un servicio ya implementado.

El orden de lectura de las fichas sigue el flujo de valor canónico del canvas: segmentos → propuesta → canales → relación → ingresos → recursos → actividades → socios → costos.

## Estructura de costos con datos de mercado

La ficha de **Estructura de Costos** es la única que incorpora cifras de dinero verificadas en fuentes públicas. No son cotizaciones ni una política de precios: son **precios de referencia consultados el 21 de octubre de 2026**, usados para dimensionar el modelo.

| Dato | Valor | Fuente |
|---|---|---|
| Gemini 3.8 Flash | US$0.75 entrada / US$3.75 salida por 1M de tokens (lote: -50%) | [ai.google.dev/gemini-api/docs/pricing](https://ai.google.dev/gemini-api/docs/pricing) |
| Gemini 3.1 Flash-Lite | US$0.25 / US$1.50 por 1M de tokens | idem |
| OpenAI o4-mini | US$2.00 / US$8.00 por 1M de tokens | [developers.openai.com/api/docs/pricing](https://developers.openai.com/api/docs/pricing) |
| OpenAI gpt-5.6-sol | US$4.00 / US$20.00 por 1M de tokens | idem |
| Cómputo y alojamiento | US$17.55 al mes por máquina Fly.io `shared-cpu-8x` (2 GB); US$25 al mes en Render Standard (2 GB) | [fly.io/pricing](https://fly.io/pricing/), [render.com/pricing](https://render.com/pricing) |
| Base de datos y autenticación | Supabase Pro US$25 al mes (100,000 MAU); Neon Launch US$0.106 por CU-hora | [supabase.com/pricing](https://supabase.com/pricing), [neon.com/pricing](https://neon.com/pricing) |
| Objetos y respaldos | Cloudflare R2 US$0.015 por GB-mes | [developers.cloudflare.com/r2/pricing](https://developers.cloudflare.com/r2/pricing/) |
| Notificaciones push | Sin cargo (Firebase Cloud Messaging) | [firebase.google.com/pricing](https://firebase.google.com/pricing) |
| Correo y herramientas | Google Workspace Business Starter MX$126 por usuario al mes | [workspace.google.com/pricing](https://workspace.google.com/pricing.html) |
| Salario de referencia | MX$388,000 anuales base promedio (desarrollador de software en México) | [payscale.com](https://www.payscale.com/research/MX/Job=Software_Developer/Salary) |
| Tarifa de Google Play | 15% sobre las transacciones con facturación de Google Play | [support.google.com/googleplay](https://support.google.com/googleplay/android-developer/answer/6112435) |
| Tipo de cambio | 1 USD = MX$18.4823 | Frankfurter (tasas de referencia del BCE), 2026-10-21 |

**Supuestos del escenario** (hipótesis de trabajo, no decisiones): 3 sugerencias al día por usuario premium, 2,000 tokens de entrada y 600 de salida por llamada (90 llamadas al mes), 1,000 o 10,000 suscriptores premium y una suscripción de referencia de MX$99 al mes.

Resultados que se desprenden de esos datos:

- **Costo total del piloto (1,000 suscriptores premium): US$7,405 al mes (MX$136,854).** El equipo representa el 95% (US$6,998) y la inferencia de IA el 5% (US$338).
- **Costo variable de la IA: US$0.34 por usuario premium al mes** con Gemini 3.8 Flash; el mismo volumen con `gpt-5.6-sol` costaría US$1.80. El lote nocturno reduce la cifra a la mitad.
- **Con 10,000 suscriptores premium el costo total sube a US$10,529 pero el costo por usuario cae a US$1.05:** la infraestructura y la IA se amortizan, el equipo no.
- **Punto de equilibrio con la suscripción de referencia de MX$99** (neto MX$84.15 tras la tarifa del 15% de Google Play): **≈1,700 suscriptores premium**. Por debajo de esa cifra el ingreso no cubre el costo del equipo.

Estas cifras no son un compromiso comercial: precios, catálogo de planes y máximo de sugerencias siguen abiertos en el registro de decisiones pendientes y en `RN-P21`. El bloque deja constancia de los costos que aún **no** se han medido (adquisición, proveedor de correo y notificaciones, licencias de Wear OS) en lugar de estimarlos sin respaldo.

## Objetivo

Analizar el contexto del Proyecto Integrador y representar formalmente su propuesta de negocio mediante un Business Model Canvas interactivo, empleando herramientas de apoyo basadas en agentes inteligentes.

## Bloques del canvas

| Bloque | Definición en Quantify Core |
|---|---|
| Segmentos de Clientes | Público general interesado en la mejora y seguimiento de hábitos personales. La ficha profundiza en cuatro perfiles (agenda cargada, retorno a la rutina, metas de bienestar y administración operativa) y en el riesgo de ampliar demasiado el segmento. |
| Propuesta de Valor | Seguimiento cuantitativo, métricas de constancia y recomendaciones de hábitos con IA. La ficha explica el núcleo del modelo, sus límites (abstención con datos insuficientes) y su trazabilidad a reglas de datos y sugerencias. |
| Canales | Aplicación web, aplicación móvil (Android e iOS) y presencia en redes sociales. La ficha detalla el recorrido por canal, la coherencia de estados entre clientes y las condiciones de entrega de notificaciones. |
| Relación con Clientes | Recordatorios inteligentes, notificaciones contextuales y acompañamiento continuo. La ficha describe el trato con la persona, el consentimiento por finalidad y el cuidado con los datos privados. |
| Fuentes de Ingreso | Suscripción premium (modelo freemium con funcionalidades avanzadas de IA). La ficha desglosa las capas de producto, el catálogo por definir y los parámetros de monetización pendientes de evaluar. |
| Recursos Clave | Equipo de ingeniería, infraestructura cloud, APIs de inferencia IA y diseño UX/UI. La ficha inventaría los recursos, distingue el software ya decidido de lo que sigue pendiente y fija las métricas de rendimiento y costo. |
| Actividades Clave | Desarrollo de software, refinamiento de modelos de IA y soporte continuo. La ficha ordena las actividades por su efecto sobre el modelo y sus condiciones de trazabilidad y observabilidad. |
| Socios Clave | Universidad Tecnológica de Xicotepec de Juárez y proveedores cloud. La ficha explica el papel de cada aliado, la dependencia que introduce y la relación con los paquetes de trabajo del proyecto. |
| Estructura de Costos | Servidores, consumo de cómputo/APIs de IA, herramientas de desarrollo y difusión. La ficha separa costos fijos y variables, dimensiona el modelo con precios de mercado (ver «Estructura de costos con datos de mercado»), calcula el punto de equilibrio y deja constancia de los costos que aún no se han medido. |

## Archivos y entregables

- `prompt.txt` — Especificación y directrices empleadas para generar el modelo.
- `business-model-canvas.html` — Canvas interactivo en HTML autocontenido (con modal por bloque, selector de tema claro/oscuro y paleta corporativa). La ficha descriptiva de los nueve bloques —textos, trazabilidad, indicadores, riesgos, tablas de datos e ilustraciones SVG— vive dentro de este archivo; el contenido es editable sin rehacer el artefacto. El tema se puede forzar por URL con `?theme=light` o `?theme=dark` (tiene prioridad sobre la preferencia guardada en el navegador).
- `business-model-canvas.json` — Especificación estructurada del modelo en formato JSON (contrato de generación del diagrama; no se modifica al enriquecer la ficha).
- `business-model-canvas.visual-check.*` — Reportes y capturas de evidencia de validación visual automatizada en diversos viewports.

## Enlaces

- **Portal principal del proyecto:** https://angeljesus13.github.io/Quantify-Core/
- **Canvas interactivo directo:** https://angeljesus13.github.io/Quantify-Core/docs/Practica04/business-model-canvas.html

## Equipo

Grupo A · 10° Cuatrimestre · Universidad Tecnológica de Xicotepec de Juárez

- Al Farias Leyva
- Francisco García García
- Ángel de Jesús Baños Telles
- Jesús Alejandro Artiaga Morales
