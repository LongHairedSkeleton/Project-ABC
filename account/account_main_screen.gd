extends Control

func _ready():
	match PlayerVars.player_data["teacher"]:
		true:
			$Button.text = "+ clique aqui\n pra criar\n uma sala"
		false:
			$Button.text = "clique aqui\n para entrar\n numa sala"

func _on_TextureButton_pressed():
	get_tree().change_scene("res://account/settings.tscn")

func _on_Button_pressed():
	get_tree().change_scene("res://lan/question_selection.tscn")

	match PlayerVars.player_data["teacher"]:
		true:
			get_tree().change_scene("res://lan/question_selection.tscn")
		false:
			get_tree().change_scene("res://lan/puppet_screen.tscn")
