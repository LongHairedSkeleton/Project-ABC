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
		$"../PointsManager".end_minigame()
	print(remaining_balls)
