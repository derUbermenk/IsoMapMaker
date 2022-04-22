extends Node

var build_modes = ["View", "TerraForm", "DistrictBuilder"]
var mode = build_modes[0] 
var mode_type = "None"

onready var ui = get_node("UI")

func _ready():
	ui.connect("start_terraform", self, "_on_mode_switch")
	ui.connect("start_district_build", self, "_on_mode_switch")
	ui.connect("start_view", self, "_on_mode_switch")

	ui.update_debug_mode_indicator(mode, mode_type)

func _on_mode_switch(mode_index, type):
	mode = build_modes[mode_index] 
	mode_type = type

	ui.update_debug_mode_indicator(mode, type)




