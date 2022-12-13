extends Area2D

onready var ray = $RayCast2D
onready var animPlayer = $AnimationPlayer

var tile_size = 32
var animation_speed = 20
var moving = false

var inputs = {
  "ui_right": Vector2.RIGHT,
  "ui_left": Vector2.LEFT,
  "ui_up": Vector2.UP,
  "ui_down": Vector2.DOWN
}

func _ready():
  position = position.snapped(Vector2.ONE * tile_size)
  position += Vector2.ONE * tile_size/2

func _unhandled_input(event):
  if moving:
    return
  for dir in inputs.keys():
    if event.is_action_pressed(dir):
      move(dir)

func move(dir):
  ray.cast_to = inputs[dir] * tile_size
  ray.force_raycast_update()

  if !ray.is_colliding():
    # position += inputs[dir] * tile_size
    var tween = get_tree().create_tween()
    tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0 / animation_speed).set_trans(Tween.TRANS_SINE)
    moving = true
    # animPlayer.play(dir)
    tween.tween_callback(self, 'allowMovement')
    moving = false

func allowMovement():
  moving = false
