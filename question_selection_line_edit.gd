extends LineEdit

# Variável para armazenar o último texto válido
var texto_anterior = ""

func _ready():
	connect("text_changed", self, "_on_LineEdit_text_changed")

func _on_LineEdit_text_changed(new_text):
	# Se o texto estiver vazio, permite e salva o estado
	if new_text == "":
		texto_anterior = ""
		return

	# Verifica se o texto é um número válido (float)
	if new_text.is_valid_float():
		texto_anterior = new_text
	else:
		# Se não for número, volta para o último texto válido
		self.text = texto_anterior
		# Coloca o cursor no final do texto para evitar confusão
		self.caret_position = self.text.length()
