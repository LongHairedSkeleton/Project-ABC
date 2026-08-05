extends Control

func _ready():
	PlayerVars.player_data["max_points"] = Save.points
	PlayerVars.save_game_data()
	
	$ScrollContainer/VBoxContainer/RichTextLabel2.bbcode_text = "[wave][center]" + str(PlayerVars.player_data["player_name"]) + " ganhou " + "[rainbow]" + str(Save.points) + " pontos"

	# Puxamos as lições diretamente do histórico da rede caso o Save falhe
	var lectures = Lan.current_lecture if not Lan.current_lecture.empty() else Save.lectures
	var mistakes = Save.mistakes if "mistakes" in Save and Save.mistakes != null else {}
	
	var subjects_ui = {
		"Addition and subtraction": $ScrollContainer/VBoxContainer/RichTextLabel3,
		"Times and division": $ScrollContainer/VBoxContainer/RichTextLabel5,
		"conversion": $ScrollContainer/VBoxContainer/RichTextLabel8,
		"problems": $ScrollContainer/VBoxContainer/RichTextLabel7,
		"times": $ScrollContainer/VBoxContainer/RichTextLabel6,
		"division_in_equal_parts":$ScrollContainer/VBoxContainer/RichTextLabel4,
		"drawing":$ScrollContainer/VBoxContainer/RichTextLabel10,
		"spacial_geometry":$ScrollContainer/VBoxContainer/RichTextLabel9,
		"spacial_notion":$ScrollContainer/VBoxContainer/RichTextLabel11,
		
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
	
	for subject in subjects_ui.keys():
		var label_node = subjects_ui[subject]
		var task_count = lectures.get(subject, 0)
		
		if task_count > 0:
			label_node.show()
			var mistake_count = mistakes.get(subject, 0)
			label_node.bbcode_text += " [color=red](Erros: " + str(mistake_count) + ")[/color]"
		else:
			label_node.hide()

func _on_Button_pressed():
	get_tree().change_scene("res://account/account_main_scene.tscn")


func _on_Button2_pressed():
	var reinforcement_lecture = {}
	
	# Percorre todos os erros registrados pelo aluno
	for subject in Save.mistakes.keys():
		var count = Save.mistakes[subject]
		# Se houver pelo menos 1 erro na matéria, adicionamos ao reforço
		if count > 0:
			# Define quantas questões de reforço serão geradas (ex: a mesma quantidade de erros)
			reinforcement_lecture[subject] = count

	# Caso o aluno tenha cometido erros, iniciamos a aula de reforço
	if not reinforcement_lecture.empty():
		# Atualiza as lições no Singleton da rede e no Save
		Lan.current_lecture = reinforcement_lecture
		Save.lectures = reinforcement_lecture
		
		# Limpa os erros antigos para a nova rodada
		Save.mistakes.clear()
		
		# Troca para a cena do gerenciador de lições para começar o treino
		get_tree().change_scene("res://lan/lecture_manager.tscn")
