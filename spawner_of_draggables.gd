extends Control
class_name spawner

export var instance = preload("res://actividades/sorting/ball.tscn")

var ball_clone = instance.instance()

var loops = int(rand_range(6, 16))

var is_any_item_dragging = false

func divisible_by_2():
	loops = int(rand_range(6, 16))
	if loops % 2 != 0:
		divisible_by_2()

func roll():
	for i in (loops):
		ball_clone = instance.instance()
		match ball_clone.get_groups():
			"circle":
				ball_clone.texture = preload("res://Assets/WhiteLearn/shape_0003.png")
			"star":
				ball_clone.texture = preload("res://Assets/WhiteLearn/shape_0002.png")
			"square":
				ball_clone.texture = preload("res://Assets/WhiteLearn/shape_0004.png")
			"triangle":
				ball_clone.texture = preload("res://Assets/WhiteLearn/shape_0001.png")
		add_child(ball_clone)

func _ready():
	roll()
