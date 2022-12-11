extends Sprite

onready var moveTo = $MoveTo
onready var destinationPos: Vector2 = $MoveTo.global_position

export var moveSpeed: float = 500

var isMoving: bool = false

var canMoveTo = {
  "ui_up": true,
  "ui_down": true,
  "ui_left": true,
  "ui_right": true,
}

func _input(event: InputEvent) -> void:
  if (isMoving):
    return

  var dirStr: String = ""

  if event.is_action_pressed("ui_up"):      dirStr = "ui_up"
  elif event.is_action_pressed("ui_down"):  dirStr = "ui_down"
  elif event.is_action_pressed("ui_left"):  dirStr = "ui_left"
  elif event.is_action_pressed("ui_right"): dirStr = "ui_right"

  if (dirStr != ""):
    movePlayer(dirStr)

func _process(delta):
  if (isMoving):
    global_position = $MoveTo.global_position.move_toward(destinationPos, delta * moveSpeed)

  if global_position == destinationPos:
    isMoving = false

func movePlayer(direction: String):
  isMoving = true
  destinationPos = global_position + setVectorOnInput(direction)


# Helpers

func setVectorOnInput(inputStr: String):
  match inputStr:
    "ui_up":    return Vector2(0, -32)
    "ui_down":  return Vector2(0, 32)
    "ui_left":  return Vector2(-32, 0)
    "ui_right": return Vector2(32, 0)