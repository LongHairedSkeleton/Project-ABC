extends Control

onready var botao_reforco = $ScrollContainer/VBoxContainer/Button2
onready var label_portugues = $ScrollContainer/VBoxContainer/port
onready var tet = $ScrollContainer/VBoxContainer/RichTextLabel

func _ready():
	PlayerVars.player_data["max_points"] = Save.points
	PlayerVars.save_game_data()
	
	$ScrollContainer/VBoxContainer/RichTextLabel2.bbcode_text = "[wave][center]" + str(PlayerVars.player_data["player_name"]) + " ganhou " + "[rainbow]" + str(Save.points) + " pontos"

	var lectures = Lan.current_lecture if not Lan.current_lecture.empty() else Save.lectures
	var mistakes = Save.mistakes if "mistakes" in Save and Save.mistakes != null else {}
	
	# Lista apenas com as matérias de Português para controle específico
	var portuguese_subjects = [
		"rec_letras", "juntar_letras", "interpretacao", "escrita_correta",
		"generos", "maiuscula_minus", "pontuacao", "acentos",
		"singular_plural", "genero_gramatical", "verbos", "substantivos", "analise_ling"
	]
	
	var subjects_ui = {
		"Addition and subtraction": $ScrollContainer/VBoxContainer/RichTextLabel3,
		"Times and division": $ScrollContainer/VBoxContainer/RichTextLabel5,
		"conversion": $ScrollContainer/VBoxContainer/RichTextLabel8,
		"problems": $ScrollContainer/VBoxContainer/RichTextLabel7,
		"times": $ScrollContainer/VBoxContainer/RichTextLabel6,
		"division_in_equal_parts": $ScrollContainer/VBoxContainer/RichTextLabel4,
		"drawing": $ScrollContainer/VBoxContainer/RichTextLabel10,
		"spacial_geometry": $ScrollContainer/VBoxContainer/RichTextLabel9,
		"spacial_notion": $ScrollContainer/VBoxContainer/RichTextLabel11,
		
		"rec_letras": $ScrollContainer/VBoxContainer/Label6,
		"juntar_letras": $ScrollContainer/VBoxContainer/Label7,
		"interpretacao": $ScrollContainer/VBoxContainer/Label8,
		"escrita_correta": $ScrollContainer/VBoxContainer/Label9,
		"generos": $ScrollContainer/VBoxContainer/Label10,
		"maiuscula_minus": $ScrollContainer/VBoxContainer/Label11,
		"pontuacao": $ScrollContainer/VBoxContainer/Label12,
		"acentos": $ScrollContainer/VBoxContainer/Label13,
		"singular_plural": $ScrollContainer/VBoxContainer/Label14,
		"genero_gramatical": $ScrollContainer/VBoxContainer/Label15,
		"verbos": $ScrollContainer/VBoxContainer/Label16,
		"substantivos": $ScrollContainer/VBoxContainer/Label17,
		"analise_ling": $ScrollContainer/VBoxContainer/Label18
	}
	
	var erros_portugues = 0
	
	for subject in subjects_ui.keys():
		var label_node = subjects_ui[subject]
		var mistake_count = mistakes.get(subject, 0)
		
		if mistake_count > 0:
			label_node.show()
			label_node.bbcode_text += " [color=red](Erros: " + str(mistake_count) + ")[/color]"
			
			# Se a matéria atual for de Português, soma na contagem específica
			if subject in portuguese_subjects:
				erros_portugues += mistake_count
		else:
			botao_reforco.hide()
			label_node.hide()
			tet.hide()

	if erros_portugues == 0:
		label_portugues.hide()
	else:
		label_portugues.show()

	_exportar_relatorio_erros()

func _exportar_relatorio_erros():
	var player_name = PlayerVars.player_data.get("player_name", "Aluno")
	var file_name = "Relatorio_Erros_" + str(player_name) + ".txt"
	
	var content = "========================================\n"
	content += "RELATÓRIO DE ERROS DO ALUNO: " + str(player_name) + "\n"
	content += "Pontos Totais: " + str(Save.points) + "\n"
	content += "========================================\n\n"
	content += "Detalhamento de Erros por Matéria:\n"
	
	var total_erros = 0
	for subject in Save.mistakes.keys():
		var count = Save.mistakes[subject]
		if count > 0:
			content += "- " + str(subject) + ": " + str(count) + " erro(s)\n"
			total_erros += count
			
	if total_erros == 0:
		content += "Nenhum erro registrado!\n"
		
	content += "\n========================================\n"

	# 1. Salva localmente (user://)
	_gravar_arquivo("user://" + file_name, content)

	# 2. Salva no Pendrive (se conectado)
	var pendrive_paths = _encontrar_pendrives()
	for p_path in pendrive_paths:
		var target_dir = p_path + "/Relatorios_Alunos"
		var dir = Directory.new()
		
		if not dir.dir_exists(target_dir):
			dir.make_dir_recursive(target_dir)
			
		_gravar_arquivo(target_dir + "/" + file_name, content)


func _gravar_arquivo(path: String, text: String):
	var file = File.new()
	if file.open(path, File.WRITE) == OK:
		file.store_string(text)
		file.close()


func _encontrar_pendrives() -> Array:
	var drives = []
	var os_name = OS.get_name()
	
	if os_name == "Windows":
		var dir = Directory.new()
		var letras = ["D", "E", "F", "G", "H", "I", "J", "K", "L"]
		for letra in letras:
			var drive_path = letra + ":/"
			if dir.open(drive_path) == OK:
				drives.append(drive_path)
				
	elif os_name == "X11" or os_name == "Server": # Linux
		var paths_to_check = ["/media/" + OS.get_environment("USER"), "/run/media/" + OS.get_environment("USER")]
		var dir = Directory.new()
		for base_path in paths_to_check:
			if dir.open(base_path) == OK:
				dir.list_dir_begin(true)
				var folder_name = dir.get_next()
				while folder_name != "":
					if dir.current_is_dir():
						drives.append(base_path + "/" + folder_name)
					folder_name = dir.get_next()
				dir.list_dir_end()
				
	return drives


func _on_Button_pressed():
	get_tree().change_scene("res://account/account_main_scene.tscn")


func _on_Button2_pressed():
	var reinforcement_lecture = {}
	
	for subject in Save.mistakes.keys():
		var count = Save.mistakes[subject]
		if count > 0:
			reinforcement_lecture[subject] = count

	if not reinforcement_lecture.empty():
		Lan.current_lecture = reinforcement_lecture
		Save.lectures = reinforcement_lecture
		Save.mistakes.clear()
		get_tree().change_scene("res://lan/lecture_manager.tscn")
