extends Node2D

var tile_scene = load("res://Scenes/Tile.tscn")
var grid_size = 5 
# base this from image size
# isometric boxes have 2:1 width:height ratio
var tile_width = 256 
var tile_height = 128 
onready var sorter = get_node("YSort")


func _ready():
	init_map()

# add process for checking current mouse pointer location
func _process(delta):
	track_mouse_loc()

func init_map(): 
	
	# go through rows
	for row in range(grid_size):
		# then go through column of row
		for col in range(grid_size):
			var x = row * tile_width / 2
			# to match one is to one correspondence with reference tile
				# essentially without having the tile width, the isometric equivalent of the transformation 
				# equals twice what a single tile takes space. ; >
				# https://www.youtube.com/watch?v=04oQ2jOUjkU
			# this code however is taken from this article which IMO 
				# is much simpler. https://gamedevelopment.tutsplus.com/tutorials/creating-isometric-worlds-primer-for-game-developers-updated--cms-28392
			var y = col * tile_height 
			placeTile(x, y)


func placeTile(x, y):
	var isometric_coord = cartestionToIsometric(x, y)
	# var isometric_coord = Vector2(x, y) # just a placeholder really a cartesian
	# instance new tile
	var tile = tile_scene.instance()
	# set position to isometric coord
	tile.position = isometric_coord
	sorter.add_child(tile)

func cartestionToIsometric(x, y):
	var isometric_coord = Vector2()

	isometric_coord.x = x - y
	isometric_coord.y = (x + y) / 2


	return isometric_coord

func track_mouse_loc():
	var mouse_pos = get_global_mouse_position()
	print("x: ", mouse_pos.x)
	print("y: ", mouse_pos.y, "\n")
