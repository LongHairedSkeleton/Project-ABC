extends Control

func check(name):
	var entered_name = name
	if entered_name != "":
		
		PlayerVars.player_data["player_name"] = entered_name

		PlayerVars.save_game_data()

		get_tree().change_scene("res://account/account_main_scene.tscn")

func get_name():
	if OS.has_environment("USERNAME"):
		return OS.get_environment("USERNAME")
	elif OS.has_environment("USER"):
		return OS.get_environment("USER")
	else:
		return "0"
		$Button2.hide()

func _ready():
	if OS.has_feature("HTML5"):
		$Button2.hide()
	else:
		$Button2.text = "  sugestão: " + get_name() + "  "
		$Button2.show()

func _on_Button_pressed():
	check($LineEdit.text)

func _on_Button2_pressed():
	check(get_name())
