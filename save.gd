extends Node

var current_act = 0

var points = 0
var lectures = {}

var mistakes = {}

func add_mistake(subject_name: String):
	if not subject_name in mistakes:
		mistakes[subject_name] = 1
	else:
		mistakes[subject_name] += 1
	print("Mistakes updated: ", mistakes)
