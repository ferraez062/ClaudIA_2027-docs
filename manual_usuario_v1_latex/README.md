# Manual de usuario de ClaudIA

Guía de operación de **ClaudIA: Sistema Inteligente de Acompañamiento Didáctico para Grupos DGETI**.

## Archivos

- `main.tex`: fuente LaTeX editable.
- `main_editable.pdf`: compilación de referencia.
- `main.pdf`: copia final para entrega.
- `assets/`: capturas reales de la interfaz local.
- `imagenes_manifest.txt`: inventario de imágenes.
- `verificacion_resumen.txt`: resultados de extensión y compilación.

## Contenido

El manual explica la preparación del equipo, la instalación administrada, el uso de voz y texto, la identificación del estudiante y su grupo, el tutor educativo, el modo docente, la cámara, los documentos, las presentaciones y la solución de problemas.

## Compilación

```powershell
xelatex -interaction=nonstopmode -jobname=main_editable main.tex
xelatex -interaction=nonstopmode -jobname=main_editable main.tex
```

El documento usa XeLaTeX con Arial y requiere el paquete de idioma español de LaTeX.

La maqueta conserva las medidas del manual original: Arial de 11 pt,
márgenes laterales efectivos de 85 pt, interlineado de 14.6 pt,
numeración al pie derecho y 39 páginas.

La revisión editorial eliminó explicaciones duplicadas sobre los controles,
el contexto escolar, la privacidad y los comandos. Las repeticiones necesarias
en los procedimientos se conservan sólo cuando funcionan como verificación.

