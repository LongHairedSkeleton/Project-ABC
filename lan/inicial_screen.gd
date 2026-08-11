extends Control

var RESOLUTIONS = [Vector2(1300, 720)]

func _ready():
	Inputs.cycle_resolution(-1)
	#Inputs.cycle_resolution(1)

	var target_res = RESOLUTIONS[current_res_index]
	var calculated_shrink = BASE_DESIGN_SIZE.y / target_res.y

	if OS.window_fullscreen:
		get_tree().set_screen_stretch(
			SceneTree.STRETCH_MODE_2D, 
			SceneTree.STRETCH_ASPECT_KEEP_HEIGHT, 
			BASE_DESIGN_SIZE, 
			calculated_shrink
		)
	else:
		OS.window_size = target_res
		get_tree().root.set_size(target_res)
		
		get_tree().set_screen_stretch(
			SceneTree.STRETCH_MODE_2D, 
			SceneTree.STRETCH_ASPECT_KEEP_HEIGHT, 
			BASE_DESIGN_SIZE, 
			1.0 
		)
		
		var screen_size = OS.get_screen_size()
		OS.window_position = (screen_size - OS.window_size) / 2


	check_if_account_exists()
	$Buttonns.set_anchors_and_margins_preset(Control.PRESET_WIDE)
	$RichTextLabel.set_anchors_and_margins_preset(Control.PRESET_WIDE)
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("startup")

func check_if_account_exists():
	if PlayerVars.player_data["first_time"] == false:
		get_tree().change_scene("res://account/account_main_scene.tscn")

func _on_Button_pressed():
	#get_tree().change_scene("res://lan/question_selection.tscn")
	get_tree().change_scene("res://account/name.tscn")
	PlayerVars.player_data["teacher"] = true
	PlayerVars.save_game_data()

func _on_Button2_pressed():
	#get_tree().change_scene("res://lan/puppet_screen.tscn")
	get_tree().change_scene("res://account/name.tscn")
	PlayerVars.player_data["teacher"] = false
	PlayerVars.save_game_data()

var current_res_index = 0
const BASE_DESIGN_SIZE = Vector2(900, 1440)

