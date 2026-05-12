extends Node2D

var lines = [] # Cada item é um array de pontos: [[p1, p2], [p3, p4]]
var drawing = false
var erasing = false

const MAX_POINTS = 5000
const ERASE_RADIUS = 50.0 # Aumentei um pouco para facilitar

onready var path_node = $Path2D # Nome do seu nó Path2D

func _ready():
	# Pega os pontos da curva desenhada no editor e guarda no guia
	if has_node("Path2D"):
		guide_points = $Path2D.curve.get_baked_points()

func _input(event):
	# 1. Primeiro verificamos cliques (para saber se começou/parou de desenhar)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			drawing = event.pressed
			if drawing and get_total_points() < MAX_POINTS:
				lines.append([event.position])
				# Opcional: Resetar progresso ao começar novo traço
				# next_point_index = 0 
		
		elif event.button_index == BUTTON_RIGHT:
			erasing = event.pressed
			if erasing:
				erase_at_position(event.position)

	# 2. Depois verificamos movimento (para adicionar pontos e checar a sequência)
	elif event is InputEventMouseMotion:
		if drawing and get_total_points() < MAX_POINTS:
			var current_pos = event.position
			lines[-1].append(current_pos)
			
			# Lógica da sequência (o que causava o erro se estivesse no lugar errado)
			if next_point_index < guide_points.size():
				var target = guide_points[next_point_index]
				if current_pos.distance_to(target) < MATCH_DISTANCE:
					next_point_index += 1
					print("Atingiu ponto: ", next_point_index)
			
			update()
			
		elif erasing:
			erase_at_position(event.position)
			update()
	 # Se apertar a tecla "G", transforma o último desenho feito em guia
	if event is InputEventKey and event.pressed and event.scancode == KEY_G:
		if lines.size() > 0:
			guide_points = lines[-1]
			next_point_index = 0
			print("Novo guia definido com ", guide_points.size(), " pontos!")

	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ENTER or event.scancode == KEY_KP_ENTER:
			var precisao = calcular_precisao()
			var porcentagem = precisao * 100
			
			if precisao > 0.8: # Se acertou mais de 80%
				print("Muito bem! Precisão: ", stepify(porcentagem, 0.1), "%")
			else:
				print("Tente novamente. Precisão: ", stepify(porcentagem, 0.1), "%")

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
	# Desenha o guia pontilhado ou transparente
	if guide_points.size() > 1:
		draw_polyline(guide_points, Color(1, 1, 1, 0.3), 5.0, true)
	
	var line_color = Color(0.1, 0.5, 1.56)
	var line_width = 20
	
	for line in lines:
		if line.size() > 1:
			# O quarto parâmetro controla o anti-aliasing (true = ligado, false = desligado)
			draw_polyline(PoolVector2Array(line), line_color, line_width, false)
	
	if erasing:
		# Também desativado aqui para o círculo da borracha
		draw_arc(get_local_mouse_position(), ERASE_RADIUS, 0, TAU, 24, Color.yellow, 1.5, false)

const MATCH_THRESHOLD = 30.0 # Quão perto o jogador deve estar do ponto
var guide_points = [Vector2(100, 100), Vector2(200, 100), Vector2(300, 200)] # Seu gabarito
var next_point_index = 0 # Qual ponto o jogador deve atingir agora
const MATCH_DISTANCE = 40.0 # Tolerância de erro em pixels

func check_match() -> float:
	var hits = 0
	
	for target in guide_points:
		var found = false
		for line in lines:
			for p in line:
				if p.distance_to(target) < MATCH_THRESHOLD:
					hits += 1
					found = true
					break # Já encontrou este ponto do guia, pula para o próximo
			if found: break
			
	# Retorna a porcentagem de acerto (0.0 a 1.0)
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
				if p.distance_to(target) < 30.0: # 30 pixels de tolerância
					atingiu_ponto = true
					break
			if atingiu_ponto: break
		
		if atingiu_ponto:
			pontos_atingidos += 1
			
	return float(pontos_atingidos) / float(guide_points.size())
