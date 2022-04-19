extends Node2D

var hover_position
var rest_position

onready var tile_area = get_node("TileArea") 

func _ready():
	# set rest position as the position on instance
	rest_position = position
	hover_position = Vector2(position.x, position.y - 128 * 0.10 ) 


func _process(delta):
	pass

func _on_TileArea_mouse_exited():
	position = rest_position

func _on_TileArea_mouse_entered():
	position = hover_position
