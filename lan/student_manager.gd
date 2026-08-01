extends Control

onready var ip_input = $Node/LineEdit

func _ready():
	Lan.connect("lecture_received", self, "_start_lecture")

func _start_lecture():
	get_tree().change_scene("res://lan/lecture_manager.tscn")

func _on_Button_pressed():
	var ip = ip_input.text.strip_edges()
	if ip == "":
		ip = "127.0.0.1"
	Lan.join_classroom(ip)

func _input(event):
	if event.is_action_pressed("enter"):
		$Node/Button.emit_signal("pressed")

func _on_Solo_Button_pressed():
	pass #
