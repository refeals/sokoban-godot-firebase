extends Node2D

var Checker = preload("res://scenes/Checker.tscn")
var Box = preload("res://scenes/Box.tscn")

onready var tilemap = $TileMap
onready var player = $Player
onready var checkerContainer = $Checkers
onready var boxContainer = $Boxes

var data := "__#####\n###   #\n# $ # ##\n# #  . #\n#    # #\n## #   #\n_#@  ###\n_#####"
var x = 0
var y = 0
var tile_size = 32

func _ready() -> void:
  draw_level()

func draw_level() -> void:
  for c in data:
    draw_tile(c)

func draw_tile(c: String) -> void:
  match c:
    "#":
      draw_tilemap(0)
      x += tile_size
    " ":
      draw_tilemap(1)
      x += tile_size
    "@":
      set_player_position()
      x += tile_size
    ".":
      draw_checker()
      x += tile_size
    "$":
      draw_box()
      x += tile_size
    "\n":
      x = 0
      y += tile_size
    "_":
      x += tile_size

func draw_tilemap(id: int) -> void:
  var tile_id = tilemap.tile_set.find_tile_by_name("sokoban_spritesheet.png " + String(id))
  tilemap.set_cell(x / tile_size, y / tile_size, tile_id)

func set_player_position() -> void:
  player.position.x = x + tile_size / 2
  player.position.y = y + tile_size / 2
  tilemap.set_cell(x / tile_size, y / tile_size, 1)

func draw_checker() -> void:
  var checker = Checker.instance()
  checker.position.x = x
  checker.position.y = y
  checkerContainer.add_child(checker)
  tilemap.set_cell(x / tile_size, y / tile_size, 1)

func draw_box() -> void:
  var box = Box.instance()
  box.position.x = x
  box.position.y = y
  boxContainer.add_child(box)
  tilemap.set_cell(x / tile_size, y / tile_size, 1)
