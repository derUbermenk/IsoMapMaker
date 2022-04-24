extends Node2D

signal paint_mode_switch

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
var paint_mode = false

onready var tiles = get_node("Tiles")
onready var map_builder = get_parent() 

func _ready():
	draw_map()

# add process for checking current mouse pointer location
func _process(delta):
	pass

func draw_map(): 
	var last_cube_coord = Vector3() # instantiate a cube coord x == q, y == r, z == s

	for row in world_size:   # y

		# the cube coord of the first column in this row
		var row_initial_tile_cube_coord = Vector3(last_cube_coord.x, last_cube_coord.y, last_cube_coord.z)

		for col in world_size: # x
			row_initial_tile_cube_coord += Vector3(1, -1, 0)
			var cartesian_coordinate = Vector2(col, row)
			if row % 2 != 0: cartesian_coord.x -= 0.5	

			var tile = tile_scene.instance()
			# init the tile with the given x y positions (still gets transformed)
				# on the map(self)
			tile.init(cartesian_coord, row_initial_tile_cube_coord, map_data[row][col], self)
			tiles.add_child(tile)
		
		# compute q r s values for next row
		if row == 0 or row % 2 == 0: last_cube_coord.x -= 1 # q
		last_cube_coord.y += 1                              # r
		if row % 2 != 0: s -= 1


# reset the color of the hovered tile if there is any
func reset_hover_hightlight():
	if hovered_tile != null:
		hovered_tile.modulate = Color(1, 1, 1)
	pass

func track_mouse_loc():
	var mouse_pos = get_global_mouse_position()
	print(mouse_pos)

# function code for assigning cube coordinate to tiles
	# wrote this only as reference for the cube coordinate assignment in 
	# draw_map
func hexgrid_cube_coords():
	var q = 0
	var r = 0
	var s = 0

	for row in world_size:
		# start with the values set after last row or the origin depending on the case
		var row_q = q
		var row_s = s
		var row_r = r
		for col in world_size:
			# row_r does not change
			# assign the column values
			row_q += 1
			row_s -= 1
			row_r

		if row == 0 or row % 2 == 0: q -= 1
		if row % 2 != 0: s -= 1
		r += 1

		
		
		
		
			