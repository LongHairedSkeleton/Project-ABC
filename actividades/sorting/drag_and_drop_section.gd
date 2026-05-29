extends Control

export var instance = preload("res://ball.tscn")
var loops = 4

func roll():
	for i in (loops):
		var ball_clone = instance.instance()
		add_child(ball_clone)

func _ready():
	roll()

# This will track if ANY item is currently being dragged
var is_any_item_dragging = false
