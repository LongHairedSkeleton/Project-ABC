extends Node

var amount_of_vertices
var amount_of_sides
var amount_of_faces

var label_value = 0

var target_value = 0

func _ready():
	randomize()
	var shapes = "res://shapes_and_numbers/shapes/"
	load_items_from_folder(shapes)
	roll()

var possible_items = []

func load_items_from_folder(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			# Only load files ending in .tres and ignore folders/import files
			if !dir.current_is_dir() and file_name.ends_with(".tscn"):
				var full_path = path + file_name
				var item = load(full_path)
				possible_items.append(item)
				print("Loaded item: ", file_name)
			
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")

func roll():
	print("rolled")
	for child in get_children():
		if child is Line2D:
			child.queue_free()

	var chosen_shape = possible_items[randi() % possible_items.size()]
	var instance = chosen_shape.instance()
	add_child(instance)

	var rand_type = ["amount_of_sides", "amount_of_vertices", "amount_of_faces", "amount_of_angles"].pick_random()
	$"../RichTextLabel".text = str(rand_type)

	if rand_type == "amount_of_vertices" or rand_type == "amount_of_sides" or rand_type == "amount_of_angles":
		# FIX: Read directly from the new instance variable, not the scene tree shortcut
		if instance is Line2D:
			target_value = instance.get_point_count() - 1
		else:
			# If the Line2D is a child INSIDE your instanced scene, find it like this:
			target_value = instance.get_node("Line2D").get_point_count()
			
	if rand_type == "amount_of_faces":
		target_value = 1

func _on_Button_pressed():
	update_label(1)

func _on_Button2_pressed():
	update_label(-1)

func update_label(amount):
	label_value += amount
	$RichTextLabel.text = str(label_value)

func check_if_right():
	if target_value == label_value:
		print("win")
	else:
		print("lose")
		print("it was" + str(target_value))
	roll()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ENTER or event.scancode == KEY_KP_ENTER:
			check_if_right()

func _on_Button3_pressed():
	check_if_right()
