extends Control

onready var addition_subtraction_input = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/Label/LineEdit"
onready var times_division = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/Label2/LineEdit"
onready var problems = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/Label5/LineEdit"
onready var times = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/Label4/LineEdit"
onready var conversion = $"TabContainer/Matemática/ScrollContainer/VBoxContainer/Label6/LineEdit"

func _on_Button_pressed():
	# 1. Start the server
	Lan.host_classroom()
	
	# 2. Package the values into a dictionary
	var lecture_data = {
		"Addition and subtraction": int(addition_subtraction_input.text),
		"Times and division": int(times_division.text),
		"problems": int(problems.text),
		"times": int(times.text),
		"conversion": int(conversion.text)
	}
	
	# 3. Broadcast it to everyone who joins
	Lan.send_lecture_to_students(lecture_data)
	$AnimationPlayer.play("fade out")
	$RichTextLabel2.bbcode_text = "[center][wave]" + "your code is:" + "[tornado]" + Lan.get_classroom_ip()
