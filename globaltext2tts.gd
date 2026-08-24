extends Node

var regex_bbcode := RegEx.new()

func _ready() -> void:
	regex_bbcode.compile("\\[[^\\]]*\\]")
	
	# Previne o menu de contexto no navegador (HTML5)
	if OS.get_name() == "HTML5":
		JavaScript.eval("""
			window.addEventListener('contextmenu', function(e) {
				e.preventDefault();
			}, false);
		""")
	
	# Conecta automaticamente os nós existentes e novos que entrarem na árvore
	get_tree().connect("node_added", self, "_on_node_added")
	_conectar_nos_existentes(get_tree().root)


func _conectar_nos_existentes(node: Node) -> void:
	_verificar_e_conectar(node)
	for child in node.get_children():
		_conectar_nos_existentes(child)


func _on_node_added(node: Node) -> void:
	_verificar_e_conectar(node)


func _verificar_e_conectar(node: Node) -> void:
	if node is Label or node is RichTextLabel or node is Button:
		# Garante que o nó receba cliques do mouse
		if node.mouse_filter == Control.MOUSE_FILTER_IGNORE:
			node.mouse_filter = Control.MOUSE_FILTER_PASS
			
		if not node.is_connected("gui_input", self, "_on_element_gui_input"):
			node.connect("gui_input", self, "_on_element_gui_input", [node])


func _on_element_gui_input(event: InputEvent, node: Control) -> void:
	# Dispara apenas no clique do botão direito
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		var texto_capturado = ""
		
		if node is RichTextLabel:
			texto_capturado = node.bbcode_text if node.bbcode_enabled else node.text
		elif node is Label or node is Button:
			texto_capturado = node.text
			
		var texto_limpo = limpar_bbcode(texto_capturado)
		
		if texto_limpo.strip_edges() != "":
			falar_tts(texto_limpo)


func falar_tts(texto: String) -> void:
	if get_node_or_null("/root/TTS"):
		get_node("/root/TTS").speak(texto)


func limpar_bbcode(texto_original: String) -> String:
	return regex_bbcode.sub(texto_original, "", true)
