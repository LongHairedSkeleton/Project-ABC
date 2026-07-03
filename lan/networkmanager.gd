extends Node

const DEFAULT_PORT = 8910
var peer = null
var current_lecture = {}

signal lecture_received

func _ready():
	get_tree().connect("network_peer_connected", self, "_on_peer_connected")

func host_classroom():
	# This opens a WebSocket server. Works on Desktop only!
	peer = WebSocketServer.new()
	var error = peer.listen(DEFAULT_PORT, PoolStringArray(), true)
	if error != OK:
		print("Failed to host WebSocket server: ", error)
		return
	get_tree().network_peer = peer
	print("Classroom hosted via WebSockets on port ", DEFAULT_PORT)

func send_lecture_to_students(lecture_data):
	current_lecture = lecture_data
	rpc("receive_lecture", lecture_data)
	if "Save" in self:
		Save.lectures = lecture_data

func join_classroom(ip_address):
	# This connects a client. Works on BOTH Browser and Desktop!
	peer = WebSocketClient.new()
	var url = "ws://" + ip_address + ":" + str(DEFAULT_PORT)
	
	var error = peer.connect_to_url(url, PoolStringArray(), true)
	if error != OK:
		print("Failed to connect via WebSocket: ", error)
		return
	get_tree().network_peer = peer
	print("Connecting to teacher via WebSocket at ", url)

remotesync func receive_lecture(lecture_data):
	current_lecture = lecture_data
	if "Save" in self:
		Save.lectures = lecture_data
	emit_signal("lecture_received")

func _on_peer_connected(id):
	if get_tree().is_network_server() and not current_lecture.empty():
		rpc_id(id, "receive_lecture", current_lecture)

func get_classroom_ip() -> String:
	# Browsers can't access local network cards, so hide this logic from them
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
