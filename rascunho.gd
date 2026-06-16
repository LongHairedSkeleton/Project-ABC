extends Panel

# --- Configurações do Painel (Slide) ---
var painel_aberto = false

# Armazenamos a coordenada Y original do painel para não alterá-la na animação
onready var y_original = rect_position.y

# Agora usamos Vector2 para as posições de fechado e aberto
# Ajuste o 'posicao_aberto' para onde você quer que o painel apareça na tela!
onready var posicao_fechado = Vector2(OS.window_size.x + rect_size.x, y_original) 
onready var posicao_aberto = Vector2(OS.window_size.x, y_original) # Desliza para dentro da tela

var duracao_animacao = 0.4
onready var tween = Tween.new()

# --- Sua Lógica de Desenho Adaptada ---
var lines = [] 
var drawing = false
var erasing = false

const MAX_POINTS = 5000
const ERASE_RADIUS = 40.0 

func _ready():
	add_child(tween)
	# Inicializa o painel na posição fechada (escondido na direita)
	rect_position = posicao_fechado

# Esta função será chamada pelo botão de fora para abrir/fechar
func alternar_painel():
	tween.stop_all()
	
	# Define o Vector2 de destino correto
	var posicao_destino = posicao_aberto if not painel_aberto else posicao_fechado
	
	# Agora interpolamos a propriedade "rect_position" inteira usando Vector2
	tween.interpolate_property(
		self, "rect_position", rect_position, 
		posicao_destino, duracao_animacao, Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	tween.start()
	painel_aberto = not painel_aberto

func _input(event):
	# Só desenha se o painel estiver aberto
	if not painel_aberto:
		return
		
	var mouse_pos = get_local_mouse_position()
	
	# Usamos get_global_rect() para garantir a checagem correta com a posição global do mouse
	var mouse_no_painel = get_global_rect().has_point(get_global_mouse_position())

	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			drawing = event.pressed and mouse_no_painel
			if drawing and get_total_points() < MAX_POINTS:
				lines.append([mouse_pos])
				update()
		
		elif event.button_index == BUTTON_RIGHT:
			erasing = event.pressed and mouse_no_painel
			if erasing:
				erase_at_position(mouse_pos)
				update()

	elif event is InputEventMouseMotion:
		if drawing and get_total_points() < MAX_POINTS:
			if mouse_no_painel:
				lines[-1].append(mouse_pos)
				update()
		elif erasing:
			if mouse_no_painel:
				erase_at_position(mouse_pos)
			else:
				erasing = false 
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
				if current_segment.size() > 1:
					new_lines_list.append(current_segment)
				current_segment = [] 
				changed = true
		
		if current_segment.size() > 1:
			new_lines_list.append(current_segment)
	
	if changed:
		lines = new_lines_list

func get_total_points():
	var count = 0
	for line in lines:
		count += line.size()
	return count

func _draw():
	var line_color = Color(0, 0.9, 1)
	var line_width = 10
	
	for line in lines:
		if line.size() > 1:
			draw_polyline(PoolVector2Array(line), line_color, line_width, false)
	
	if erasing:
		draw_arc(get_local_mouse_position(), ERASE_RADIUS, 0, TAU, 24, Color(0, 0.9, 1), 1.5, false)

# Se o botão estiver dentro do painel, esta função funciona direto ao conectar o sinal pressed()
func _on_Button_pressed():
	alternar_painel()
