extends Control

func _on_Button_pressed():
	var entered_name = $LineEdit.text
	if entered_name != "":
		
		PlayerVars.player_data["player_name"] = entered_name

		PlayerVars.save_game_data()

		get_tree().change_scene("res://account/account_main_scene.tscn")
