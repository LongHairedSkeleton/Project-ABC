extends Control

var resultado_final = 0
enum types {simple, problems, simple_plus}
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
	
	var Sinais = ["+", "-"]
	var SinalSorteado = Sinais[randi() % Sinais.size()]

	if problem_type == types.simple:
		Sinais = ["+", "-"]

	if problem_type == types.simple_plus:
		Sinais = ["+", "-", "×", "÷"]
		SinalSorteado = Sinais[randi() % Sinais.size()]

		$TextureRect/Label.text = str(Number1) + " " + SinalSorteado + " " + str(Number2)

	if SinalSorteado == "+":
		resultado_final = Number1 + Number2
	if SinalSorteado == "-":
		resultado_final = Number1 - Number2
	if SinalSorteado == "×":
		resultado_final = Number1 * Number2
	if SinalSorteado == "÷":
		# Enquanto o resto da divisão não for 0, sorteia novos números
		while Number1 % Number2 != 0:
			Number1 = (randi() % 10) + 1
			Number2 = (randi() % 10) + 1
		
		# Atualiza o texto da Label com os novos números válidos
		$TextureRect/Label.text = str(Number1) + " " + SinalSorteado + " " + str(Number2)
		resultado_final = Number1 / Number2

	elif problem_type == types.problems:
		# Define problems with their math type
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
