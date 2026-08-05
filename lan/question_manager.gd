extends Control

onready var addition_subtraction_input = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer/LineEdit"
onready var times_division = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer2/LineEdit"
onready var problems = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer4/LineEdit"
onready var times = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer3/LineEdit"
onready var conversion = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer5/LineEdit"

onready var division_in_equal_parts = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer6/LineEdit"
onready var spacial_geometry = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer7/LineEdit"
onready var drawing = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer8/LineEdit"
onready var spacial_notion = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer9/LineEdit"

onready var rec_letras  =   $"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer6/LineEdit"
onready var juntar_letras =$"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer7/LineEdit"
onready var interpretacao =$"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer8/LineEdit"
onready var escrita_correta =$"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer9/LineEdit"
onready var generos =$"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer10/LineEdit"
onready var maiuscula_minus =$"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer11/LineEdit"
onready var pontuacao =$"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer12/LineEdit"
onready var acentos  =$"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer13/LineEdit"
onready var singular_plural =$"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer14/LineEdit"
onready var genero_gramatical =$"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer15/LineEdit"
onready var verbos =$"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer16/LineEdit"
onready var substantivos =$"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer17/LineEdit"
onready var analise_ling =$"TabContainer/português/ScrollContainer2/VBoxContainer/HBoxContainer18/LineEdit"

func _on_Button_pressed():
	Lan.host_classroom()
	
	var lecture_data = {
		"Addition and subtraction": int(addition_subtraction_input.text),
		"Times and division": int(times_division.text),
		"problems": int(problems.text),
		"times": int(times.text),
		"conversion": int(conversion.text),
		
		"division_in_equal_parts": int(division_in_equal_parts.text),
		"spacial_geometry": int(spacial_geometry.text),
		"drawing": int(drawing.text),
		"spacial_notion": int(spacial_notion.text),
		
		"rec_letras": int(rec_letras.text),
		"juntar_letras": int(juntar_letras.text),
		"interpretacao": int(interpretacao.text),
		"escrita_correta": int(escrita_correta.text),
		"generos": int(generos.text),
		"maiuscula_minus": int(maiuscula_minus.text),
		"pontuacao": int(pontuacao.text),
		"acentos": int(acentos.text),
		"singular_plural": int(singular_plural.text),
		"genero_gramatical": int(genero_gramatical.text),
		"verbos": int(verbos.text),
		"substantivos": int(substantivos.text),
		"analise_ling": int(analise_ling.text),
	}
# 2. Guarda no Save e na variável global do Lan ANTES de ligar a rede
	if "Save" in self or has_node("/root/Save"):
		Save.lectures = lecture_data
	Lan.current_lecture = lecture_data
	
	# 3. Abre o servidor de rede. 
	# A partir DESTE MOMENTO, qualquer aluno que conectar vai disparar 
	# o '_on_peer_connected' no Lan e receber essa 'current_lecture' na hora!
	Lan.host_classroom()
	
	# 4. Efeitos visuais da tela do professor
	$AnimationPlayer.play("fade out")
	$RichTextLabel2.bbcode_text = "[center][wave]seu código é: [/wave][tornado]" + Lan.get_classroom_ip() + "[/tornado][/center]"

func _on_Go_Back_pressed():
	get_tree().change_scene("res://account/account_main_scene.tscn")

func reset_all_inputs_to_one():
	var all_inputs = [
		addition_subtraction_input, times_division, problems, times, conversion,
		division_in_equal_parts, spacial_geometry, drawing, spacial_notion,
		rec_letras, juntar_letras, interpretacao, escrita_correta, generos,
		maiuscula_minus, pontuacao, acentos, singular_plural, genero_gramatical,
		verbos, substantivos, analise_ling
	]
	
	for input in all_inputs:
		if input:
			input.text = "1"

func _ready():
	if Save.solo_run == 1:
		reset_all_inputs_to_one()
		_on_Button_pressed()
		#yield(get_tree().create_timer(0.1),"timeout")
		
		var full_text = $RichTextLabel2.bbcode_text
		var target_phrase = "[center][wave]seu código é:"

		var start_index = full_text.find(target_phrase)

		if start_index != -1:
	# Calculate the index right after the phrase
			var code_index = start_index + target_phrase.length()
	
	# Extract the IP code, stripping any accidental extra spaces
			var ip_code = full_text.substr(code_index).strip_edges()
		
			Lan.join_classroom(ip_code)
			get_tree().change_scene("res://lan/lecture_manager.tscn")
