extends Button

var lines = [] # Cada item é um array de pontos: [[p1, p2], [p3, p4]]
var drawing = false
var erasing = false

const MAX_POINTS = 5000
const ERASE_RADIUS = 40.0 # Aumentei um pouco para facilitar

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
			lines[-1].append(event.position)
			update()
		elif erasing:
			erase_at_position(event.position)
			update()

func erase_at_position(pos):
	var new_lines_list = []
	var changed = false

	for line in lines:
		var current_segment = []
		for p in line:
			if pos.distance_to(p) > ERASE_RADIUS:
				current_segment.append(p)
			else:
				# Ponto apagado! Se tínhamos algo acumulado, vira uma linha separada
				if current_segment.size() > 1:
					new_lines_list.append(current_segment)
				current_segment = [] # Reseta para começar uma nova linha após o "buraco"
				changed = true
		
		# Adiciona o que sobrou da linha original
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
	var line_color = Color(0.10, 0.10, 0.5)
	var line_width = 10
	
	for line in lines:
		if line.size() > 1:
			# O quarto parâmetro controla o anti-aliasing (true = ligado, false = desligado)
			draw_polyline(PoolVector2Array(line), line_color, line_width, false)
	
	if erasing:
		# Também desativado aqui para o círculo da borracha
		draw_arc(get_local_mouse_position(), ERASE_RADIUS, 0, TAU, 24, Color.pink, 1.5, false)

func _process(delta):
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene("res://Game.tscn")
