extends Node

const DEFAULT_PORT = 8910
var peer = NetworkedMultiplayerENet.new()

# Holds the current lecture configuration
var current_lecture = {}

signal lecture_received

func _ready():
	# Connect Godot 3 networking signals
	get_tree().connect("network_peer_connected", self, "_on_peer_connected")

func host_classroom():
	var error = peer.create_server(DEFAULT_PORT, 32)
	if error != OK:
		print("Failed to host: ", error)
		return
	get_tree().network_peer = peer
	print("Classroom hosted on port ", DEFAULT_PORT)

func send_lecture_to_students(lecture_data):
	current_lecture = lecture_data
	# rpc() sends the data to all connected clients in Godot 3
	rpc("receive_lecture", lecture_data)
	Save.lectures = lecture_data

# --- STUDENT FUNCTIONS ---
func join_classroom(ip_address):
	var error = peer.create_client(ip_address, DEFAULT_PORT)
	if error != OK:
		print("Failed to connect: ", error)
		return
	get_tree().network_peer = peer
	print("Connecting to teacher at ", ip_address)

# --- SHARED NETWORK FUNCTIONS ---
# "remotesync" means it runs on everyone's computer, including the sender
remotesync func receive_lecture(lecture_data):
	current_lecture = lecture_data
	print("Received lecture from teacher: ", lecture_data)
	Save.lectures = lecture_data
	emit_signal("lecture_received")

func _on_peer_connected(id):
	# If teacher sees a new student connect, send them the current lecture
	if get_tree().is_network_server() and not current_lecture.empty():
		rpc_id(id, "receive_lecture", current_lecture)
# Add this inside NetworkManager.gd

func get_classroom_ip() -> String:
	var addresses = IP.get_local_addresses()
	
	for ip in addresses:
		# 1. Ignore loopback/local host addresses (both IPv4 and IPv6)
		if ip == "127.0.0.1" or ip == "::1" or ip.begins_with("0:"):
			continue
			
		# 2. Check if the address is a standard IPv4 address
		# Valid IPv4 addresses only contain numbers and periods (no colons)
		if not ":" in ip:
			# 3. Look for standard home/school router IP ranges
			if ip.begins_with("192.168.") or ip.begins_with("10.") or ip.begins_with("172."):
				return ip

	# Fallback: If no standard LAN IP was caught but we have a valid IPv4, use it
	for ip in addresses:
		if not ":" in ip and ip != "127.0.0.1":
			return ip
			
	return "No LAN Connection"
