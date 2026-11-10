# Manual de instalación de ClaudIA

Guía técnica para instalar y verificar **ClaudIA: Sistema Inteligente de Acompañamiento Didáctico para Grupos DGETI**.

## Archivos

- `main.tex`: fuente LaTeX editable.
- `main_editable.pdf`: compilación de referencia.
- `main.pdf`: copia final para entrega.
- `assets/`: capturas de la portada y del diagnóstico de cámara.
- `verificacion_resumen.txt`: resultados de extensión y compilación.

## Contenido

El manual cubre requisitos, instalación de Node.js, dependencias, configuración de DeepSeek y OpenAI, variables de entorno, estructura del proyecto, ejecución, pruebas, diagnóstico de errores y mantenimiento.

## Compilación

```powershell
xelatex -interaction=nonstopmode -jobname=main_editable main.tex
xelatex -interaction=nonstopmode -jobname=main_editable main.tex
```

La maqueta conserva las medidas del manual de instalación de EDU Bot: Arial de 12 pt, títulos de sección de 14 pt, márgenes laterales efectivos de 85 pt y numeración al pie derecho.

