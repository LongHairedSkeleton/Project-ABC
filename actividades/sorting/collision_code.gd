extends Area2D

signal points(side1, side2)
signal task_completed

var remaining_balls = 0

func _on_Area2D_area_entered(area):
	remaining_balls = get_tree().get_nodes_in_group("ball").size()
	
	if area.is_in_group("ball"):
		if self.is_in_group("side1"):
			emit_signal("points", 1, 0)
		elif self.is_in_group("side2"):
			emit_signal("points", 0, 1)
		area.queue_free() # Destroys the ball instantly so it can't hit anything else
		remaining_balls -= 1
		prostate_exam()

func prostate_exam():
	if remaining_balls == 0:
		end_minigame()
	print(remaining_balls)

func end_minigame():
	if $"../PointsManager".points1 == $"../PointsManager".points2:
		var right = preload("res://right.tscn")
		$"../Control2".get_points(int(rand_range(1000, 1500)))
		var right_instance = right.instance()
		add_child(right_instance)
		
		yield(get_tree().create_timer(1.0), "timeout")
		emit_signal("task_completed")
	else:
		var wrong = preload("res://wrong.tscn")
		$"../Control2".get_points(int(rand_range(-750, -500)))
		var wrong_instance = wrong.instance()
		add_child(wrong_instance)
