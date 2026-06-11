extends Control

func _ready():
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("startup")
