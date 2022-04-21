extends CanvasLayer

export(ButtonGroup) var terrain_tools
export(ButtonGroup) var district_builder_tools

signal start_terraform(terrain_type)
signal start_district_build(district_type)
signal view_switch

func _ready():
	connect_tools(terrain_tools, "_on_terra_form_pressed")
	connect_tools(district_builder_tools, "_on_district_builder_pressed")

func _on_terra_form_pressed(terrain_type: String):
	unpress(district_builder_tools)
	emit_signal("start_terraform", terrain_type)

func _on_district_builder_pressed(district_type: String):
	unpress(terrain_tools)
	emit_signal("start_district_build", district_type)


# unpresses all buttons in the given button group
func unpress(button_group: ButtonGroup):
	for button in button_group.get_buttons():
		button.pressed = false

# connect the given set of tools(aka button group to the given function)
# also makes use of the tool name (aka button) as a binding for the receiving function
func connect_tools(button_group: ButtonGroup, receiving_function: String):
	for _tool in button_group.get_buttons(): 
		# the bind is used by the receiving function as the first or any number of arguments
		# for their params.
		_tool.connect("pressed", self, receiving_function, [_tool.get_name()])
	

		
