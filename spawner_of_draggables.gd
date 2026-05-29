extends Control
class_name spawner

export var instance = preload("res://actividades/sorting/ball.tscn")
export var loops = 4
var ball_clone = instance.instance()

func roll():
	for i in (loops):
		ball_clone = instance.instance()
		add_child(ball_clone)

func _ready():
	roll()

# This will track if ANY item is currently being dragged
var is_any_item_dragging = false
