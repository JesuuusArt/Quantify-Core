# UHs · Historias de usuario

**UHs** organiza necesidades en historias breves para planificar y revisar trabajo en Jira. Los identificadores `HU-XX` de esta carpeta se corresponden con los requisitos `RF-XX`; su definición normativa permanece en el [catálogo](../requerimientos/catalogo.md) y sus criterios `AC-XX` en [aceptación](../requerimientos/aceptacion.md). **Estado:** historias propuestas, no tickets asignados ni funciones terminadas.

| Historia | Actor y objetivo | Requisito |
|---|---|---|
| HU-01 | Usuario: entrar y recuperar acceso a su cuenta. | RF-01 |
| HU-02 | Usuario: ajustar perfil y consentimiento por finalidad. | RF-02 |
| HU-03 | Usuario: crear y gestionar su hábito. | RF-03 |
| HU-04 | Usuario: registrar y corregir progreso sin duplicados. | RF-04 |
| HU-05 | Usuario: entender cumplimiento e historial. | RF-05 |
| HU-06 | Usuario: configurar avisos voluntarios. | RF-06 |
| HU-07 | Usuario: comprender, aceptar o descartar sugerencias. | RF-07 |
| HU-08 | Usuario: vincular y revocar una fuente wearable. | RF-08 |
| HU-09 | Administrador: mantener catálogo y estado de cuentas. | RF-09 |
| HU-10 | Usuario: exportar o solicitar eliminación de sus datos. | RF-10 |

Las [historias del primer recorrido](primer-flujo.md) detallan HU-01 a HU-05, con fallos y dependencias. HU-06 a HU-10 se desglosarán en tareas cuando se resuelvan sus proveedores, políticas y contratos. La [HU-QC-05 académica](../Practica05/HU-Recomendaciones-IA.md) es antecedente de HU-07, con otro identificador y umbrales de la práctica.

## Plantilla para desglosar una historia

```text
ID / RF / AC:
Como [actor], quiero [acción] para [resultado].
Incluye y excluye:
Precondiciones y permisos:
Flujo principal y fallos:
Pantallas/estados y contrato:
Datos y reglas RN-P:
Pruebas y evidencia:
Decisiones pendientes:
```

Cada ticket de Jira debe citar la historia y el criterio que entrega. Una historia grande puede dividirse sin perder trazabilidad; no declarar RF completo al terminar solo una pantalla.
