extends Control



func Roll():
	randomize()
	var Number1 = (randi() % 21 -10)
	var Number2 = (randi() % 21 - 10)
	var Sinais = ["+", "-"]
	var SinalSorteado = Sinais[randi() % Sinais.size()]
	
	var conta_texto = str(Number1) + " " + SinalSorteado + " " + str(Number2)
	$TextureRect/Label.text = conta_texto

	if SinalSorteado == "+":
		var resultado_final = Number1 + Number2
		$TextureRect/Label2.text = " = " + str(resultado_final)

	var resultado_final = Number1 + Number2
		
	var label1 = $TextureRect/Label2
	var label2 = $TextureRect/Label3
	var label3 = $TextureRect/Label4
	var label4 = $TextureRect/Label5
	randomize()
	var rng = (randi() % 4) + 1
	if rng == 1:
		label1.text = str(resultado_final)
		label2.text = str(resultado_final + (randi() % 21) - 10)
		label3.text = str(resultado_final + (randi() % 21) - 10)
		label4.text = str(resultado_final + (randi() % 21) - 10)
	if rng == 2:
		label1.text = str(resultado_final + (randi() % 21) - 10)
		label2.text = str(resultado_final)
		label3.text = str(resultado_final + (randi() % 21) - 10)
		label4.text = str(resultado_final + (randi() % 21) - 10)
	if rng == 3:
		label1.text = str(resultado_final + (randi() % 21) - 10)
		label2.text = str(resultado_final + (randi() % 21) - 10)
		label3.text = str(resultado_final)
		label4.text = str(resultado_final + (randi() % 21) - 10)
	if rng == 4:
		label1.text = str(resultado_final + (randi() % 21) - 10)
		label2.text = str(resultado_final + (randi() % 21) - 10)
		label3.text = str(resultado_final + (randi() % 21) - 10)
		label4.text = str(resultado_final)

func _ready():
	Roll()
