extends Node2D

# for vertical offset effect on mouse hover
var hover_position
var rest_position

# for isometric view distances

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

# some abstract tile attributes
var x
var y
var terrain_type
var terrain_texture

onready var tile_area = get_node("TileArea") 
onready var tile_sprite = get_node("Sprite")

func _ready():
	tile_sprite.texture = terrain_texture 
	
# tile setup code

# setup the value of the sprite
func init(x_, y_, terrain_type_):
	_set_tile_positions(x_, y_)
	_set_tile_type(terrain_type_)

# set converted tile positions to screen coords from isometric plane
	# and vertical offset values when hovering
func _set_tile_positions(x_, y_):
	# resize i_hat and j_hat vectors accoriding to tile width and height	
		# divide tile_width by 2 since original takes more than 2 reference tiles
		# ref tile is 1:1
	var i_hat = Vector2(1 * tile_width / 2, 0.5 * tile_height)
	var j_hat = Vector2(-1 * tile_width / 2, 0.5 * tile_height)
	# note tile position/pivot is in bottom left of sprite

	x = x_
	y = y_
	position = (x_ * i_hat) + (y_ * y_off *  j_hat)
	rest_position = position
	hover_position = Vector2(position.x, position.y - 128 * 0.10)

# set tile terrain type and image texture
func _set_tile_type(terrain_type_):
	terrain_type = terrain_type_
	terrain_texture = load("res://Assets/Tiles/terrain/" + terrain_type + ".png")

# interaction code

func _process(delta):
	pass

func _on_TileArea_mouse_exited():
	position = rest_position

func _on_TileArea_mouse_entered():
	position = hover_position




