extends Control

var resultado_final = 0
enum types {simple, problems}
export (types) var problem_type = types.simple

func _ready():
	randomize() # Call once at the start
	roll()

func roll():
	var label1 = $TextureRect/Button/Label2
	var label2 = $TextureRect/Button2/Label5
	var label3 = $TextureRect/Button3/Label4
	var label4 = $TextureRect/Button4/Label3

	var Number1 = (randi() % 10) + 1
	var Number2 = (randi() % 10) + 1
	
	if problem_type == types.simple:
		var Sinais = ["+", "-"]
		var SinalSorteado = Sinais[randi() % Sinais.size()]
		
		if SinalSorteado == "+":
			resultado_final = Number1 + Number2
		else:
			resultado_final = Number1 - Number2
		
		$TextureRect/Label.text = str(Number1) + " " + SinalSorteado + " " + str(Number2)

	elif problem_type == types.problems:
		# Define problems with their math type
		var problems = [
			{"text": "Ana tinha %s moedas e perdeu %s. Quantas sobraram?", "op": "-"},
			{"text": "João tinha %s balas e ganhou %s. Quantas tem agora?", "op": "+"}
		]
		
		var choice = problems[randi() % problems.size()]
		
		# Perform the correct math based on the chosen story
		if choice["op"] == "+":
			resultado_final = Number1 + Number2
		else:
			# Prevent negative results: make sure Number1 is the bigger one
			if Number1 < Number2:
				var temp = Number1
				Number1 = Number2
				Number2 = temp
			resultado_final = Number1 - Number2
		
		# Now apply the numbers to the template
		$TextureRect/Label.text = choice["text"] % [str(Number1), str(Number2)]

	label1.text = str(resultado_final + (randi() % 21) - 10)
	label2.text = str(resultado_final + (randi() % 21) - 10)
	label3.text = str(resultado_final + (randi() % 21) - 10)
	label4.text = str(resultado_final + (randi() % 21) - 10)

	# Overwrite one label with the correct answer
	var possible_labels = [label1, label2, label3, label4]
	var selected_to_be_right = possible_labels[randi() % possible_labels.size()]
	selected_to_be_right.text = str(resultado_final) # Removed the " = "

func check_if_correct(label):
	# Now this will compare "5" == "5" instead of " = 5" == "0"
	if label.text == str(resultado_final):
		print("certo")
	else:
		print("errado")
	roll()

func _on_Button_pressed():
	check_if_correct($TextureRect/Button/Label2)

func _on_Button2_pressed():
	check_if_correct($TextureRect/Button2/Label5)

func _on_Button3_pressed():
	check_if_correct($TextureRect/Button3/Label4)

func _on_Button4_pressed():
	check_if_correct($TextureRect/Button4/Label3)
