extends KinematicBody2D

onready var area2d = $Area2D

var canMoveTo = {
  "ui_up": true,
  "ui_down": true,
  "ui_left": true,
  "ui_right": true,
}

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("ui_up"):
    setAreaPosition("ui_up")
    movePlayer("ui_up")

  if event.is_action_pressed("ui_down"):
    setAreaPosition("ui_down")
    movePlayer("ui_down")

  if event.is_action_pressed("ui_left"):
    setAreaPosition("ui_left")
    movePlayer("ui_left")

  if event.is_action_pressed("ui_right"):
    setAreaPosition("ui_right")
    movePlayer("ui_right")

func setAreaPosition(direction: String):
  var vec: Vector2

  match direction:
    "ui_up":
      vec = Vector2(0, -32)
    "ui_down":
      vec = Vector2(0, 32)
    "ui_left":
      vec = Vector2(-32, 0)
    "ui_right":
      vec = Vector2(32, 0)

  area2d.global_position = global_position + vec

func movePlayer(direction: String):
  var vec: Vector2

  match direction:
    "ui_up":
      vec = Vector2(0, -32)
    "ui_down":
      vec = Vector2(0, 32)
    "ui_left":
      vec = Vector2(-32, 0)
    "ui_right":
      vec = Vector2(32, 0)

  position = position + vec
