extends Node

const DEFAULT_PORT = 8910
var peer = null
var current_lecture = {}

signal lecture_received

func _ready():
	get_tree().connect("network_peer_connected", self, "_on_peer_connected")
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")

func _on_connected_to_server():
	print("Conexão WebSocket estabelecida com o Host!")

# No seu Lan Singleton

func host_classroom():
	peer = WebSocketServer.new()
	# O terceiro parâmetro 'true' ativa o modo de compatibilidade com Multiplex/HighLevel do Godot
	var error = peer.listen(DEFAULT_PORT, PoolStringArray(), true)
	if error != OK:
		print("Failed to host WebSocket server: ", error)
		return
	get_tree().network_peer = peer
	print("Classroom hosted via WebSockets on port ", DEFAULT_PORT)

# Certifique-se de que a palavra "remote" está escrita corretamente
remote func _repassar_ao_professor(player_name, is_teacher):
	var nodes = get_tree().get_nodes_in_group("vbox_professor")
	
	if nodes.size() > 0:
		var vbox = nodes[0] # IMPORTANTE: Pegamos o primeiro elemento do array retornado pelo grupo
		vbox.receive_puppet_data(player_name, is_teacher)
	else:
		print("Erro de sincronia: O VBoxContainer do professor não foi encontrado em nenhum nó ativo.")

func join_classroom(ip_address):
	peer = WebSocketClient.new()
	var url = "ws://" + ip_address + ":" + str(DEFAULT_PORT)
	
	var error = peer.connect_to_url(url, PoolStringArray(), true)
	if error != OK:
		print("Failed to connect via WebSocket: ", error)
		return
	get_tree().network_peer = peer
	print("Connecting to teacher via WebSocket at ", url)

# Quando um aluno se conecta, o Host envia a aula individualmente para ele
func _on_peer_connected(id):
	if get_tree().is_network_server() and not current_lecture.empty():
		rpc_id(id, "receive_lecture", current_lecture)

func get_classroom_ip() -> String:
	if OS.has_feature("JavaScript"):
		return "Run on Desktop to Host"
		
	var addresses = IP.get_local_addresses()
	for ip in addresses:
		if ip == "127.0.0.1" or ip == "::1" or ip.begins_with("0:"):
			continue
		if not ":" in ip:
			if ip.begins_with("192.168.") or ip.begins_with("10.") or ip.begins_with("172."):
				return ip
	for ip in addresses:
		if not ":" in ip and ip != "127.0.0.1":
			return ip
			
	return "No LAN Connection"

func send_lecture_to_students(lecture_data):
	current_lecture = lecture_data
	rpc("receive_lecture", lecture_data)
	Save.lectures = lecture_data

remotesync func receive_lecture(lecture_data):
	current_lecture = lecture_data
	Save.lectures = lecture_data
	emit_signal("lecture_received")
