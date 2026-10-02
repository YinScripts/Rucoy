# Pixel World

Primera base del juego 2D pixel-art top-down.

## Prototipo actual

- Godot 4.x.
- Resolución interna 480x270.
- Escalado 2x para escritorio.
- Filtro de texturas nearest-neighbor.
- Movimiento tap-to-move / click-to-move.
- Personaje con 4 direcciones.
- Animación de pies de 3 frames durante el movimiento.
- Mapa de prueba dibujado por código.

## Ejecutar

Abrir esta carpeta con Godot 4.x y ejecutar `Main.tscn`.

En PC: hacer click sobre el mapa para indicar el destino.
En Android: el mismo toque se recibe como `InputEventScreenTouch` cuando añadamos la entrada táctil explícita; la siguiente iteración conectará ese evento al mismo sistema de destino.
