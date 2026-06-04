extends Control

var text = "abcdefghijklmnopqrstuvwxyz"
# REMOVED: var texto_baguncado = "" (No longer needed globally)

func baguncar_string(texto : String) -> String:
	var caracteres = []
	var resultado_baguncado = "" # Created locally here
	
	for i in range(texto.length()):
		caracteres.append(texto[i])
		
	randomize()
	caracteres.shuffle()
	
	for letra in caracteres:
		resultado_baguncado += letra
		
	return resultado_baguncado # Returns the fresh, isolated string

func _ready():
	yield(get_tree().create_timer(3), "timeout")
	falar()

func falar():
	start_jump()
	var texto_para_falar = baguncar_string(text) 
	var speed = 0.6
	
	$AnimatedSprite.play("default")
	
	# Start speaking
	$TextToSpeech.say(texto_para_falar, TextToSpeechEngine.VOICE_AWB, speed)
	
	# Estimate duration: ~26 characters at 0.6 speed takes roughly 2.5 to 3 seconds.
	# We create a safe fallback timer so the animation is forced to stop.
	yield(get_tree().create_timer(2.5), "timeout")
	
	$AnimatedSprite.frame = 0
	$AnimatedSprite.stop()

onready var tween = $Tween
var jump_height = 20
var jump_duration = 0.3

func start_jump():
	var start_y = $AnimatedSprite.position.y
	var peak_y = start_y - jump_height
	tween.remove_all()
	# Move UP (Decelerate)
	tween.interpolate_property($AnimatedSprite, "position:y", start_y, peak_y, jump_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
	# Move DOWN (Accelerate, with delay)
	tween.interpolate_property($AnimatedSprite, "position:y", peak_y, start_y, jump_duration, Tween.TRANS_SINE, Tween.EASE_IN, jump_duration)
	tween.start()

func _on_Button_pressed():
	falar()
