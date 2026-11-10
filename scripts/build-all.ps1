$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$projects = @(
    "proyecto_at625_latex",
    "manual_usuario_v1_latex",
    "manual_instalacion_v2_latex"
)

foreach ($project in $projects) {
    $projectPath = Join-Path $root $project
    $buildPath = Join-Path $projectPath "build"

    Write-Host "Compilando $project..."
    Push-Location $projectPath

    try {
        New-Item -ItemType Directory -Path $buildPath -Force | Out-Null

        & xelatex -interaction=nonstopmode -halt-on-error `
            -output-directory=build -jobname=main_editable main.tex

        if ($LASTEXITCODE -ne 0) {
            throw "Falló la primera compilación de $project."
        }

        & xelatex -interaction=nonstopmode -halt-on-error `
            -output-directory=build -jobname=main_editable main.tex

        if ($LASTEXITCODE -ne 0) {
            throw "Falló la segunda compilación de $project."
        }

        Copy-Item -LiteralPath "build\main_editable.pdf" -Destination "main.pdf" -Force
        Copy-Item -LiteralPath "build\main_editable.pdf" -Destination "main_editable.pdf" -Force
        Write-Host "Listo: $project\main.pdf"
    }
    finally {
        Pop-Location
    }
}

Write-Host "Todos los documentos compilaron correctamente."

