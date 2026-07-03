extends Control

var current_exercise = "Unknown"

func _ready():
	# Força o tratamento do texto para bater com o dicionário do results.gd
	if current_exercise != "Unknown":
		# Garante que o dicionário existe no Save
		if not "mistakes" in Save or Save.mistakes == null:
			Save.mistakes = {}
		
		# Registra o erro diretamente no escopo global
		if not current_exercise in Save.mistakes:
			Save.mistakes[current_exercise] = 1
		else:
			Save.mistakes[current_exercise] += 1
			
		print("Erro global registrado para: ", current_exercise, " -> Total: ", Save.mistakes[current_exercise])
	
	$Sprite/AnimationPlayer.play("play")
	yield(get_tree().create_timer(1), "timeout")
	self.queue_free()
