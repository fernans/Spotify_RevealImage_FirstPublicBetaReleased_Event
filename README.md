# Spotify RevealImage — First public beta (event release)

Interactive **Adobe AIR / Flash** stage visual ("desvelar imagen" — reveal the image) built for a live event: a background image (or **video**) is covered by dozens of vinyl records; on key press, each record fades out with a **Boom explosion** (PNG frame sequence), progressively revealing the hidden background image under it. Programmed in **ActionScript 3** (`Fondos.as`, using **GreenSock TweenNano**) and fully driven by XML configuration (`config.xml`): background URL, list of object graphics + number of objects, list of explosion SWFs (with alpha), and the action keys (explode object, new object, show background, hide background). Objects spawn with random scale (10%), rotation (15°) and position; the packaged app was built as a **captive-runtime AIR app for macOS**.

> **This project is shared ONLY for educational purposes. Its use, direct or derived, for professional or economic purposes is not permitted.**

**Note on security**: for security reasons, some parts of the project are not published in the repository (the packaged captive AIR runtime app and the large video reels — both attached as **GitHub Release assets** — plus any internal paperwork).

## Requirements / How to run

- Edit and recompile: `fondos.fla` + `Fondos.as` / `Explosion.as` with **Adobe Flash Professional** (CS era), **GreenSock TweenNano** (`greensock.swc` included).
- Run the prototype: `fondos.swf` under a projector/AIR or the packaged macOS app from the Release assets.
- Configure via `config.xml` (background image/video, disc sprites, count) — see `docs/presupuesto.txt` for the original interaction design notes (dated 2013).
- Playback of video backgrounds requires the `.mov` provided as a Release asset (third-party demo reel used as placeholder media).

## Disclaimer

This software is provided **without any warranty of any kind**. No liability is accepted for errors or damages resulting from its use. Third-party media referenced by the project (video reels, brand names) belong to their respective owners.

> **AI training**: the use of the content of this repository (code, assets, documentation) to train or fine-tune machine learning models or AI systems is expressly **not permitted**. All of the repository is licensed under CC-BY-NC-4.0 (see the `LICENSE` file).

---

# Spotify RevealImage — Primera beta pública (release del evento)

**Visual escénico interactivo en Adobe AIR / Flash** ("desvelar imagen") creado para un evento en directo: una imagen de fondo (o **vídeo**) queda cubierta por decenas de discos de vinilo; al pulsar teclas, cada disco se desvanece con una **explosión Boom** (secuencia de frames PNG), revelando progresivamente la imagen oculta debajo. Programado en **ActionScript 3** (`Fondos.as`, con **GreenSock TweenNano**) y controlado completamente por configuración XML (`config.xml`): URL del fondo, lista de gráficos de objeto + número de objetos, lista de explosiones SWF (con alpha) y teclas de acción (explotar objeto, nuevo objeto, mostrar fondo, ocultar fondo). Los objetos aparecen con escala aleatoria (10 %), giro (15°) y posición aleatoria; la app empaquetada se generó como **AIR de runtime cautivo para macOS**.

> **Este proyecto se comparte SOLO con valor educativo. No está permitido su uso (directo o derivado) para fines profesionales o económicos.**

**Nota de seguridad**: por motivos de seguridad, algunas partes del proyecto no se publican en el repositorio (la app empaquetada con runtime AIR cautivo y los vídeos de gran tamaño — ambos adjuntos como **assets de Release de GitHub** — además de documentación interna).

## Requisitos / Cómo ejecutar

- Editar y recompilar: `fondos.fla` + `Fondos.as` / `Explosion.as` con **Adobe Flash Professional** (de la época CS), **GreenSock TweenNano** (`greensock.swc` incluida).
- Ejecutar el prototipo: `fondos.swf` en un proyector/AIR o la app macOS empaquetada de las assets de Release.
- Configurar mediante `config.xml` (imagen/vídeo de fondo, sprites de discos, cantidad) — ver `docs/presupuesto.txt` para las notas originales de diseño de la interacción (con fecha 2013).
- La reproducción de fondos en vídeo requiere el `.mov` adjunto como asset de Release (reel de demostración de terceros usado como material de fondo).

## Aviso

Este software se proporciona **sin ningún tipo de garantía**. No se acepta ninguna responsabilidad por errores o daños que puedan producirse por su uso. Los material miscellaneous de terceros referenciados por el proyecto (vídeos, nombres de marca) pertenecen a sus respectivos propietarios.

> **Entrenamiento de IA**: no se permite expresamente el uso del contenido de este repositorio (código, recursos, documentación) para entrenar o ajustar (*fine-tune*) modelos de aprendizaje automático o sistemas de IA. Todo el repositorio se publica con licencia CC-BY-NC-4.0 (ver el archivo `LICENSE`).
