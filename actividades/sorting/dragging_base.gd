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
		var parent = get_parent()
		
		var parent_is_ready_to_drag = true
		if "is_any_item_dragging" in parent:
			if parent.is_any_item_dragging:
				parent_is_ready_to_drag = false

		if event.pressed and parent_is_ready_to_drag:
			is_dragging = true
			
			if "is_any_item_dragging" in parent:
				parent.is_any_item_dragging = true
				
			grab_offset = global_position - get_global_mouse_position()
			get_tree().set_input_as_handled()

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if not event.pressed and is_dragging:
			is_dragging = false
			
			var parent = get_parent()
			if "is_any_item_dragging" in parent:
				parent.is_any_item_dragging = false 
				
			get_tree().set_input_as_handled()
func _process(delta):
	if is_dragging:
		global_position = get_global_mouse_position() + grab_offset
