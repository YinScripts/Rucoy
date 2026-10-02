extends CharacterBody2D

@export var speed := 110.0

var target_position := Vector2.ZERO
var moving := false
var facing := Vector2.DOWN
var animation_time := 0.0
var walk_frame := 0

func _ready() -> void:
    target_position = global_position
    queue_redraw()

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
        target_position = get_global_mouse_position()
        moving = true
    elif event is InputEventScreenTouch and event.index == 0 and event.pressed:
        target_position = get_canvas_transform().affine_inverse() * event.position
        moving = true

func _physics_process(delta: float) -> void:
    if not moving:
        velocity = Vector2.ZERO
        queue_redraw()
        return

    var offset := target_position - global_position
    if offset.length() <= 2.0:
        global_position = target_position
        velocity = Vector2.ZERO
        moving = false
        animation_time = 0.0
        walk_frame = 0
        queue_redraw()
        return

    var direction := offset.normalized()
    velocity = direction * speed
    move_and_slide()
    global_position.x = snapped(global_position.x, 1.0)
    global_position.y = snapped(global_position.y, 1.0)

    if abs(direction.x) > abs(direction.y):
        facing = Vector2(sign(direction.x), 0)
    else:
        facing = Vector2(0, sign(direction.y))

    animation_time += delta
    if animation_time >= 0.11:
        animation_time = 0.0
        walk_frame = (walk_frame + 1) % 3
    queue_redraw()

func _draw() -> void:
    var foot_offset := 0
    if moving:
        foot_offset = [-1, 0, 1][walk_frame]

    # Shadow.
    draw_rect(Rect2(-7, 7, 14, 4), Color("#2b5c31"))

    # Body.
    draw_rect(Rect2(-6, -8, 12, 13), Color("#26364b"))
    draw_rect(Rect2(-5, -6, 10, 8), Color("#3f6381"))

    # Head.
    draw_rect(Rect2(-6, -15, 12, 8), Color("#e4b58b"))
    draw_rect(Rect2(-7, -16, 14, 4), Color("#34343c"))
    draw_rect(Rect2(-5, -19, 10, 4), Color("#34343c"))

    # Directional face marker.
    if facing == Vector2.DOWN:
        draw_rect(Rect2(-4, -10, 2, 2), Color("#20232a"))
        draw_rect(Rect2(2, -10, 2, 2), Color("#20232a"))
    elif facing == Vector2.LEFT:
        draw_rect(Rect2(-6, -11, 2, 2), Color("#20232a"))
    elif facing == Vector2.RIGHT:
        draw_rect(Rect2(4, -11, 2, 2), Color("#20232a"))

    # Feet: three-step cycle gives the characteristic pixel walking motion.
    draw_rect(Rect2(-5 + foot_offset, 5, 4, 4), Color("#4b3030"))
    draw_rect(Rect2(1 - foot_offset, 5, 4, 4), Color("#4b3030"))
