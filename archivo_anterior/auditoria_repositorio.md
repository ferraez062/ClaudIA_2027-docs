# Auditoría inicial del repositorio ClaudIA

Fecha: 6 de noviembre de 2026  
Commit analizado: `060e1e5`  
Rama: `master`  
Repositorio: `https://github.com/ferraez062/ClaudIA`

## Resultado general

El repositorio contiene una base funcional para un asistente educativo modular, pero todavía no implementa una estación física de aula. La arquitectura de eventos, comandos, memoria, progreso educativo y pruebas está bien separada. Los huecos principales están en la integración del modelo de lenguaje, la captura real de cámara, la autonomía del dispositivo, el control estricto de respuestas y la identidad de ClaudIA.

La suite actual supera 52 pruebas de 52. Las pruebas cubren núcleo, comandos, memoria, educación, documentos, voz simulada, visión base y la interfaz web. No cubren el cliente real de IA, el cambio de proveedor, el control contra respuestas directas, la activación por presencia ni una captura real de cámara.

## Qué existe y funciona

| Área | Estado |
|---|---|
| Núcleo por eventos | Funcional |
| Comandos, alias y sugerencias | Funcional |
| Sesión temporal | Funcional |
| Memoria permanente en JSON | Funcional base |
| Progreso educativo en JSON | Funcional base |
| Catálogo de lecciones | Funcional, pero sólo contiene tres lecciones de nivel primaria |
| Tutor con ejercicios y pistas | Funcional base y limitado |
| Lectura de documentos TXT/MD | Funcional base |
| Entrada de voz desde navegador | Funcional en Chrome o Edge |
| Salida de voz desde navegador | Funcional mediante `speechSynthesis` |
| Cámara y OpenCV | Sólo diagnóstico; no hay captura ni detección real |
| Proveedor de IA | OpenAI acoplado directamente |
| Panel docente | No implementado |
| Autenticación y roles efectivos | No implementados |
| Operación headless para hardware | No implementada |

## Arquitectura actual

El flujo principal es:

```text
Entrada de texto o voz
  -> EventBus
  -> JarvisCore
  -> CommandInterpreter / CommandRouter
  -> comando interno o ConversationManager
  -> OpenAIService
  -> OpenAI API
  -> respuesta por terminal o navegador
```

La separación entre interfaz, núcleo, comandos, memoria, educación y tutor es adecuada y debe conservarse.

## Hallazgos prioritarios

### P0: seguridad y secretos

1. `.env` está versionado en Git aunque debería permanecer fuera del repositorio. No se imprimieron sus valores.
2. `node_modules` está versionado: 3,693 de los 3,766 archivos rastreados pertenecen a dependencias.
3. El archivo de reglas correcto debería llamarse `.gitignore`; actualmente existe un archivo llamado `gitignore` con las reglas de `node_modules`, `.env` y `.vscode`.
4. La auditoría de npm reporta cinco vulnerabilidades de dependencias: una crítica, tres altas y una moderada. Hay actualizaciones disponibles para `axios`, `express`, `openai`, `body-parser`, `follow-redirects`, `proxy-addr` y paquetes relacionados.

Antes de publicar cambios debe rotarse cualquier clave que haya estado dentro del repositorio y eliminarse el archivo del historial.

### P0: identidad todavía corresponde a Jarvis

- El paquete se llama `jarvis-harahel`.
- La aplicación se presenta como `Jarvis Educativo`.
- El perfil principal es `Harahel`, no un grupo DGETI.
- La interfaz, los comandos y los tests conservan el nombre Jarvis.
- El repositorio remoto ya se llama ClaudIA, pero el producto y la configuración todavía no.

No conviene hacer un reemplazo masivo de nombres. Primero debe definirse el perfil ClaudIA y sustituir la identidad por capas para no romper importaciones, pruebas y memoria existente.

### P0: el tutor todavía no cumple la regla pedagógica de ClaudIA

Los prompts actuales indican:

