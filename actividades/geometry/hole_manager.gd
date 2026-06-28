extends spawner

var classes = ["circle", "square", "triangle", "star"]

func roll():
	for i in range(loops):
		var ball_clone = instance.instance()
		
		classes.shuffle()
		var chosen_shape = classes[0] 
		
		ball_clone.add_to_group(chosen_shape)
		ball_clone.position = Vector2(500, 900)
		
		match chosen_shape:
			"circle":
				ball_clone.texture = preload("res://Assets/WhiteLearn/shape_0003.png")
			"star":
				ball_clone.texture = preload("res://Assets/WhiteLearn/shape_0002.png")
			"square":
				ball_clone.texture = preload("res://Assets/WhiteLearn/shape_0004.png")
			"triangle":
				ball_clone.texture = preload("res://Assets/WhiteLearn/shape_0001.png")

		add_child(ball_clone)

func check_remaining():
	var child_count = 0
	for child in get_children():
		if child is Area2D:
			child_count += 1
	if child_count == 4:
		yield(get_tree().create_timer(1),"timeout")
		emit_signal("task_completed")

func _on_hole_points(points):
	pass # Replace with function body.

func _on_hole2_points(points):
	pass # Replace with function body.

func _on_hole3_points(points):
	pass # Replace with function body.

func _on_hole4_points(points):
	pass # Replace with function body.
