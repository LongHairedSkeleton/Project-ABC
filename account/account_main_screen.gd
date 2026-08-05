extends Control

func _ready():
	match PlayerVars.player_data["teacher"]:
		true:
			$Button.text = "+ clique aqui\n pra criar\n uma sala"
		false:
			$Button.text = "clique aqui\n para entrar\n numa sala"

func _on_TextureButton_pressed():
	get_tree().change_scene("res://account/settings.tscn")

func _on_Button_pressed():
	get_tree().change_scene("res://lan/question_selection.tscn")

	match PlayerVars.player_data["teacher"]:
		true:
			get_tree().change_scene("res://lan/question_selection.tscn")
		false:
			get_tree().change_scene("res://lan/puppet_screen.tscn")

func _on_TextureButton2_pressed():
	if OS.has_feature("HTML5"):
		JavaScript.eval("window.open('https://itch.io/this-page-does-not-exist')")
	else:
		OS.shell_open("https://itch.io/this-page-does-not-exist")

func _on_Button3_pressed():
	get_tree().quit()

func _on_Button2_pressed():
	# 1. Sinaliza no Save que a partida atual é Solo
	Save.solo_run = 1
	
	# 2. Reseta o dicionário de erros para a nova partida
	Save.mistakes.clear()
	
	# 3. Limpa o Lan para não ter conflito com conexões de rede
	Lan.current_lecture.clear()
	
	# 4. Define quantas questões de CADA matéria o aluno fará no Modo Solo
	# (Altere o '1' para '2' ou '3' se quiser mais questões por matéria)
	var QUESTIONS_PER_SUBJECT = 1
	
	var solo_lecture = {}
	for subject in ALL_SUBJECTS:
		solo_lecture[subject] = QUESTIONS_PER_SUBJECT

	# 5. Salva a nova lição gerada no Save global
	Save.lectures = solo_lecture
	
	# 6. Troca direto para o Gerenciador de Lições sem requisição de IP/Rede
	get_tree().change_scene("res://lan/lecture_manager.tscn")
# Lista com todas as atividades disponíveis no seu projeto

const ALL_SUBJECTS = [
	"Addition and subtraction",
	"Times and division",
	"conversion",
	"times",
	"problems",
	"spacial_geometry",
	"drawing",
	"spacial_notion",
	"rec_letras",
	"juntar_letras",
	"interpretacao",
	"escrita_correta",
	"generos",
	"maiuscula_minus",
	"pontuacao",
	"acentos",
	"singular_plural",
	"genero_gramatical",
	"verbos",
	"substantivos",
	"analise_ling"
]
