extends Control

# Referências aos nós
onready var panel = $Panel
onready var tween = $Panel/Tween

# Variáveis de controle do painel
var painel_aberto = false
export var posicao_fechado = Vector2(-400, 50) # Ajuste conforme o seu layout
export var posicao_aberto = Vector2(100, 50)
export var duracao_animacao = 0.5

# Variáveis do sistema de desenho avançado
var desenhando = false
var modo_apagar = false
var linha_atual : Line2D = null

# Configurações do traço
export var cor_linha = Color.black
export var largura_linha = 5.0

func _ready():
	$Panel.rect_position = posicao_fechado

# --- CONTROLE DO PAINEL (SLIDE) ---

func _on_Button_pressed():
	tween.stop_all()
	var posicao_destino = posicao_aberto if not painel_aberto else posicao_fechado
	
	tween.interpolate_property(
		panel, "rect_position", panel.rect_position, 
		posicao_destino, duracao_animacao, Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	tween.start()
	painel_aberto = not painel_aberto

func _on_BotaoBorracha_pressed():
	modo_apagar = not modo_apagar
	if modo_apagar:
		$Panel/BotaoBorracha.text = "Modo: Borracha"
	else:
		$Panel/BotaoBorracha.text = "Modo: Desenhar"

func _input(event):
	if not painel_aberto:
		return
		
	# Verifica se o clique aconteceu dentro dos limites do painel
	var mouse_na_janela = panel.get_rect().has_point(panel.get_global_mouse_position())

	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed and mouse_na_janela:
			desenvendo_linha(event.position)
		else:
			# Soltou o clique, para de desenhar
			desenhando = false
			linha_atual = null

	elif event is InputEventMouseMotion and desenhando:
		if mouse_na_janela:
			if modo_apagar:
				apagar_linhas_sob_o_mouse()
			elif linha_atual:
				linha_atual.add_point(panel.get_local_mouse_position())

func desenvendo_linha(posicao_clique):
	desenhando = true
	
	if modo_apagar:
		apagar_linhas_sob_o_mouse()
	else:
		# Cria um novo nó Line2D para cada novo traço
		linha_atual = Line2D.new()
		linha_atual.width = largura_linha
		linha_atual.default_color = cor_linha
		linha_atual.joint_mode = Line2D.LINE_JOINT_ROUND
		linha_atual.begin_cap_mode = Line2D.LINE_CAP_ROUND
		linha_atual.end_cap_mode = Line2D.LINE_CAP_ROUND
		
		# Adiciona a linha como filha do painel para que ela se mova junto com ele
		panel.add_child(linha_atual)
		linha_atual.add_point(panel.get_local_mouse_position())

func apagar_linhas_sob_o_mouse():
	var mouse_pos = panel.get_local_mouse_position()
	
	# Percorre todas as linhas desenhadas dentro do painel
	for child in panel.get_children():
		if child is Line2D:
			# Se o mouse passar perto de qualquer ponto da linha, apaga a linha inteira
			for ponto in child.points:
				if mouse_pos.distance_to(ponto) < 15.0: # 15.0 é a sensibilidade da borracha
					child.queue_free()
					break
