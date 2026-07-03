extends Node

var points1 = 0
var points2 = 0

func _on_Area2D_points(side1, side2):
	add_points(side1, side2)

func _on_Area2D2_points(side1, side2):
	add_points(side1, side2)

func add_points(side1, side2):
	points1 += side1
	points2 += side2

	$"../Area2D/RichTextLabel".text = str(points1)
	$"../Area2D2/RichTextLabel".text = str(points2)


