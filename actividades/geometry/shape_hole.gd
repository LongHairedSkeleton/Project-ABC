extends Area2D
class_name hole

export var type: String
export var texture: Texture

var points = 0

func _ready():
	var sprite = Sprite.new()
	sprite.texture = texture
	add_child(sprite)

	var collision = CollisionShape2D.new()
	collision.shape = CircleShape2D
	add_child(collision)

	connect("area_entered", self, "on_collision")

signal points(points)

func on_collision(area: Area2D):
	if area.is_in_group(self.group):
		area.queue_free()
		points += 1
		emit_signal("points", points)
	else:
		print("wrong")
