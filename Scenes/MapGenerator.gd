extends Node2D

var tile_scene = load("res://Scenes/Tile.tscn")

# represents number of tiles
var world_size = 5 

# base this from image size
# isometric boxes have 2:1 width:height ratio
var tile_width = 256 
var tile_height = 128 
var y_off = 0.85 # didn't know how I came up with this

onready var sorter = get_node("YSort")


func _ready():
	draw_world()

# add process for checking current mouse pointer location
func _process(delta):
	# for debugging
	track_mouse_loc()

func draw_world(): 
	for row in world_size:   # y
		for col in world_size: # x
			var x = col
			var y = row * y_off
			if row % 2 != 0:
				x -= 0.5	
			draw_tile(x, y)

func draw_tile(x, y):
	# resize i_hat and j_hat vectors accoriding to tile width and height	
		# divide tile_width by 2 since original takes more than 2 reference tiles
		# ref tile is 1:1
	var i_hat = Vector2(1 * tile_width / 2, 0.5 * tile_height)
	var j_hat = Vector2(-1 * tile_width / 2, 0.5 * tile_height)
	# note tile position/pivot is in bottom left of sprite


	var tile_position: Vector2 = (x * i_hat) + (y *  j_hat)

	var tile = tile_scene.instance()
	tile.type = "hex"
	tile.position = tile_position

	# YSort arranges draw order by y position. 
	get_node("YSort").add_child(tile)

func track_mouse_loc():
	var mouse_pos = get_global_mouse_position()
