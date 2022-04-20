extends Node2D

var tile_scene = load("res://Scenes/Tile.tscn")

# represents number of tiles
var world_size = 5 

# base this from image size
# isometric boxes have 2:1 width:height ratio

# this values where originally at
	# 256, 128, 0.85 respectively.
	# setting y_off to 0.865 also creates nice borders
	# provided tile width and height are unchanged.
	# 256 is the width of the tile, the square base tile to be specific
	# 128 would be the height as explained from the ratio above.
	# y_offset would be the offset to make each row of tile connect to each other. This value
	# was acquired via trial and error. Increasing it would increase the distance between rows,
	# decreasing otherwise.

	# the values where changed because there were still small offsets between the tiles in the x direction
	# https://www.youtube.com/watch?v=04oQ2jOUjkU&t=212s
var tile_width = 252
var tile_height = 126 
var y_off = 0.8726 # didn't know how I came up with this

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
			draw_tile(x, y, map_data[row][col])

func draw_tile(x, y, type):
	# resize i_hat and j_hat vectors accoriding to tile width and height	
		# divide tile_width by 2 since original takes more than 2 reference tiles
		# ref tile is 1:1
	var i_hat = Vector2(1 * tile_width / 2, 0.5 * tile_height)
	var j_hat = Vector2(-1 * tile_width / 2, 0.5 * tile_height)
	# note tile position/pivot is in bottom left of sprite


	var tile_position: Vector2 = (x * i_hat) + (y *  j_hat)

	var tile = tile_scene.instance()
	tile.type = type 
	tile.position = tile_position

	# YSort arranges draw order by y position. 
	get_node("YSort").add_child(tile)

func track_mouse_loc():
	var mouse_pos = get_global_mouse_position()
