extends Area2D
class_name drag_queen

export var texture: Texture

var is_dragging = false
var grab_offset = Vector2()

func _ready():
	randomize()
	position += Vector2(rand_range(-50, 50), rand_range(-50, 50))

	var sprite = Sprite.new()
	sprite.texture = texture
	add_child(sprite)

	var collision = CollisionShape2D.new()
	add_child(collision)
	collision.shape = CircleShape2D.new()
	collision.shape.radius = 25

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		# Get the parent Control node
		var parent = get_parent()
		
		# ONLY start dragging if the parent says no other item is dragging
		if event.pressed and not parent.is_any_item_dragging:
			is_dragging = true
			parent.is_any_item_dragging = true # Lock the parent
			grab_offset = global_position - get_global_mouse_position()
			get_tree().set_input_as_handled()

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if not event.pressed and is_dragging:
			is_dragging = false
			# Unlock the parent so other items can be picked up
			get_parent().is_any_item_dragging = false 

func _process(delta):
	if is_dragging:
		global_position = get_global_mouse_position() + grab_offset
