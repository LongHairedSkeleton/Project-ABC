extends Control
class_name spawner

signal task_completed

export var instance = preload("res://actividades/sorting/ball.tscn")

var ball_clone = instance.instance()

var loops = int(rand_range(6, 16))

var is_any_item_dragging = false

func divisible_by_2():
	var loops: int = randi() % 5 + 3
	loops = loops * 2
	return loops

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

func end_minigame():
	if $PointsManager.points2 == $PointsManager.points1:
		var right = preload("res://right.tscn")
		$Control2.get_points(int(rand_range(1000, 1500)))
		var right_instance = right.instance()
		add_child(right_instance)
		
		yield(get_tree().create_timer(1.0), "timeout")
		emit_signal("task_completed")
	else:
		var wrong = preload("res://wrong.tscn")
		$Control2.get_points(int(rand_range(-750, -500)))
		var wrong_instance = wrong.instance()
		wrong_instance.current_exercise = "division_in_equal_parts"
		add_child(wrong_instance)
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().change_scene("res://actividades/sorting/division_in_equal_parts.tscn")
