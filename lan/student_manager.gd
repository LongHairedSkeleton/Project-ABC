extends Control

onready var ip_input = $Node/LineEdit

func _ready():
	# Connect to our autoload signal using Godot 3 syntax
	Lan.connect("lecture_received", self, "_start_lecture")

func _start_lecture():
	get_tree().change_scene("res://lan/lecture_manager.tscn")

func _on_Button_pressed():
	var ip = ip_input.text
	if ip == "":
		ip = "127.0.0.1" # Localhost testing
	Lan.join_classroom(ip)

func _input(event):
	if event.is_action_pressed("enter"):
		$Node/Button.emit_signal("pressed")
