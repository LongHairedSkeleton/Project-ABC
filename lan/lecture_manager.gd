extends Node

const SUBJECT_SCENES = {
	"Addition and subtraction": "res://actividades/math/Math.tscn",
	"Times and division": "res://actividades/math/Math.tscn",
	"conversion": "res://actividades/math/Math.tscn",
	"times": "res://actividades/math/Math.tscn",
	"problems": "res://actividades/math/Math.tscn",
	
	"division_in_equal_parts": "res://actividades/sorting/division_in_equal_parts.tscn",
	"spacial_geometry": "res://actividades/geometry/geometry.tscn",
	"drawing": "res://actividades/geometry/drawing.tscn",
	"spacial_notion": "res://actividades/geometry/holes.tscn"
}

var playlist = []
var current_scene_node = null

func _ready():
	generate_playlist(Lan.current_lecture)
	load_next_task()

func generate_playlist(lecture_data):
	playlist.clear()
	for subject in lecture_data.keys():
		var count = lecture_data[subject]
		for i in range(count):
			playlist.append(subject)
			

	# Optional: playlist.shuffle() if you want mixed order
func load_next_task():
	if is_instance_valid(current_scene_node):
		current_scene_node.queue_free()
		
	if playlist.empty():
		print("Lecture finished!")
		get_tree().quit()
		return
		
	var next_subject = playlist.pop_front()
	var scene_path = SUBJECT_SCENES[next_subject]
	
	var temp_scene = load(scene_path)
	current_scene_node = temp_scene.instance()

	if next_subject == "Addition and subtraction":
		current_scene_node.problem_type = current_scene_node.types.simple
	elif next_subject == "Times and division":
		current_scene_node.problem_type = current_scene_node.types.simple_plus
	elif next_subject == "conversion":
		current_scene_node.problem_type = current_scene_node.types.conversion
	elif next_subject == "times":
		current_scene_node.problem_type = current_scene_node.types.times
	elif next_subject == "problems":
		current_scene_node.problem_type = current_scene_node.types.problems

	add_child(current_scene_node)
	current_scene_node.connect("task_completed", self, "load_next_task")
