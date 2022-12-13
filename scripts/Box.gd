extends Area2D

onready var ray = $RayCast2D

signal updateActive(_active)

var tile_size = 32
var animation_speed = 20
var active = false

var inputs = {
  "ui_right": Vector2.RIGHT,
  "ui_left": Vector2.LEFT,
  "ui_up": Vector2.UP,
  "ui_down": Vector2.DOWN
}


func getItemType(): return "Box"

func _ready():
  pass

func checkIfCanMove(dir):
  ray.cast_to = inputs[dir] * tile_size
  ray.force_raycast_update()

  if !ray.is_colliding():
    return true

  var collider = ray.get_collider()
  if collider.has_method("getItemType") and collider.getItemType() != "Box":
    return true
  else:
    return false

func createMovement(dir):
  var tween = get_tree().create_tween()
  tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0 / animation_speed).set_trans(Tween.TRANS_SINE)

func _on_Box_area_entered(area: Area2D) -> void:
  if area.has_method("getItemType"):
    if area.getItemType() == "Checker":
      emit_signal("updateActive", true)

func _on_Box_area_exited(area: Area2D) -> void:
  if area.has_method("getItemType"):
    if area.getItemType() == "Checker":
      emit_signal("updateActive", false)

func _on_Box_updateActive(_active) -> void:
  modulate  = Color(1, 1, 1, 1) if _active else Color(200, 200, 200, 1.0)
  active = _active
