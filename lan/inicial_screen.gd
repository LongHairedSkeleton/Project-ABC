extends Control

func _ready():
	check_if_account_exists()
	$Buttonns.set_anchors_and_margins_preset(Control.PRESET_WIDE)
	$RichTextLabel.set_anchors_and_margins_preset(Control.PRESET_WIDE)
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("startup")

func check_if_account_exists():
	if PlayerVars.player_data["first_time"] == false:
		get_tree().change_scene("res://account/account_main_scene.tscn")

onready var camera = $Camera2D
onready var tween = $Camera2D/Tween

func slide_to(place):
	var target_position = place
	# Pegamos a posição global e somamos metade do tamanho para centralizar
	var target_center = target_position.rect_global_position
	
	tween.interpolate_property(
		camera, 
		"global_position", # Usar global garante que não haja erro de hierarquia
		camera.global_position, 
		target_center, 
		1, 
		Tween.TRANS_SINE, 
		Tween.EASE_OUT
	)

	tween.start()

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
