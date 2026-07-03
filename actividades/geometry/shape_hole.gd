extends Area2D
class_name hole

export var type: String
export var texture: Texture

var points = 0

signal points(points)
signal task_completed

func _ready():
	var sprite = Sprite.new()
	sprite.texture = texture
	add_child(sprite)

	var collision = CollisionShape2D.new()
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = 175
	collision.shape = circle_shape
	add_child(collision)

	connect("area_entered", self, "on_collision")

func on_collision(area: Area2D):
	$"%spawner".check_remaining()
	if area.is_in_group(type):
		area.queue_free()
		points += 1
		emit_signal("points", points)
		var right = preload("res://right.tscn")
		$"%Control".get_points(int(rand_range(100, 150)))
		var right_instance = right.instance()
		add_child(right_instance)
		
	else:
		print("wrong")
		var wrong = preload("res://wrong.tscn")
		$"%Control".get_points(int(rand_range(-75, -50)))
		var wrong_instance = wrong.instance()
		wrong_instance.current_exercise = "spacial_notion"
		add_child(wrong_instance)
