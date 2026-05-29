extends Control

func _ready():
	$Sprite/AnimationPlayer.play("play")
	yield(get_tree().create_timer(1), "timeout")
	self.queue_free()
