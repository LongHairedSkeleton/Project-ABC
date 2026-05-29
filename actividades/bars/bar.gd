extends VBoxContainer

func less(number):
	# Garante que 'number' seja um número inteiro (ex: 4 em vez de 4.3)
	var quantidade_para_deletar = int(number) 
	
	var filhos = get_children()
	
	# Passa de trás para frente para evitar erros de índice ao deletar
	for i in range(filhos.size() - 1, -1, -1):
		if quantidade_para_deletar <= 0:
			break # Já deletou o número necessário, para o loop
			
		filhos[i].queue_free()
		quantidade_para_deletar -= 1

func _on_VBoxContainer_mouse_entered():
	self.modulate = Color(1, 1, 1, 0.5)

func _on_VBoxContainer_mouse_exited():
	self.modulate = Color(1, 1, 1, 1)

func _on_VBoxContainer_gui_input(event):
	if event is InputEventMouseButton:
		click()

signal check(children, obj)

func click():
	emit_signal("check", get_child_count(), self)
