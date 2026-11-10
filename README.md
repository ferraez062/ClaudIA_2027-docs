# Documentación de ClaudIA 2027

Repositorio privado con las fuentes editables y los PDF finales del proyecto **ClaudIA: Sistema Inteligente de Acompañamiento Didáctico para Grupos DGETI**, código 26-AT625.

## Contenido

| Carpeta | Documento | Extensión |
|---|---|---:|
| `proyecto_at625_latex/` | Informe del proyecto | 31 páginas |
| `manual_usuario_v1_latex/` | Manual de usuario | 39 páginas |
| `manual_instalacion_v2_latex/` | Manual de instalación | 20 páginas |
| `archivo_anterior/` | Fuentes y entregables de versiones previas | Histórico |

Cada carpeta contiene:

- `main.tex`: fuente editable.
- `main.pdf`: versión final.
- `main_editable.pdf`: misma compilación con nombre de trabajo.
- `assets/`: imágenes utilizadas.
- `README.md`: indicaciones específicas.

## Requisitos

- MiKTeX o TeX Live con XeLaTeX.
- Arial y Consolas instaladas.
- Git.
- Editor de texto compatible con LaTeX.

## Compilación

En Windows:

```powershell
.\scripts\build-all.ps1
```

También puede compilarse un documento por separado:

```powershell
cd manual_usuario_v1_latex
xelatex -interaction=nonstopmode -jobname=main_editable main.tex
xelatex -interaction=nonstopmode -jobname=main_editable main.tex
Copy-Item build\main_editable.pdf main.pdf -Force
```

## Flujo para colaboradores

1. Acepte la invitación del repositorio privado.
2. Clone el repositorio.
3. Cree una rama para su cambio.
4. Edite el archivo `.tex` correspondiente.
5. Compile y revise visualmente el PDF.
6. Haga commit y suba la rama.
7. Abra un pull request para revisar antes de integrar.

Consulte [CONTRIBUTING.md](CONTRIBUTING.md) para conocer el procedimiento detallado.

## Contenido excluido

Por seguridad y privacidad no se versionan:

- Claves de API ni archivos `.env`.
- La encuesta completa en Excel ni bases con datos identificables.
- `node_modules`, carpetas `build`, registros y archivos temporales.

Quien necesite verificar las estadísticas deberá solicitar acceso controlado a la fuente original.

