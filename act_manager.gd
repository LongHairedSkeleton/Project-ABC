extends Node

enum types {simple, problems, simple_plus, times, conversion}

func _on_Button_pressed(): change(types.simple, "res://actividades/math/Math.tscn")
func _on_Button3_pressed():change(types.simple_plus, "res://actividades/math/Math.tscn")
func _on_Button2_pressed():change(types.times, "res://actividades/math/Math.tscn")
func _on_Button4_pressed():change(types.problems, "res://actividades/math/Math.tscn")
func _on_Button9_pressed():change(types.conversion, "res://actividades/math/Math.tscn")
func _on_Button5_pressed():change(0, "res://actividades/sorting/division_in_equal_parts.tscn")
func _on_Button6_pressed():change(0, "res://actividades/geometry/drawing.tscn")
func _on_Button7_pressed():change(0, "res://actividades/geometry/geometry.tscn")
func _on_Button8_pressed():change(0, "res://actividades/geometry/holes.tscn")

func change(act, scene):
	Save.current_act = act
	get_tree().change_scene(scene)
