# Validación de la práctica 07

Revisión realizada el **14 de octubre de 2026**, en la rama `practica-07-integradora`.

## Prototipo

- **16 pruebas de lógica aprobadas** con `node --test --test-timeout=10000 docs/practica-07/tests/prototipo.test.cjs`.
- Los 24 sketches generan contenido y todas las transiciones del inventario apuntan a pantallas existentes del mismo rol.
- Se comprobaron duplicados, frecuencias vacías, límites de avance, completar/deshacer, metas y frecuencias históricas, archivo, rachas, filtros de IA, descarte, aceptación, días de recordatorios, motivos administrativos, protección de la cuenta actual, auditoría y ausencia de contraseñas en el almacenamiento persistente.
- Sintaxis de `app.js` y `data.js` comprobada con `node --check`.
- Recursos locales de `index.html` encontrados; sin scripts ni estilos de red requeridos.
- Vista por HTTP local con respuesta **200 OK** y apertura directa del archivo HTML verificadas.

Las pruebas ejecutan la lógica real en un contexto JavaScript en memoria con adaptadores mínimos de formularios y DOM. No sustituyen una prueba automatizada de navegador.

## Revisión manual en Safari

Se inspeccionó la composición en una ventana de escritorio y en el modo responsivo a **390 × 844**. Se revisaron los formatos Móvil y PWA, el mapa integrado y la adaptación del inventario de pantallas.

Recorridos ejecutados en el navegador:

1. Inicio de sesión demo de usuario → Hoy.
2. Nuevo hábito → escribir nombre → cambiar a PWA conservando el formulario → guardar → detalle.
3. Cambiar al rol Administrador → acceso demo → resumen.
4. Catálogo → pausar plantilla → motivo y confirmación → estado pausado.
5. Auditoría → comprobar entidad, motivo y responsable del cambio.
6. Abrir el mapa y revisar las salidas del sketch y sus tarjetas de transiciones.
7. Abrir el diagrama general y revisar sus temas oscuro y claro.
8. Abrir el prototipo directamente desde `index.html` y comprobar su renderizado y datos iniciales.

No se midió automáticamente el desbordamiento del DOM ni se ejecutó una matriz automatizada de todos los sketches y resoluciones. La revisión móvil corresponde a la emulación de viewport, no a un dispositivo físico.

## Diagrama general de Archify

```text
diagram_type: workflow
output: docs/practica-07/navegacion.html
specification_sha256: 5e75eb90ec17e869bb8f3209ee5c8076bd07e5db614a82bfcfdf5db3d380f6cd
artifact_sha256: 35b50910d5f5b34847a36bb161482e5ffd9caac30cb52a3ab77c749ffa6f793d
specification_bytes: 3784
artifact_bytes: 810177
validation: 9/9 showcase, 0 errors, 0 warnings
browser_evidence: skipped
visual_review: passed
correction_rounds: 0
```

`deliver` finalizó correctamente y vincula la especificación con el HTML mediante los hashes anteriores. No se modificó el artefacto después de su entrega.

`browser_evidence: skipped` corresponde al resultado real de [navegacion.visual-check.json](./navegacion.visual-check.json): el verificador no encontró Chrome/Chromium. No se generaron capturas automáticas ni mediciones de sus cuatro viewports.

`visual_review: passed` se refiere exclusivamente a la inspección perceptual manual del HTML entregado en Safari, en los temas claro y oscuro. Las flechas y etiquetas de ambos recorridos resultaron legibles y sin superposiciones visibles en la ventana revisada. Esta inspección no cambia el resultado automático omitido ni acredita cobertura de 1440×900, 1600×1000, 1920×1080 y 2048×1320.

## Identidad de los archivos principales revisados

| Archivo | SHA-256 |
|---|---|
| `index.html` | `72f34110c708a66eace53a784652f0121a6466b6cdcdb1a983ea721f9e6dfa20` |
| `styles.css` | `9eea58fe37c471f91178bc31c38f491e4de6399af686634f00a83201a497e324` |
| `data.js` | `0216b08e3eaf608e6b207b548785e6d73b162750f22ed3cc7d482f85ce985153` |
| `app.js` | `3249fbb92765be1e93f09d89e4a547da70b368d31c5b74f36fe2d68f237954dd` |
