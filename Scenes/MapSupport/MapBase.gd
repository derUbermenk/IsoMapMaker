extends Node2D

var tile_scene = load("res://Scenes/MapSupport/Tile.tscn")

# represents number of tiles
var world_size = 5 




# just delete this later only for tests
var ocean = "ocean"
var plain = "plain"
var land = "land"
var asphalt = "asphalt"

var map_data = [
	[ocean, ocean, ocean, ocean, ocean ],
	[ocean, land, land, land, ocean ],
	[ocean, land, asphalt, plain, ocean ],
	[ocean, asphalt, land, land, ocean ],
	[ocean, ocean, ocean, ocean, ocean ],
]

onready var tiles = get_node("Tiles")


func _ready():
	draw_world()

# add process for checking current mouse pointer location
func _process(delta):
	pass

func draw_world(): 
	for row in world_size:   # y
		for col in world_size: # x
			var x = col
			var y = row 
			if row % 2 != 0:
				x -= 0.5	
			var tile = tile_scene.instance()
			tile.init(x, y, map_data[row][col])
			tiles.add_child(tile)

func track_mouse_loc():
	var mouse_pos = get_global_mouse_position()
	print(mouse_pos)
