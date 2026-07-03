extends Control

signal task_completed

var resultado_final = 0
enum types {simple,problems,simple_plus,times,conversion}
var problem_type = types.times # Will be overwritten dynamically when loaded

export var amount_of_numbers = 3 

func _ready():
	randomize() 

	roll()
	#if problem_type == types.problems or problem_type == types.conversion:
		#$Label.rect_position.y = 50

func roll():
	var label1 = $Button
	var label2 = $Button2
	var label3 = $Button3
	var label4 = $Button4
	var labels = [label1, label2, label3, label4]

	# ==========================================
	# NOVO MODO: MEDIDAS E GRANDEZAS
	# ==========================================
	if problem_type == types.conversion:
		var regras = [
			{"text": "%s minuto(s) tem quantos segundos?", "mult": 60},
			{"text": "%s hora(s) tem quantos minutos?", "mult": 60},
			{"text": "%s metro(s) tem quantos centímetros?", "mult": 100},
			{"text": "%s quilômetro(s) tem quantos metros?", "mult": 1000},
			{"text": "%s quilo(s) (kg) tem quantas gramas?", "mult": 1000},
			{"text": "%s litro(s) tem quantos mililitros?", "mult": 1000}
		]
		
		var regra_sorteada = regras[randi() % regras.size()]
		var valor_inicial = (randi() % 5) + 1 
		resultado_final = valor_inicial * regra_sorteada["mult"]
		$Panel/Label.bbcode_text = "[wave][center]" + regra_sorteada["text"] % str(valor_inicial)
		
		for label_node in labels:
			var erro_fator = (randi() % 4) - 2
			if erro_fator == 0: erro_fator = 1
			var valor_falso = (valor_inicial + erro_fator) * regra_sorteada["mult"]
			if valor_falso <= 0: 
				valor_falso = (valor_inicial + 3) * regra_sorteada["mult"]
			label_node.text = str(valor_falso)

		var selected_to_be_right = labels[randi() % labels.size()]
		selected_to_be_right.text = str(resultado_final)
		return

	if problem_type == types.problems:
		var problems = [
			{"text": "Ana tinha %s moedas e perdeu %s. Quantas sobraram?", "op": "-"},
			{"text": "João tinha %s balas e ganhou %s. Quantas tem agora?", "op": "+"},
			{"text": "Carlos comprou %s maçãs e comeu %s. Quantas restaram?", "op": "-"},
			{"text": "Marina tinha %s figurinhas e ganhou mais %s. Quantas possui agora?", "op": "+"},
			{"text": "Um ônibus tinha %s passageiros e %s desceram. Quantos ficaram?", "op": "-"},
			{"text": "Pedro encontrou %s reais e depois achou mais %s. Quanto dinheiro ele tem?", "op": "+"},
			{"text": "Uma caixa tinha %s lápis e %s foram usados. Quantos sobraram?", "op": "-"},
			{"text": "Sofia tinha %s flores e recebeu mais %s. Quantas flores ela tem agora?", "op": "+"},
			{"text": "Lucas tinha %s vidas no jogo e perdeu %s. Quantas restam?", "op": "-"},
			{"text": "Uma fazenda tinha %s galinhas e nasceram mais %s. Quantas há agora?", "op": "+"},
			{"text": "Um tanque tinha %s litros de água e %s litros foram usados. Quantos sobraram?", "op": "-"},
			{"text": "Bianca tinha %s livros e comprou mais %s. Quantos livros ela possui?", "op": "+"},
			{"text": "Rafael tinha %s carrinhos e deu %s para um amigo. Quantos ficaram?", "op": "-"},
			{"text": "Clara tinha %s adesivos e ganhou mais %s. Quantos adesivos ela tem?", "op": "+"},
			{"text": "Uma árvore tinha %s frutas e %s caíram. Quantas sobraram?", "op": "-"},
			{"text": "Miguel juntou %s pedras e encontrou mais %s. Quantas pedras ele possui?", "op": "+"},
			{"text": "Laura tinha %s chocolates e comeu %s. Quantos restaram?", "op": "-"},
			{"text": "Felipe tinha %s moedas e ganhou mais %s. Quantas moedas ele possui?", "op": "+"},
			{"text": "Uma biblioteca tinha %s revistas e %s foram retiradas. Quantas ficaram?", "op": "-"},
			{"text": "Camila tinha %s canetas e comprou mais %s. Quantas ela tem agora?", "op": "+"},
			{"text": "Henrique tinha %s cartas e perdeu %s. Quantas sobraram?", "op": "-"},
			{"text": "Juliana tinha %s bonecas e ganhou mais %s. Quantas bonecas ela possui?", "op": "+"},
			{"text": "Um estacionamento tinha %s carros e %s saíram. Quantos ficaram?", "op": "-"},
			{"text": "Gustavo tinha %s peixes no aquário e comprou mais %s. Quantos peixes há agora?", "op": "+"},
			{"text": "Alice tinha %s cupcakes e vendeu %s. Quantos sobraram?", "op": "-"},
			{"text": "Um trem levava %s passageiros e entraram mais %s. Quantos há agora?", "op": "+"},
			{"text": "Daniel tinha %s folhas e rasgou %s. Quantas sobraram?", "op": "-"},
			{"text": "Helena tinha %s pulseiras e ganhou mais %s. Quantas ela possui?", "op": "+"},
			{"text": "Uma escola tinha %s computadores e %s quebraram. Quantos restaram?", "op": "-"},
			{"text": "Samuel tinha %s moedas douradas e encontrou mais %s. Quantas ele tem?", "op": "+"},
			{"text": "Valentina tinha %s bolinhas de gude e perdeu %s. Quantas sobraram?", "op": "-"},
			{"text": "Um mercado tinha %s caixas e chegaram mais %s. Quantas há agora?", "op": "+"},
			{"text": "Eduardo tinha %s pipas e %s rasgaram. Quantas sobraram?", "op": "-"},
			{"text": "Nicole tinha %s colares e comprou mais %s. Quantos colares ela possui?", "op": "+"},
			{"text": "Uma praia tinha %s guarda-sóis e %s foram fechados. Quantos ficaram abertos?", "op": "-"},
			{"text": "Thiago tinha %s estrelas no jogo e ganhou mais %s. Quantas possui agora?", "op": "+"},
			{"text": "Beatriz tinha %s cookies e comeu %s. Quantos sobraram?", "op": "-"},
			{"text": "Arthur tinha %s peças de lego e ganhou mais %s. Quantas peças ele tem?", "op": "+"},
			{"text": "Uma loja tinha %s camisetas e vendeu %s. Quantas restaram?", "op": "-"},
			{"text": "Lorena tinha %s flores e plantou mais %s. Quantas flores existem agora?", "op": "+"},
			{"text": "Um navio tinha %s tripulantes e %s desembarcaram. Quantos ficaram?", "op": "-"},
			{"text": "Caio tinha %s diamantes no jogo e encontrou mais %s. Quantos possui?", "op": "+"},
			{"text": "Melissa tinha %s sorvetes e vendeu %s. Quantos sobraram?", "op": "-"},
			{"text": "Uma vila tinha %s habitantes e chegaram mais %s. Quantos habitantes há agora?", "op": "+"},
			{"text": "Igor tinha %s revistas e perdeu %s. Quantas sobraram?", "op": "-"},
			{"text": "Fernanda tinha %s brinquedos e ganhou mais %s. Quantos brinquedos ela possui?", "op": "+"},
			{"text": "Um jardim tinha %s rosas e %s murcharam. Quantas sobraram?", "op": "-"},
			{"text": "Vinícius tinha %s pontos e marcou mais %s. Quantos pontos possui agora?", "op": "+"},
			{"text": "Uma mochila tinha %s cadernos e %s foram retirados. Quantos sobraram?", "op": "-"},
			{"text": "Patrícia tinha %s moedas de prata e encontrou mais %s. Quantas ela possui?", "op": "+"}
		]
		
		var choice = problems[randi() % problems.size()]
		var n1 = (randi() % 10) + 1
		var n2 = (randi() % 10) + 1
		
		if choice["op"] == "+":
			resultado_final = n1 + n2
		else:
			if n1 < n2:
				var temp = n1
				n1 = n2
				n2 = temp
			resultado_final = n1 - n2

		$Panel/Label.bbcode_text = "[wave][center]" + choice["text"] % [str(n1), str(n2)]
	elif problem_type == types.times:
		var repeated_number = (randi() % 10) + 1
		resultado_final = repeated_number * amount_of_numbers 
		
		var addition_array = []
		for i in range(amount_of_numbers):
			addition_array.append(str(repeated_number))
		
		var expression_string = ""
		for i in range(addition_array.size()):
			expression_string += addition_array[i]
			if i < addition_array.size() - 1:
				expression_string += " + "
				
		$Panel/Label.bbcode_text = "[wave][center]" + expression_string
	else:
		var Sinais = ["+", "-"]
		if problem_type == types.simple_plus:
			Sinais = ["+", "-", "*", "/"]

		var current_numbers = []
		var first_number = (randi() % 10) + 1
		current_numbers.append(first_number)
		var chosen_signs = []

		for i in range(amount_of_numbers - 1):
			var next_sign = Sinais[randi() % Sinais.size()]
			var next_number = (randi() % 10) + 1

			if next_sign == "/":
				while next_number == 0:
					next_number = (randi() % 10) + 1
				
				var numero_anterior = current_numbers[i]
				if numero_anterior == 0 or numero_anterior % next_number != 0:
					var multiplicador = (randi() % 3) + 1
					current_numbers[i] = next_number * multiplicador

			chosen_signs.append(next_sign)
			current_numbers.append(next_number)

		var expression_string = str(current_numbers[0])
		for i in range(chosen_signs.size()):
			expression_string += " " + chosen_signs[i] + " " + str(current_numbers[i+1])
		
		var expr = Expression.new()
		var error = expr.parse(expression_string)
		if error == OK:
			var resultado = expr.execute([], null)
			resultado_final = int(resultado) 
		else:
			print("Erro ao processar a expressão")
		var display_string = expression_string.replace("*", " x ").replace("/", " : ")
		$Panel/Label.bbcode_text = "[wave][center]" + display_string

	if problem_type == types.times:
		var valor_base = int(resultado_final) / amount_of_numbers 
		
		for label_node in labels:
			# Gera um multiplicador falso (ex: se o certo é 3, ele pode gerar 2, 4, 5...)
			var fake_multiplier = amount_of_numbers + (randi() % 5) - 2
			
			if fake_multiplier == amount_of_numbers or fake_multiplier <= 0:
				fake_multiplier = amount_of_numbers + 1
				
			label_node.text = str(valor_base) + "x" + str(fake_multiplier)
			
		var selected_to_be_right = labels[randi() % labels.size()]
		selected_to_be_right.text = str(valor_base) + "x" + str(amount_of_numbers)
	else:
		for label_node in labels:
			label_node.text = str(resultado_final + (randi() % 21) - 10)
		var selected_to_be_right = labels[randi() % labels.size()]
		selected_to_be_right.text = str(resultado_final)

