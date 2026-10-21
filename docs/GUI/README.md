# GUI · Interfaz gráfica

Esta carpeta reúne la referencia para las pantallas y estados visuales de Quantify Core. **Estado:** existe un [prototipo académico navegable](../practica-07/README.md); los clientes React y Flutter del producto todavía no están implementados. El [sistema de diseño V2.0](../diseno/sistema-diseno.md) y los [tokens](../../packages/design-tokens/README.md) son la referencia de producto.

```mermaid
flowchart LR
    P[Sketch y recorrido] --> R[Requisito y regla]
    R --> C[Contrato y permisos]
    C --> W[Componente web]
    C --> M[Componente móvil]
    W --> V[Pruebas de accesibilidad]
    M --> V
```

## Recorridos que debe explicar la GUI

| Recorrido | Referencia visual | Estados y límites |
|---|---|---|
| Acceso y perfil | U01 a U05, U12 del [prototipo](../practica-07/README.md) | Cargando, sesión vencida, validación, consentimiento y acceso propio. |
| Hábitos y progreso | U06 a U08, U13 | Vacío, edición, pendiente, confirmado, conflicto, pausa y archivo. |
| Métricas y sugerencias | U10, U11 | Sin datos, cálculo pendiente, resultado explicable y abstención. |
| Avisos y configuración | U09, U14, U15 | Permiso denegado, horario/zona, desactivación y cierre de sesión. |
| Administración | A01 a A09 | Permisos específicos, confirmación con motivo y datos agregados. |

Los IDs de pantalla pertenecen a la demo; los [recorridos V2.0](../diseno/recorridos.md) describen qué se mantiene, adapta o requiere contrato. La navegación de revisión del prototipo permite abrir pantallas sin sesión; eso no es autorización para el producto.

## Reglas de implementación visual

- Conservar el mismo significado de estados y acciones en web y móvil; adaptar la distribución, no crear fórmulas distintas por cliente.
- La pantalla no decide permisos por ocultar botones. La API comprueba identidad, rol y pertenencia.
- Mostrar «pendiente de sincronización» hasta que llegue confirmación. Un conflicto requiere revisión del usuario; no se resuelve por el reloj del dispositivo.
- Cada gráfico incluye texto, unidad, periodo, fuente y estado «sin datos» cuando corresponda. Color solo es apoyo.
- Comprobar teclado, foco, lectura accesible, contraste y temas. La [paleta del sketch](../practica-07/README.md) no sustituye los tokens V2.0.

Para revisar visualmente, abrir el [prototipo](https://angeljesus13.github.io/Quantify-Core/docs/practica-07/) y el [mapa de navegación](https://angeljesus13.github.io/Quantify-Core/docs/practica-07/navegacion.html). Sus capturas y estados son evidencia de diseño académico. Los nuevos componentes deberán enlazar RF, historia, tokens, contrato y prueba de accesibilidad.