- dar pistas antes de respuestas completas;
- explicar paso a paso;
- evaluar respuestas;
- permitir que el modo examen dé retroalimentación general.

La regla solicitada es más estricta: **ClaudIA no debe entregar la respuesta final en el flujo del estudiante**. Debe hacer preguntas, dar ejemplos análogos, pedir intentos y conducir una línea de pensamiento.

Las instrucciones actuales todavía permiten que el modelo entregue la respuesta después de varias pistas. Además, el tutor local incluye explicaciones y respuestas correctas dentro de su lógica, por lo que una simple modificación del prompt no es suficiente.

### P0: la cámara no cumple todavía su función

- `vision_status.py` sólo comprueba si Python y OpenCV están disponibles.
- Devuelve siempre `checked: false` y `available: false` para la cámara.
- No captura cuadros, no detecta personas y no informa eventos al núcleo.
- `VisionCommands` únicamente activa o desactiva una bandera en la sesión.

Para ClaudIA se requiere un servicio de cámara que:

1. detecte presencia o ausencia de personas;
2. genere eventos de inicio y pausa;
3. estime contexto general del entorno sin identificar personas;
4. no envíe imágenes a DeepSeek;
5. no conserve video por defecto;
6. permita un interruptor físico y un indicador visible.

### P1: la voz no es todavía una solución de hardware

- La entrada depende de Web Speech API del navegador.
- La salida depende de las voces instaladas en el navegador o del sistema.
- El navegador puede enviar audio a un servicio externo según su implementación.
- No existe una capa independiente de micrófono, altavoz y palabra de activación.
- El proceso arranca terminal y servidor web al mismo tiempo; no está preparado para iniciar como servicio de una estación.

Se requiere separar:

- servicio de audio del dispositivo;
- reconocimiento de voz;
- voz sintética;
- servidor local;
- modo kiosco o servicio de inicio automático.

DeepSeek no sustituye estas funciones de audio. Sólo reemplazará la generación de texto y razonamiento.

### P1: costo de tokens sin control

`ConversationManager` conserva y reenvía todo el historial de la conversación. El prompt también incorpora memoria, progreso, documento activo y estado del tutor en cada solicitud.

No existe:

- límite de mensajes o tokens;
- resumen de conversaciones antiguas;
- registro de tokens de entrada y salida;
- tiempo máximo de espera;
- reintentos controlados;
- proveedor alternativo;
- presupuesto diario o por sesión.

En una estación de aula esto puede elevar el costo y producir respuestas lentas.

### P1: memoria y progreso son globales, no por estudiante

- La memoria permanente usa un único archivo JSON.
- El progreso educativo usa otro archivo JSON global.
- El usuario inicial está fijado como Harahel.
- No hay separación por grupo, alumno, periodo o docente.
- No hay autenticación ni permisos efectivos.

ClaudIA necesita un identificador de sesión o grupo y una política clara para datos individuales.

### P1: contenido educativo insuficiente

El catálogo contiene tres lecciones de nivel primaria:

- fracciones básicas;
- idea principal de un texto;
- observación científica.

Para DGETI se requieren contenidos por asignatura, semestre, especialidad y objetivo de aprendizaje, además de ejercicios con metadatos para evitar revelar la respuesta.

### P2: documentación inconsistente

- `docs/00-Visión-del-Proyecto.md` contiene únicamente `df`.
- `docs/02-Decisiones-de-Arquitectura.md` contiene únicamente `df`.
- `docs/03-Mapa-de-Módulos.md` contiene únicamente `df`.
- `docs/módulos/M01-Núcleo-Conversacional.md` está vacío.
- `docs/01-Arquitectura-General.md` contiene información útil, pero presenta referencias al sistema como Jarvis y JOS.

## Integración propuesta con DeepSeek

La documentación oficial de DeepSeek confirma que su API acepta el formato compatible con OpenAI. La URL base es `https://api.deepseek.com` y los modelos vigentes documentados son `deepseek-flash` y `deepseek-v4-pro`.