func check_if_correct(label):
	var is_correct = false
	
	if problem_type == types.times:
		var valor_base = int(resultado_final) / amount_of_numbers
		var texto_correto_esperado = str(valor_base) + "x" + str(amount_of_numbers)
		
		if label.text == texto_correto_esperado:
			is_correct = true

	elif label.text.begins_with(str(resultado_final)):
		is_correct = true

	if is_correct:
		var right = preload("res://right.tscn")
		$Control2.get_points(int(rand_range(1000, 1500)))
		var right_instance = right.instance()
		add_child(right_instance)
		
		yield(get_tree().create_timer(1.0), "timeout")
		emit_signal("task_completed")
	else:
		var wrong = preload("res://wrong.tscn")
		$Control2.get_points(int(rand_range(-750, -500)))
		var wrong_instance = wrong.instance()
		
		var current_subject = "Unknown"
		if problem_type == types.simple: current_subject = "Addition and subtraction"
		elif problem_type == types.simple_plus: current_subject = "Times and division"
		elif problem_type == types.conversion: current_subject = "conversion"
		elif problem_type == types.problems: current_subject = "problems"
		elif problem_type == types.times: current_subject = "times"
			
		wrong_instance.current_exercise = current_subject
		add_child(wrong_instance)
		

func _on_Button_pressed(): check_if_correct($Button)
func _on_Button2_pressed(): check_if_correct($Button2)
func _on_Button3_pressed(): check_if_correct($Button3)
func _on_Button4_pressed(): check_if_correct($Button4)
