extends Node

var build_modes = ["View", "TerraForm", "DistrictBuilder"]
var mode = build_modes[0] 
var mode_type = "None"

onready var ui = get_node("UI")
onready var map = get_node("Map")

func _ready():
	ui.connect("start_terraform", self, "_on_mode_switch")
	ui.connect("start_district_build", self, "_on_mode_switch")
	ui.connect("start_view", self, "_on_mode_switch")
	map.connect("paint_mode_switch", self, "_on_paint_mode_switch")

	ui.update_debug_mode_indicator(mode, mode_type, map.is_painting)

func _on_mode_switch(mode_index, type):
	mode = build_modes[mode_index] 
	mode_type = type

	ui.update_debug_mode_indicator(mode, type, map.is_painting)
	map.reset_hover_hightlight()

func _on_paint_mode_switch():
	ui.update_debug_mode_indicator(mode, mode_type, map.is_painting)
