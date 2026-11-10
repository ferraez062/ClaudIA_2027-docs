# Proyecto 26-AT625 ClaudIA

Versión editable del informe **ClaudIA: Sistema Inteligente de Acompañamiento Didáctico para Grupos DGETI**.

## Entregables

- `main.tex`: fuente LaTeX completa.
- `main_editable.pdf`: compilación de referencia.
- `main.pdf`: copia final para entrega.
- `assets/`: capturas reales de la interfaz local.
- `referencias/`: documentos descargados que sustentan las citas.
- `fuente_encuesta_vendedores.xlsx`: base diagnóstica original.
- `verificacion_resumen.txt`: resultados de extensión y compilación.
- `imagenes_manifest.txt`: inventario de las capturas incluidas.

## Compilación

El documento usa XeLaTeX porque conserva tipos de letra Arial y Consolas mediante `fontspec`.

```powershell
xelatex -interaction=nonstopmode -jobname=main_editable main.tex
xelatex -interaction=nonstopmode -jobname=main_editable main.tex
```

## Verificación del prototipo

La interfaz se ejecutó localmente con `npm start` desde el repositorio `ClaudIA-repo`, commit `29db70a`. La batería `npm test` reportó 92 pruebas aprobadas y ninguna fallida.

## Criterio del documento

La estructura, tipografía, márgenes, encabezado, espaciado de títulos, interlineado,
rotulación de cuadros y capturas, y extensión siguen el modelo
`proyecto_at625_latex` de EDU Bot:

- Arial de 11 pt y Consolas para código.
- Carta, márgenes laterales simétricos de 85 pt.
- Cuerpo de 11 pt con interlineado de 19 pt y párrafos justificados.
- Encabezado de tres líneas alineado al margen derecho, con `26-AT625` arriba.
- Títulos y subtítulos alineados a la izquierda mediante `\Section` y `\Subsection`.
- Enlaces negros, cuadros rotulados como `Tabla` y capturas como `Figura`.
- 31 páginas, igual que el documento de referencia.

El contenido fue sustituido por el problema, diseño, arquitectura y evidencia propios de ClaudIA.

La revisión editorial eliminó repeticiones entre introducción, planteamiento,
metodología, límites, experiencia de uso, viabilidad y conclusión. Cada concepto
se desarrolla en el apartado que le corresponde y los párrafos de contenido están justificados.

La identidad del proyecto, el repositorio, las clases, los eventos y la interfaz
utilizan únicamente el nombre ClaudIA.

La muestra se presenta como un único total de 122 estudiantes del CETis 20.
No se incluyen desgloses internos ni gráficas por subgrupos. Los porcentajes
fueron verificados directamente en la hoja `SNCyT_2026`.