Para costo bajo, `deepseek-flash` debe ser el modelo predeterminado de las interacciones escolares. `deepseek-v4-pro` puede quedar disponible como opción de mayor capacidad, no como predeterminado.

### Estrategia recomendada

Mantener el proveedor actual como respaldo y añadir DeepSeek como proveedor principal:

```text
AI_PROVIDER=deepseek
AI_FALLBACK_PROVIDER=openai
DEEPSEEK_API_KEY=...
DEEPSEEK_MODEL=deepseek-flash
DEEPSEEK_BASE_URL=https://api.deepseek.com
OPENAI_API_KEY=...
OPENAI_MODEL=...
```

La implementación debe usar una interfaz común, por ejemplo `LLMService`, con dos adaptadores:

- `DeepSeekProvider`
- `OpenAIProvider`

El núcleo no debe saber qué empresa genera la respuesta. Ambos adaptadores deben entregar el mismo contrato:

```text
generateResponse(messages, options)
  -> text
  -> model
  -> usage
  -> latencyMs
```

La selección del proveedor debe resolverse en configuración y probarse sin requerir llamadas reales.

### Recomendaciones para reducir tokens

- Limitar el historial a los últimos turnos relevantes.
- Resumir conversaciones antiguas en una memoria breve.
- Mantener un prompt de sistema estable y separar el contexto dinámico.
- Limitar la longitud del documento activo.
- Limitar `max_tokens` de salida para voz.
- Enviar sólo la lección y el ejercicio activos, no todo el catálogo.
- Registrar tokens de entrada, salida y latencia para conocer el costo real.
- Usar `deepseek-flash` como modelo predeterminado.

## Orden recomendado de cambios

### Fase 1: saneamiento

1. Corregir `.gitignore`.
2. Retirar `.env` del control de versiones.
3. Retirar `node_modules` del control de versiones.
4. Actualizar dependencias vulnerables.
5. Confirmar que las 52 pruebas siguen pasando.

### Fase 2: proveedor DeepSeek

1. Crear configuración multi-proveedor.
2. Implementar `DeepSeekProvider`.
3. Mantener OpenAI como respaldo configurable.
4. Añadir timeout, reintentos y registro de tokens.
5. Probar DeepSeek con respuestas simuladas.
6. Probar una llamada real sólo cuando exista `DEEPSEEK_API_KEY`.

### Fase 3: pedagogía estricta

1. Unificar los dos `PromptManager` existentes.
2. Establecer la regla de no entregar respuestas finales.
3. Diseñar respuestas como pregunta, ejemplo, pista o explicación gradual.
4. Añadir pruebas para impedir que una respuesta directa salga del flujo del estudiante.
5. Reemplazar el tutor rígido por un flujo con estado conversacional.

### Fase 4: identidad ClaudIA

1. Cambiar nombre del paquete y versión.
2. Crear perfil ClaudIA.
3. Sustituir Harahel por una sesión de grupo o estudiante.
4. Adaptar comandos y mensajes.
5. Renombrar módulos internos sin romper compatibilidad.

### Fase 5: hardware

1. Implementar cámara local de presencia.
2. Implementar micrófono y altavoz fuera del navegador o en un modo kiosco controlado.
3. Añadir palabra de activación o botón físico.
4. Añadir indicadores de escucha y cámara.
5. Preparar arranque automático y recuperación ante fallos.

### Fase 6: aula

1. Separar datos por grupo y usuario.
2. Construir el panel docente.
3. Adaptar contenidos a DGETI.
4. Ejecutar un piloto controlado.
5. Medir uso, comprensión, latencia, costo y privacidad.

## Recomendación inmediata

No conviene conectar DeepSeek directamente a `OpenAIService` con un cambio mínimo de URL. Primero debe crearse una abstracción de proveedor. Así se conserva el API actual como respaldo, se puede cambiar de modelo sin tocar el núcleo y se evita repetir el acoplamiento actual.
