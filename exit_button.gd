extends TextureButton

func _on_TextureButton_pressed():
	$"../../Control2".show()

func _on_TextureButton1_pressed():
	$"../../Control2".hide()

func _on_TextureButton2_pressed():
	get_tree().change_scene("res://menu.tscn")
