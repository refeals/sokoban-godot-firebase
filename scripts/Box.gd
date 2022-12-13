extends Area2D

var tile_size = 32
var animation_speed = 20

var inputs = {
  "ui_right": Vector2.RIGHT,
  "ui_left": Vector2.LEFT,
  "ui_up": Vector2.UP,
  "ui_down": Vector2.DOWN
}

func createMovement(dir, obj = self):
  var tween = get_tree().create_tween()
  tween.tween_property(obj, "position", position + inputs[dir] * tile_size, 1.0 / animation_speed).set_trans(Tween.TRANS_SINE)

