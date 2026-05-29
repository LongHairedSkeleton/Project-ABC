extends spawner

var classes = ["circle", "square", "triangle", "star"]

func roll():
	for i in loops:
		classes.shuffle()
		ball_clone.add_to_group(classes[1])

func _on_hole_points(points):
	pass # Replace with function body.

func _on_hole2_points(points):
	pass # Replace with function body.

func _on_hole3_points(points):
	pass # Replace with function body.

func _on_hole4_points(points):
	pass # Replace with function body.
