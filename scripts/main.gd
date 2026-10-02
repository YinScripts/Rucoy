extends Node2D

const MAP_SIZE := Vector2(480.0, 270.0)
const TILE_SIZE := 16
const PLAYER_START := Vector2(240.0, 135.0)

func _ready() -> void:
    queue_redraw()

func _draw() -> void:
    draw_rect(Rect2(Vector2.ZERO, MAP_SIZE), Color("#4c9b48"))
    _draw_grass()
    _draw_path()
    _draw_trees()

func _draw_grass() -> void:
    for y in range(2, 17):
        for x in range(2, 29):
            if (x * 17 + y * 31) % 11 == 0:
                var p := Vector2(x * TILE_SIZE + 5, y * TILE_SIZE + 6)
                draw_rect(Rect2(p, Vector2(2, 4)), Color("#31743a"))
            elif (x * 13 + y * 19) % 17 == 0:
                var p2 := Vector2(x * TILE_SIZE + 11, y * TILE_SIZE + 11)
                draw_rect(Rect2(p2, Vector2(2, 2)), Color("#3d823e"))

func _draw_path() -> void:
    var path_color := Color("#a68b58")
    var edge_color := Color("#826d45")
    draw_rect(Rect2(0, 104, MAP_SIZE.x, 48), edge_color)
    draw_rect(Rect2(0, 108, MAP_SIZE.x, 40), path_color)
    for x in range(0, 30):
        draw_rect(Rect2(x * TILE_SIZE + 2, 111, 12, 2), Color("#b79c65"))
        draw_rect(Rect2(x * TILE_SIZE + 4, 140, 9, 2), Color("#92794b"))

func _draw_trees() -> void:
    var positions := [
        Vector2(40, 45), Vector2(72, 45), Vector2(104, 45),
        Vector2(376, 48), Vector2(408, 48), Vector2(440, 48),
        Vector2(40, 215), Vector2(72, 215), Vector2(408, 215), Vector2(440, 215)
    ]
    for p in positions:
        draw_rect(Rect2(p.x - 5, p.y + 7, 10, 10), Color("#6b4c2d"))
        draw_rect(Rect2(p.x - 13, p.y - 5, 26, 20), Color("#245f32"))
        draw_rect(Rect2(p.x - 10, p.y - 12, 20, 18), Color("#31813c"))
        draw_rect(Rect2(p.x - 6, p.y - 15, 12, 7), Color("#43954a"))
