# Guía para colaboradores

## Preparación

```powershell
git clone https://github.com/ferraez062/ClaudIA_2027-docs.git
cd ClaudIA_2027-docs
git switch -c nombre-del-cambio
```

Cada persona debe configurar su identidad de Git:

```powershell
git config user.name "Nombre completo"
git config user.email "correo@ejemplo.com"
```

## Edición

1. Modifique preferentemente `main.tex`, no los PDF.
2. Mantenga las imágenes dentro de la carpeta `assets/` del documento.
3. Actualice el README o la verificación cuando cambie la extensión o el proceso.
4. No agregue credenciales ni datos personales.

## Compilación y revisión

```powershell
.\scripts\build-all.ps1
```

Revise el documento generado y compruebe:

- Texto sin recortes ni desbordamientos.
- Figuras legibles.
- Índice y numeración correctos.
- Sin advertencias de LaTeX.

## Envío de cambios

```powershell
git add .
git commit -m "Describe el cambio"
git push -u origin nombre-del-cambio
```

Después, abra un pull request en GitHub. Otro integrante debe revisar el cambio antes de integrarlo con `main`.

## Archivos permitidos

- Fuentes `.tex`.
- PDF finales.
- Imágenes utilizadas en los documentos.
- Documentos de referencia autorizados.
- Scripts de compilación y documentación.

## Archivos prohibidos

- `.env`, claves API o credenciales.
- Hojas de cálculo con nombres, teléfonos, correos u otros datos personales.
- Carpetas `node_modules`, `build`, `generated` o `data`.
- Registros privados de conversaciones y sesiones.

