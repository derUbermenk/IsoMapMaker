extends Node2D

var tile_scene = load("res://Scenes/MapSupport/Tile.tscn")

# represents number of tiles
var world_size = 5 

# just delete this later only for tests
var ocean = "ocean"
var forest = "forest"
var plain = "plain"
var asphalt = "asphalt"

var map_data = [
	[ocean, ocean, ocean, ocean, ocean ],
	[ocean, ocean, ocean, ocean, ocean ],
	[ocean, ocean, ocean, ocean, ocean ],
	[ocean, ocean, ocean, ocean, ocean ],
	[ocean, ocean, ocean, ocean, ocean ],
]

var hovered_tile

onready var tiles = get_node("Tiles")
onready var map_builder = get_parent() 

func _ready():
	draw_map()

# add process for checking current mouse pointer location
func _process(delta):
	pass

func draw_map(): 
	for row in world_size:   # y
		for col in world_size: # x
			var x = col
			var y = row 
			if row % 2 != 0:
				x -= 0.5	
			var tile = tile_scene.instance()
			# init the tile with the given x y positions (still gets transformed)
				# on the map(self)
			tile.init(x, y, map_data[row][col], self)
			tiles.add_child(tile)


# reset the color of the hovered tile if there is any
func reset_hover_hightlight():
	if hovered_tile != null:
		hovered_tile.modulate = Color(1, 1, 1)
	pass

func track_mouse_loc():
	var mouse_pos = get_global_mouse_position()
	print(mouse_pos)
