extends Node

const RESOLUTIONS = [
	Vector2(225, 360),
	Vector2(450, 720),
	Vector2(900, 1440)
]

var current_res_index = 2 
const BASE_DESIGN_SIZE = Vector2(900, 1440)

func _input(event):
	if event.is_action_pressed("esq"):
		get_tree().quit()

	if event.is_action_pressed("resolution+"):
		cycle_resolution(1)

	if event.is_action_pressed("resolution-"):
		cycle_resolution(-1)
		
	# FIXED FULLSCREEN INPUT LOOKUP
	if event.is_action_pressed("f11"):
		OS.window_fullscreen = not OS.window_fullscreen
		# Force the engine to rebuild the stretch profile instantly to prevent zoom glitches
		apply_stretch_settings()

func cycle_resolution(neorpos):
	current_res_index = (current_res_index + neorpos) % RESOLUTIONS.size()
	if current_res_index < 0:
		current_res_index += RESOLUTIONS.size()
	
	apply_stretch_settings()

# Extracted rendering adjustments to keep everything perfectly synced
func apply_stretch_settings():
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
