# Proyecto editorial ClaudIA 2027

## Entregable

- `ClaudIA_Informe_2027_27_paginas.pdf`: informe final, tamaño carta vertical y 27 páginas.
- `main.tex`: fuente editable en LaTeX.

## Contenido

El informe conserva el formato del entregable anterior: carta vertical, Helvetica, los mismos márgenes y encabezado, inicio directo en la introducción y 27 páginas. Describe a ClaudIA como una estación física de acompañamiento didáctico para el aula, basada en Jarvis. La interacción del estudiante es exclusivamente por voz y escucha. La cámara se limita a detectar presencia o contexto del entorno; no lee cuadernos ni resuelve ejercicios.

La encuesta analizada corresponde a 122 estudiantes del CETis 20 de Ciudad del Carmen. El informe utiliza únicamente turno, especialidad, semestre, dificultad académica principal y uso o verificación de IA. Los reactivos ajenos al funcionamiento de ClaudIA se excluyeron.

## Bibliografía

Los documentos descargados y utilizados se encuentran en:

`C:\Users\CiberNEOS\Documents\ClaudIA\bibliografia`

El registro de fuentes, enlaces y uso previsto está en `bibliografia/FUENTES.md`.

## Recompilación

Desde esta carpeta:

```powershell
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
Copy-Item build/main.pdf ClaudIA_Informe_2027_27_paginas.pdf -Force
```

La segunda compilación actualiza el índice, la paginación y las referencias internas.
