extends Control

func _ready():
	$ScrollContainer/VBoxContainer/RichTextLabel2.bbcode_text = "[wave][center]ALUNO ganhou " + "[rainbow]" + str(Save.points) + " pontos"

	
	var lectures = Save.lectures if typeof(Save.lectures) == TYPE_DICTIONARY else {}
	var mistakes = Save.get("mistakes") if "mistakes" in Save else {}
	
	# Dictionary linking subjects to their respective RichTextLabels
	var subjects_ui = {
		"Addition and subtraction": $ScrollContainer/VBoxContainer/RichTextLabel3,
		"Times and division": $ScrollContainer/VBoxContainer/RichTextLabel5,
		"conversion": $ScrollContainer/VBoxContainer/RichTextLabel8,
		"problems": $ScrollContainer/VBoxContainer/RichTextLabel7,
		"times": $ScrollContainer/VBoxContainer/RichTextLabel6
	}
	
	for subject in subjects_ui.keys():
		var label_node = subjects_ui[subject]
		var task_count = lectures.get(subject, 0)
		
		if task_count > 0:
			label_node.show()
			# Fetch mistakes for this subject, default to 0 if none made yet
			var mistake_count = mistakes.get(subject, 0)
			
			# Append the mistake text onto the existing label BBCode text
			label_node.bbcode_text += " [color=red](Erros: " + str(mistake_count) + ")[/color]"
		else:
			label_node.hide()
