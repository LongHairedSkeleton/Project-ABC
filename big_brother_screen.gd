extends VBoxContainer

onready var panel = preload("res://lan/aluno_panel.tscn")

# Dicionário do Professor para listar quem entrou na sala
var lista_alunos = {}

func _ready():
	# Registra o nó no grupo para que o script Lan consiga encontrá-lo dinamicamente
	add_to_group("vbox_professor")
	
	if get_tree().is_network_server():
		get_tree().connect("network_peer_disconnected", self, "_on_aluno_desconectou")

func _on_aluno_desconectou(peer_id):
	if peer_id in lista_alunos:
		print("Aluno ", lista_alunos[peer_id]["name"], " saiu da sala.")
		lista_alunos.erase(peer_id)
		atualizar_lista_visual()

# Esta função é acionada pela ponte do script Lan
func receive_puppet_data(player_name, is_teacher):
	var sender_id = get_tree().get_rpc_sender_id()
	
	lista_alunos[sender_id] = {
		"name": player_name,
		"teacher": is_teacher
	}
	
	print("Professor recebeu o aluno: ", player_name)
	atualizar_lista_visual()

onready var label = $RichTextLabel

func atualizar_lista_visual():
	# Limpa os painéis antigos para não duplicar na tela
	for child in get_children():
		child.queue_free()
		
	# Varre o dicionário criando um painel por aluno conectado
	for peer_id in lista_alunos:
		var dados = lista_alunos[peer_id]
		
		# Não exibe professores na lista de alunos
		if dados["teacher"] == true:
			continue
			
		var instance = panel.instance()
		add_child(instance)
		
		# Procura o nó de texto dentro do seu aluno_panel.tscn
		if instance.has_node("Label"):
			var node_texto = instance.get_node("Label")
			
			# Suporta tanto RichTextLabel quanto Label comum
			if node_texto is RichTextLabel:
				node_texto.bbcode_text = dados["name"]
			else:
				node_texto.text = dados["name"]
