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
var is_valid_district_location
var invalid_district_locations = ['ocean', 'mountain']
var map

var terraForm_hoverColor =  Color("f1fac3")
var districtBuilder_validColor = Color("8dd983")
var districtBuilder_invalidColor = Color("ffb0b0")

onready var tile_area = get_node("TileArea") 
onready var tile_sprite = get_node("Terrain")

func _ready():
	_update_position(x, y)
	update_terrain(terrain_type)
	pass
	
# tile setup code

# initial setup
	# I added the the underscore below the name to prevent overshadowing
	# which in turn causes problem with placing the right value for the node
	# defined variable
func init(x_, y_, terrain_type_, map_):
	x = x_
	y = y_
	map = map_
	terrain_type = terrain_type_

# set converted tile positions to screen coords from isometric plane
	# and vertical offset values when hovering
func _update_position(x_, y_):
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
func update_terrain(terrain_type_):
	terrain_type = terrain_type_
	terrain_texture = _load_texture("terrain", terrain_type)

	tile_sprite.texture = terrain_texture 

func _load_texture(folder, type) -> Resource:
	return load("res://Assets/Tiles/" + folder + "/" + type + "/" + type + "_1" + ".png")

# interaction code

func _process(delta):
	pass

func handle_tile_click():
	if Input.is_mouse_button_pressed(1) && map.hovered_tile != null:
		match map.map_builder.mode:
			"TerraForm":
				terraform()
			"DistrictBuilder":
				build_district()
			"View":
				pass

func build_district():
	print(is_valid_district_location)
	if is_valid_district_location == true:
		map.hovered_tile.update_terrain(map.map_builder.mode_type)
	else:
		pass

func validate_build_location():
	# set initial value as false. 
		# This is to avoid conflicts in future validations where the value
		# is that of the former validation
	is_valid_district_location = false

	if terrain_type in invalid_district_locations:
		modulate = districtBuilder_invalidColor
	else:
		is_valid_district_location = true
		modulate = districtBuilder_validColor 

func terraform():
	map.hovered_tile.update_terrain(map.map_builder.mode_type)

func _input(event):
	if event is InputEventMouseButton: 
		if event.button_index == 1:
			map.is_painting = event.is_pressed()
			map.emit_signal("paint_mode_switch")

func _on_TileArea_mouse_exited():
	if map.map_builder.mode == "View":
		position = rest_position
	else:
		modulate = Color("ffffff")

	map.hovered_tile = null 

func _on_TileArea_mouse_entered():
	map.hovered_tile = self

	if map.map_builder.mode == "TerraForm":
		modulate = terraForm_hoverColor
		if map.is_painting: update_terrain(map.map_builder.mode_type)
	elif map.map_builder.mode == "DistrictBuilder":
		validate_build_location()
	else:
		position = hover_position

func _on_TileArea_input_event(viewport:Node, event:InputEvent, shape_idx:int):
	if (event is InputEventMouseButton && (event.is_pressed()) && event.button_index == 1): 
		if map.map_builder.mode == "TerraForm":
			update_terrain(map.map_builder.mode_type)
		else: 
			pass
	else:
		pass
