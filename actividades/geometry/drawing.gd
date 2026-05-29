extends Control

var lines = [] # Cada item é um array de pontos: [[p1, p2], [p3, p4]]
var drawing = false
var erasing = false

func _ready():
	randomize()
	var shapes = "res://shapes_and_numbers/shapes/"
	load_items_from_folder(shapes)
	roll()

func roll():
	# 1. FIXED: Clear player's previous drawings and reset matching sequence
	lines = []
	next_point_index = 0
	update() 

	# Clear old instanced nodes
	for child in get_children():
		# FIXED: Checked for generic Node2D or Line2D types to avoid cluttering 
		if child is Node2D: 
			child.queue_free()

	var chosen_shape = possible_items[randi() % possible_items.size()]
	var instance = chosen_shape.instance()
	add_child(instance)
	
	# 2. FIXED: Find the Line2D inside the freshly instanced sub-scene safely
	var found_line = find_line2d_in_node(instance)
	if found_line:
		guide_points = found_line.points
		print("New guide loaded with ", guide_points.size(), " points.")
	else:
		print("Warning: No Line2D found inside the instanced scene!")

# FIXED: Helper function to search for Line2D even if it's nested or the root node
func find_line2d_in_node(node: Node) -> Line2D:
	if node is Line2D:
		return node as Line2D
	for child in node.get_children():
		if child is Line2D:
			return child
	return null

var possible_items = []

func load_items_from_folder(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(".tscn"):
				var full_path = path + file_name
				var item = load(full_path)
				possible_items.append(item)
				print("Loaded item: ", file_name)
			
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")

const MAX_POINTS = 5000
const ERASE_RADIUS = 50.0 

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			drawing = event.pressed
			if drawing and get_total_points() < MAX_POINTS:
				lines.append([event.position])
		
		elif event.button_index == BUTTON_RIGHT:
			erasing = event.pressed
			if erasing:
				erase_at_position(event.position)

	elif event is InputEventMouseMotion:
		if drawing and get_total_points() < MAX_POINTS:
			var current_pos = event.position
			lines[-1].append(current_pos)
			
			if next_point_index < guide_points.size():
				var target = guide_points[next_point_index]
				if current_pos.distance_to(target) < MATCH_DISTANCE:
					next_point_index += 1
					print("Atingiu ponto: ", next_point_index)
			
			update()
			
		elif erasing:
			erase_at_position(event.position)
			update()
			
	if event is InputEventKey and event.pressed and event.scancode == KEY_G:
		if lines.size() > 0:
			guide_points = lines[-1]
			next_point_index = 0
			print("Novo guia definido com ", guide_points.size(), " pontos!")

	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ENTER or event.scancode == KEY_KP_ENTER:
			var precisao = calcular_precisao()
			var porcentagem = precisao * 100
			
			if precisao > 0.8:
				var right = preload("res://right.tscn")
				var right_instance = right.instance()
				add_child(right_instance)
			else:
				var wrong = preload("res://wrong.tscn")
				var wrong_instance = wrong.instance()
				add_child(wrong_instance)
			roll()

func erase_at_position(pos):
	var new_lines_list = []
	var changed = false

	for line in lines:
		var current_segment = []
		for p in line:
			if pos.distance_to(p) > ERASE_RADIUS:
				current_segment.append(p)
			else:
				if current_segment.size() > 1:
					new_lines_list.append(current_segment)
				current_segment = [] 
				changed = true
		
		if current_segment.size() > 1:
			new_lines_list.append(current_segment)
	
	if changed:
		lines = new_lines_list
		update()

func get_total_points():
	var count = 0
	for line in lines:
		count += line.size()
	return count

func _draw():
	if guide_points.size() > 1:
		draw_polyline(guide_points, Color(1, 1, 1, 0.3), 5.0, true)
	
	var line_color = Color(0.1, 0.5, 1.56)
	var line_width = 20
	
	for line in lines:
		if line.size() > 1:
			draw_polyline(PoolVector2Array(line), line_color, line_width, false)
	
	if erasing:
		draw_arc(get_local_mouse_position(), ERASE_RADIUS, 0, TAU, 24, Color.yellow, 1.5, false)

const MATCH_THRESHOLD = 30.0 
var guide_points = [Vector2(100, 100), Vector2(200, 100), Vector2(300, 200)] 
var next_point_index = 0 
const MATCH_DISTANCE = 40.0 

func check_match() -> float:
	var hits = 0
	for target in guide_points:
		var found = false
		for line in lines:
			for p in line:
				if p.distance_to(target) < MATCH_THRESHOLD:
					hits += 1
					found = true
					break 
			if found: break
	return float(hits) / float(guide_points.size())

func calcular_precisao() -> float:
	if guide_points.size() == 0:
		print("Erro: Nenhum guia definido!")
		return 0.0
	
	var pontos_atingidos = 0
	for target in guide_points:
		var atingiu_ponto = false
		for line in lines:
			for p in line:
				if p.distance_to(target) < 30.0: 
					atingiu_ponto = true
					break
			if atingiu_ponto: break
		
		if atingiu_ponto:
			pontos_atingidos += 1
			
	return float(pontos_atingidos) / float(guide_points.size())
