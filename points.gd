extends Control

func _ready():
	$Points.modulate = Color.cyan
	$Points.bbcode_text = "[wave][center]pontos:" + str(Save.points)

func get_points(points):
	Save.points += points

	$Points.bbcode_text = "[wave amp=50 freq=5][center]pontos:" + str(Save.points)
	
	$Points.rect_pivot_offset = $Points.rect_size / 2
	
	var tween = create_tween()
	var original_pos_y = rect_position.y 

	if points >= 0:
		tween.tween_property($Points, "modulate", Color.green, 0.05)\
			.set_trans(Tween.TRANS_QUAD)\
			.set_ease(Tween.EASE_OUT)

		tween.parallel().tween_property($Points, "rect_scale", Vector2(1.5, 1.5), 0.2)\
			.set_trans(Tween.TRANS_QUAD)\
			.set_ease(Tween.EASE_OUT)

		tween.tween_property($Points, "modulate", Color.cyan, 0.7)\
			.set_trans(Tween.TRANS_QUAD)\
			.set_ease(Tween.EASE_IN)

		tween.parallel().tween_property($Points, "rect_scale", Vector2(1, 1), 0.2)\
			.set_trans(Tween.TRANS_QUAD)\
			.set_ease(Tween.EASE_IN)

	else:
		tween.tween_property($Points, "modulate", Color.red, 0.05)\
			.set_trans(Tween.TRANS_QUAD)\
			.set_ease(Tween.EASE_OUT)

		tween.parallel().tween_property($Points, "rect_position:y", original_pos_y + 30.0, 0.2)\
			.set_trans(Tween.TRANS_QUAD)\
			.set_ease(Tween.EASE_OUT)

		tween.tween_property($Points, "modulate", Color.cyan, 0.7)\
			.set_trans(Tween.TRANS_QUAD)\
			.set_ease(Tween.EASE_IN)

		# Retorna o texto suavemente para a posição Y original em 0.2 segundos
		tween.parallel().tween_property($Points, "rect_position:y", original_pos_y, 0.2)\
			.set_trans(Tween.TRANS_QUAD)\
			.set_ease(Tween.EASE_IN)
