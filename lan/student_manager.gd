extends Control

onready var ip_input = $Node/LineEdit

func _ready():
	# 1. Escuta quando a aula foi recebida para carregar a cena de tarefas
	Lan.connect("lecture_received", self, "_start_lecture")
	
	# 2. Escuta a confirmação real da rede WebSocket dizendo: "Você está conectado!"
	get_tree().connect("connected_to_server", self, "_on_network_connected")
	if OS.get_name() == "HTML5":
		$Auto.hide()

func _start_lecture():
	# O Aluno muda para a cena onde vai resolver as tarefas dele
	get_tree().change_scene("res://lan/lecture_manager.tscn")

func _on_network_connected():
	print("WebSocket conectado com sucesso! Enviando dados do Aluno...")
	
	# Pega os dados salvos localmente
	var dados_salvos = PlayerVars.player_data
	
	# Dispara via RPC para a ponte do Lan no Host (ID 1)
	Lan.rpc_id(1, "_repassar_ao_professor", dados_salvos["player_name"], dados_salvos["teacher"])

func _on_Button_pressed():
	var ip = ip_input.text.strip_edges()
	if ip == "":
		ip = "127.0.0.1"
	Lan.join_classroom(ip)

func _input(event):
	if event.is_action_pressed("enter"):
		$Node/Button.emit_signal("pressed")

func _on_Auto_pressed():
	var target_ip = Lan.get_classroom_ip()
	
	# Valida se o IP retornado é válido antes de tentar conectar
	if target_ip == "Run on Desktop to Host" or target_ip == "No LAN Connection":
		print("Não foi possível detectar o IP automaticamente.")
		return
		
	Lan.join_classroom(target_ip)

func _on_X_pressed():
	get_tree().change_scene("res://account/account_main_scene.tscn")
