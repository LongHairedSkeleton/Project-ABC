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
	"spacial_notion": "res://actividades/geometry/holes.tscn",
	
	"rec_letras":"res://actividades/portuguese/portuguese.tscn",
	"juntar_letras":"res://actividades/portuguese/portuguese.tscn",
	"interpretacao":"res://actividades/portuguese/portuguese.tscn",
	"escrita_correta":"res://actividades/portuguese/portuguese.tscn",
	"generos":"res://actividades/portuguese/portuguese.tscn",
	"maiuscula_minus":"res://actividades/portuguese/portuguese.tscn",
	"pontuacao":"res://actividades/portuguese/portuguese.tscn",
	"acentos":"res://actividades/portuguese/portuguese.tscn",
	"singular_plural":"res://actividades/portuguese/portuguese.tscn",
	"genero_gramatical":"res://actividades/portuguese/portuguese.tscn",
	"verbos":"res://actividades/portuguese/portuguese.tscn",
	"substantivos":"res://actividades/portuguese/portuguese.tscn",
	"analise_ling":"res://actividades/portuguese/portuguese.tscn"
}

var playlist = []
var current_scene_node = null

func _ready():
	Save.solo_run = 0
	
	var active_lecture = Lan.current_lecture if not Lan.current_lecture.empty() else Save.lectures
	
	generate_playlist(active_lecture)
	load_next_task()
	print(playlist)

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
		get_tree().change_scene("res://results.tscn")
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

	elif next_subject == "rec_letras":
		current_scene_node.problem_type = current_scene_node.types.rec_letras
	elif next_subject == "juntar_letras":
		current_scene_node.problem_type = current_scene_node.types.juntar_letras
	elif next_subject == "interpretacao":
		current_scene_node.problem_type = current_scene_node.types.interpretacao
	elif next_subject == "escrita_correta":
		current_scene_node.problem_type = current_scene_node.types.escrita_correta
	elif next_subject == "generos":
		current_scene_node.problem_type = current_scene_node.types.generos
	elif next_subject == "maiuscula_minus":
		current_scene_node.problem_type = current_scene_node.types.maiuscula_minus
	elif next_subject == "pontuacao":
		current_scene_node.problem_type = current_scene_node.types.pontuacao
	elif next_subject == "acentos":
		current_scene_node.problem_type = current_scene_node.types.acentos
	elif next_subject == "singular_plural":
		current_scene_node.problem_type = current_scene_node.types.singular_plural
	elif next_subject == "genero_gramatical":
		current_scene_node.problem_type = current_scene_node.types.genero_gramatical
	elif next_subject == "verbos":
		current_scene_node.problem_type = current_scene_node.types.verbos
	elif next_subject == "substantivos":
		current_scene_node.problem_type = current_scene_node.types.substantivos
	elif next_subject == "analise_ling":
		current_scene_node.problem_type = current_scene_node.types.analise_ling

	add_child(current_scene_node)
	current_scene_node.connect("task_completed", self, "load_next_task")
