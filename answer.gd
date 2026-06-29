extends Control

var current_exercise = "Unknown"

func _ready():
	# If a valid subject was passed, log the mistake globally
	if current_exercise != "Unknown":
		if not Save.has_method("mistakes"): 
			# Safely inject/initialize the dictionary if it doesn't exist in Save yet
			if not "mistakes" in Save:
				Save.set("mistakes", {})
				
		var mistakes_dict = Save.get("mistakes")
		if not current_exercise in mistakes_dict:
			mistakes_dict[current_exercise] = 1
		else:
			mistakes_dict[current_exercise] += 1
			
		print("Mistake logged for: ", current_exercise, " | Total: ", mistakes_dict[current_exercise])
	
	$Sprite/AnimationPlayer.play("play")
	yield(get_tree().create_timer(1), "timeout")
	self.queue_free()
