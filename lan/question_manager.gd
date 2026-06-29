extends Control

onready var addition_subtraction_input = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer/LineEdit"
onready var times_division = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer2/LineEdit"
onready var problems = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer4/LineEdit"
onready var times = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer3/LineEdit"
onready var conversion = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer5/LineEdit"

onready var division_in_equal_parts = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer6/LineEdit"
onready var spacial_geometry = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer7/LineEdit"
onready var drawing = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer8/LineEdit"
onready var spacial_notion = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/HBoxContainer9/LineEdit"

func _on_Button_pressed():
	# 1. Start the server
	Lan.host_classroom()
	
	# 2. Package the values into a dictionary
	var lecture_data = {
		"Addition and subtraction": int(addition_subtraction_input.text),
		"Times and division": int(times_division.text),
		"problems": int(problems.text),
		"times": int(times.text),
		"conversion": int(conversion.text),
		
		"division_in_equal_parts": int(division_in_equal_parts.text),
		"spacial_geometry": int(spacial_geometry.text),
		"drawing": int(drawing.text),
		"spacial_notion": int(spacial_notion.text)
	}
	Save.lectures = lecture_data
	print(Save.lectures)
	
	# 3. Broadcast it to everyone who joins
	Lan.send_lecture_to_students(lecture_data)
	$AnimationPlayer.play("fade out")
	$RichTextLabel2.bbcode_text = "[center][wave]" + "seu código é" + "[tornado]" + Lan.get_classroom_ip()
