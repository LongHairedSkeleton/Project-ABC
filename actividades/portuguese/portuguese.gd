extends Control

signal task_completed

var resultado_final = "" 
enum types {
	rec_letras,       
	juntar_letras,    
	interpretacao,   
	escrita_correta,  
	generos,          
	maiuscula_minus,  
	pontuacao,        
	acentos,          
	singular_plural,  
	genero_gramatical,
	verbos,           
	substantivos,     
	analise_ling      
}

var problem_type = types.interpretacao

func _ready():
	randomize() 
	roll()

func roll():
	var label1 = $Button
	var label2 = $Button2
	var label3 = $Button3
	var label4 = $Button4
	var labels = [label1, label2, label3, label4]

	var banco_questoes = _obter_banco_questoes()
	
	if banco_questoes.has(problem_type):
		var lista_questoes = banco_questoes[problem_type]
		var questao_sorteada = lista_questoes[randi() % lista_questoes.size()]
		

		$Panel/Label.bbcode_text = "[wave][center]" + questao_sorteada["pergunta"]
		resultado_final = questao_sorteada["correta"]
		

		var opcoes = questao_sorteada["alternativas"].duplicate()
		opcoes.shuffle()
		
		for i in range(labels.size()):
			labels[i].text = opcoes[i]

func _obter_banco_questoes() -> Dictionary:
	var banco = {}
	

	banco[types.rec_letras] = [
		{"pergunta": "Quantas sílabas tem a palavra 'BONECA'?", "correta": "3", "alternativas": ["3", "2", "4", "5"]},
		{"pergunta": "Qual é a primeira sílaba da palavra 'CAVALO'?", "correta": "CA", "alternativas": ["CA", "VA", "LO", "CO"]},
		{"pergunta": "Qual palavra rima com 'GATO'?", "correta": "RATO", "alternativas": ["RATO", "BOLA", "CASA", "DADO"]},
		# +20 Novas Questões
		{"pergunta": "Quantas sílabas tem a palavra 'PATO'?", "correta": "2", "alternativas": ["2", "1", "3", "4"]},
		{"pergunta": "Qual é a última sílaba da palavra 'SAPATO'?", "correta": "TO", "alternativas": ["TO", "SA", "PA", "TA"]},
		{"pergunta": "Qual palavra rima com 'JANELA'?", "correta": "PANELA", "alternativas": ["PANELA", "COPO", "GATO", "SOL"]},
		{"pergunta": "Quantas sílabas tem a palavra 'ELEFANTE'?", "correta": "4", "alternativas": ["4", "3", "5", "2"]},
		{"pergunta": "Qual é a primeira sílaba de 'BOLA'?", "correta": "BO", "alternativas": ["BO", "BA", "LA", "LO"]},
		{"pergunta": "Qual palavra rima com 'LEÃO'?", "correta": "SABÃO", "alternativas": ["SABÃO", "LUA", "CASA", "BALÃO"]},
		{"pergunta": "Quantas sílabas tem a palavra 'SOL'?", "correta": "1", "alternativas": ["1", "2", "3", "4"]},
		{"pergunta": "Qual é a sílaba do meio da palavra 'MACADO'?", "correta": "CA", "alternativas": ["CA", "MA", "CO", "DA"]},
		{"pergunta": "Qual palavra rima com 'COLA'?", "correta": "SACOLA", "alternativas": ["SACOLA", "BOLO", "DADO", "REI"]},
		{"pergunta": "Quantas sílabas tem a palavra 'BORBOLETA'?", "correta": "4", "alternativas": ["4", "3", "5", "6"]},
		{"pergunta": "Qual é a primeira sílaba de 'URSO'?", "correta": "UR", "alternativas": ["UR", "SO", "RU", "SU"]},
		{"pergunta": "Qual palavra rima com 'PIÃO'?", "correta": "MÃO", "alternativas": ["MÃO", "PÉ", "DADO", "RATO"]},
		{"pergunta": "Quantas sílabas tem a palavra 'CASA'?", "correta": "2", "alternativas": ["2", "1", "3", "4"]},
		{"pergunta": "Qual é a última sílaba de 'CORAÇÃO'?", "correta": "ÇÃO", "alternativas": ["ÇÃO", "CO", "RA", "ON"]},
		{"pergunta": "Qual palavra rima com 'FLOR'?", "correta": "AMOR", "alternativas": ["AMOR", "MAR", "CÉU", "LUZ"]},
		{"pergunta": "Quantas sílabas tem a palavra 'TELEFONE'?", "correta": "4", "alternativas": ["4", "3", "5", "2"]},
		{"pergunta": "Qual é a primeira sílaba de 'GIRAFA'?", "correta": "GI", "alternativas": ["GI", "RA", "FA", "GE"]},
		{"pergunta": "Qual palavra rima com 'MALA'?", "correta": "BALA", "alternativas": ["BALA", "BOLO", "GATO", "SOPA"]},
		{"pergunta": "Quantas sílabas tem a palavra 'COMPUTADOR'?", "correta": "4", "alternativas": ["4", "3", "5", "6"]},
		{"pergunta": "Qual é a sílaba final de 'URUBU'?", "correta": "BU", "alternativas": ["BU", "RU", "U", "BA"]}
	]
	

	banco[types.juntar_letras] = [
		{"pergunta": "Se Juntarmos B + O + L + A, qual palavra formamos?", "correta": "BOLA", "alternativas": ["BOLA", "BALA", "BOLO", "COLA"]},
		{"pergunta": "Qual palavra se forma com as sílabas 'PA' + 'TE' + 'TA'?", "correta": "PATETA", "alternativas": ["PATETA", "PANELA", "BATATA", "TAPETE"]},
		# +20 Novas Questões
		{"pergunta": "Se juntarmos D + A + D + O, formamos qual palavra?", "correta": "DADO", "alternativas": ["DADO", "DEDO", "DIA", "DOCE"]},
		{"pergunta": "Qual palavra se forma com 'MA' + 'CA' + 'CO'?", "correta": "MACACO", "alternativas": ["MACACO", "MALETA", "CASA", "CAVALO"]},
		{"pergunta": "Se juntarmos F + O + C + A, o que formamos?", "correta": "FOCA", "alternativas": ["FOCA", "FACA", "FOGO", "COCA"]},
		{"pergunta": "Qual palavra se forma com 'SA' + 'PA' + 'TO'?", "correta": "SAPATO", "alternativas": ["SAPATO", "SACOLA", "TAPETE", "SOPA"]},
		{"pergunta": "Se juntarmos L + U + A, qual é a palavra?", "correta": "LUA", "alternativas": ["LUA", "LUTA", "RUA", "ALU"]},
		{"pergunta": "Qual palavra se forma com 'PI' + 'PO' + 'CA'?", "correta": "PIPOCA", "alternativas": ["PIPOCA", "PENEIRA", "PETECA", "PIÃO"]},
		{"pergunta": "Se juntarmos G + A + T + O, formamos:", "correta": "GATO", "alternativas": ["GATO", "RATO", "MATO", "GADO"]},
		{"pergunta": "Qual palavra se forma com 'BA' + 'NA' + 'NA'?", "correta": "BANANA", "alternativas": ["BANANA", "BAU", "BONÉ", "BANA"]},
		{"pergunta": "Se juntarmos R + E + I, formamos:", "correta": "REI", "alternativas": ["REI", "RIO", "RUA", "RÉU"]},
		{"pergunta": "Qual palavra se forma com 'JA' + 'RE' + 'CO'?", "correta": "JACARÉ", "alternativas": ["JACARÉ", "JANELA", "CORAÇÃO", "JARRA"]},
		{"pergunta": "Se juntarmos S + O + L, formamos:", "correta": "SOL", "alternativas": ["SOL", "SUL", "SAL", "SO"]},
		{"pergunta": "Qual palavra se forma com 'PE' + 'TE' + 'CA'?", "correta": "PETECA", "alternativas": ["PETECA", "PANELA", "PIPOCA", "PATO"]},
		{"pergunta": "Se juntarmos L + I + V + R + O, formamos:", "correta": "LIVRO", "alternativas": ["LIVRO", "LIVRE", "LAVRA", "LINO"]},
		{"pergunta": "Qual palavra se forma com 'BO' + 'NE' + 'CA'?", "correta": "BONECA", "alternativas": ["BONECA", "BONÉ", "BALA", "CANECA"]},
		{"pergunta": "Se juntarmos U + V + A, formamos:", "correta": "UVA", "alternativas": ["UVA", "OVO", "AVE", "UMA"]},
		{"pergunta": "Qual palavra se forma com 'ME' + 'LI' + 'NA'?", "correta": "MENINA", "alternativas": ["MENINA", "MENINO", "MALA", "MINA"]},
		{"pergunta": "Se juntarmos R + A + T + O, formamos:", "correta": "RATO", "alternativas": ["RATO", "GATO", "PATO", "ROTA"]},
		{"pergunta": "Qual palavra se forma com 'CA' + 'NE' + 'TA'?", "correta": "CANETA", "alternativas": ["CANETA", "CANECA", "CASA", "CAMA"]},
		{"pergunta": "Se juntarmos M + E + S + A, formamos:", "correta": "MESA", "alternativas": ["MESA", "MISSA", "MEIO", "MASSA"]},
		{"pergunta": "Qual palavra se forma com 'TI' + 'G0' + 'RE'?", "correta": "TIGRE", "alternativas": ["TIGRE", "TIJOLO", "TIME", "GATO"]}
	]
	

	banco[types.interpretacao] = [
		{"pergunta": "'O gato Mimi subiu no telhado e miou alto.' Quem subiu no telhado?", "correta": "O gato Mimi", "alternativas": ["O gato Mimi", "O cachorro", "O passarinho", "O rato"]},
		{"pergunta": "'Lúcia comprou uma boneca nova e guardou na caixa.' Onde a boneca foi guardada?", "correta": "Na caixa", "alternativas": ["Na caixa", "Na cama", "No armário", "Na sacola"]},
		{"pergunta": "'O sapo pulou na lagoa para fugir da chuva.' Para onde o sapo pulou?", "correta": "Na lagoa", "alternativas": ["Na lagoa", "Na árvore", "Na casa", "Na lama"]},
		{"pergunta": "'O Sol brilha forte no céu azul.' Como está o céu?", "correta": "Azul", "alternativas": ["Azul", "Nublado", "Escuro", "Verde"]},
		{"pergunta": "'Aninha comeu uma maçã vermelha e doce.' O que Aninha comeu?", "correta": "Uma maçã", "alternativas": ["Uma maçã", "Uma banana", "Um bolo", "Uma uva"]},
		{"pergunta": "'O cachorrinho Totó adora brincar com a bola vermelha.' Qual a cor da bola?", "correta": "Vermelha", "alternativas": ["Vermelha", "Azul", "Verde", "Amarela"]},
		{"pergunta": "'Papai pegou a chave e abriu o carro.' O que papai usou para abrir o carro?", "correta": "A chave", "alternativas": ["A chave", "A mão", "Um martelo", "Um controle"]},
		{"pergunta": "'O palhaço Pipoca caiu e todo mundo riu.' Quem caiu?", "correta": "O palhaço Pipoca", "alternativas": ["O palhaço Pipoca", "O trapezista", "O mágico", "O público"]},
		{"pergunta": "'A professora leu uma história linda na sala de aula.' Onde a professora leu a história?", "correta": "Na sala de aula", "alternativas": ["Na sala de aula", "No pátio", "Na biblioteca", "Em casa"]},
		{"pergunta": "'O trem apitou e correu nos trilhos.' Onde o trem correu?", "correta": "Nos trilhos", "alternativas": ["Nos trilhos", "Na rua", "No rio", "No céu"]},
		{"pergunta": "'O peixinho Azulão nada rápido no aquário.' Qual o nome do peixinho?", "correta": "Azulão", "alternativas": ["Azulão", "Nemo", "Peixinho", "Rápido"]},
		{"pergunta": "'A pipa do Leo voou tão alto que sumiu nas nuvens.' De quem era a pipa?", "correta": "Do Leo", "alternativas": ["Do Leo", "Do Lucas", "Do João", "Do gato"]},
		{"pergunta": "'Mamãe fez um bolo de chocolate para o lanche.' Qual o sabor do bolo?", "correta": "Chocolate", "alternativas": ["Chocolate", "Morango", "Baunilha", "Milho"]},
		{"pergunta": "'O coelho pulou na horta e comeu uma cenoura.' O que o coelho comeu?", "correta": "Uma cenoura", "alternativas": ["Uma cenoura", "Uma alface", "Uma maçã", "Um tomate"]},
		{"pergunta": "'O passarinho construiu seu ninho no galho da árvore.' Onde está o ninho?", "correta": "No galho da árvore", "alternativas": ["No galho da árvore", "No chão", "No telhado", "Na janela"]},
		{"pergunta": "'Vovó usa óculos para ler seus livros.' O que a vovó usa para ler?", "correta": "Óculos", "alternativas": ["Óculos", "Lupa", "Chapéu", "Caneta"]},
		{"pergunta": "'Choveu muito ontem e a rua ficou cheia de lama.' Como ficou a rua?", "correta": "Cheia de lama", "alternativas": ["Cheia de lama", "Limpa", "Seca", "Asfaltada"]},
		{"pergunta": "'O macaco comeu três bananas bem maduras.' Quantas bananas o macaco comeu?", "correta": "Três", "alternativas": ["Três", "Duas", "Quatro", "Uma"]},
		{"pergunta": "'O despertador tocou às sete horas da manhã.' Que horas o despertador tocou?", "correta": "Sete horas", "alternativas": ["Sete horas", "Seis horas", "Oito horas", "Nove horas"]},
		{"pergunta": "'Pedro colocou suas botas e foi pisar na poça de água.' O que Pedro calçou?", "correta": "Botas", "alternativas": ["Botas", "Tênis", "Chinelos", "Sapatos"]},
		{"pergunta": "'A tartaruga caminha devagar pela areia da praia.' Onde a tartaruga caminha?", "correta": "Na areia da praia", "alternativas": ["Na areia da praia", "No rio", "Na floresta", "Na estrada"]},
		{"pergunta": "'O jacaré abriu a boca grande no rio.' Quem abriu a boca grande?", "correta": "O jacaré", "alternativas": ["O jacaré", "O peixe", "O sapo", "O urso"]}
	]

	banco[types.escrita_correta] = [
		{"pergunta": "Qual palavra está escrita de forma CORRETA?", "correta": "CASA", "alternativas": ["CASA", "CAZA", "KASA", "KAZA"]},
		{"pergunta": "Marque a opção que tem a escrita certa:", "correta": "CHUCHU", "alternativas": ["CHUCHU", "XUXU", "CHUXU", "XUCHU"]},
		{"pergunta": "Qual a escrita correta do nome deste animal?", "correta": "GIRAFA", "alternativas": ["GIRAFA", "JIRAFA", "GIRRAFA", "JIRRAFA"]},
		{"pergunta": "Marque a opção com a escrita certa:", "correta": "CARRO", "alternativas": ["CARRO", "CARO", "CAHRO", "CARRU"]},
		{"pergunta": "Qual palavra está escrita de forma CORRETA?", "correta": "QUEIJO", "alternativas": ["QUEIJO", "CUEIJO", "KAIJO", "QUEJO"]},
		{"pergunta": "Como se escreve corretamente?", "correta": "TOMATE", "alternativas": ["TOMATE", "TUMATE", "TOMATI", "TUMATI"]},
		{"pergunta": "Encontre a palavra escrita CORRETAMENTE:", "correta": "CACHORRO", "alternativas": ["CACHORRO", "CAXORRO", "CACORRO", "CACHORO"]},
		{"pergunta": "Qual é a grafia correta da fruta?", "correta": "BANANA", "alternativas": ["BANANA", "BANNANA", "BANANNA", "BANNA"]},
		{"pergunta": "Qual palavra está escrita da forma certa?", "correta": "HOJE", "alternativas": ["HOJE", "OJE", "HOGE", "OGE"]},
		{"pergunta": "Qual a forma correta de escrever?", "correta": "PASSARINHO", "alternativas": ["PASSARINHO", "PACARINHO", "PASARINHO", "PASARINO"]},
		{"pergunta": "Marque a palavra escrita CORRETAMENTE:", "correta": "FELIZ", "alternativas": ["FELIZ", "FELIS", "PHELIZ", "FELISSE"]},
		{"pergunta": "Qual é a escrita correta?", "correta": "CHAVE", "alternativas": ["CHAVE", "XAVE", "CHAVI", "XAVI"]},
		{"pergunta": "Encontre a palavra com a ortografia certa:", "correta": "ESCOLA", "alternativas": ["ESCOLA", "EZCOLA", "ISCOLA", "EXCOLA"]},
		{"pergunta": "Qual palavra está escrita de forma CORRETA?", "correta": "PEIXE", "alternativas": ["PEIXE", "PEICHE", "PEXE", "PEIHE"]},
		{"pergunta": "Qual a grafia correta de onde moramos?", "correta": "BRASIL", "alternativas": ["BRASIL", "BRAZIL", "BRAZYL", "BRASYL"]},
		{"pergunta": "Marque a opção escrita corretamente:", "correta": "TESOURA", "alternativas": ["TESOURA", "TEZOURA", "TISOURA", "TEZURA"]},
		{"pergunta": "Qual palavra está escrita de forma CORRETA?", "correta": "MENINO", "alternativas": ["MENINO", "MININO", "MENINU", "MININU"]},
		{"pergunta": "Como se escreve o brinquedo de voar?", "correta": "PIPA", "alternativas": ["PIPA", "PEPA", "PIBA", "PIBBA"]},
		{"pergunta": "Qual a ortografia correta?", "correta": "ÁRVORE", "alternativas": ["ÁRVORE", "ARVORI", "ALVORE", "ALVORI"]},
		{"pergunta": "Marque a opção que está correta:", "correta": "JANELA", "alternativas": ["JANELA", "GANELA", "JANNELA", "XANELA"]},
		{"pergunta": "Qual palavra está escrita de forma CORRETA?", "correta": "BORBOLETA", "alternativas": ["BORBOLETA", "BURBOLETA", "BORBOLLTA", "BOBOLETA"]},
		{"pergunta": "Como se escreve corretamente?", "correta": "SAPATO", "alternativas": ["SAPATO", "ZAPATO", "SAPATU", "ZAPATU"]}
	]

	banco[types.generos] = [
		{"pergunta": "Um texto curto usado para deixar um recado para alguém é um...", "correta": "Bilhete", "alternativas": ["Bilhete", "Poema", "Receita", "Dicionário"]},
		{"pergunta": "Textos que contam histórias com balões de fala e desenhos são:", "correta": "Histórias em Quadrinhos", "alternativas": ["Histórias em Quadrinhos", "Listas", "Contos", "Poemas"]},
		{"pergunta": "Um texto que ensina a fazer uma comida gostosa com ingredientes é uma...", "correta": "Receita", "alternativas": ["Receita", "Lista", "Carta", "Notícia"]},
		{"pergunta": "Textos organizados em estrofes e rimas que tocam nossos sentimentos são:", "correta": "Poemas", "alternativas": ["Poemas", "Listas", "Regulamentos", "Bulas"]},
		{"pergunta": "Um convite serve para:", "correta": "Chamar para uma festa", "alternativas": ["Chamar para uma festa", "Ensinar uma piada", "Vender um produto", "Contar uma fofoca"]},
		{"pergunta": "O texto enviado pelos correios dentro de um envelope para um amigo distante é uma:", "correta": "Carta", "alternativas": ["Carta", "Receita", "Dicionário", "Bula"]},
		{"pergunta": "Uma lista serve principalmente para:", "correta": "Organizar itens ou compras", "alternativas": ["Organizar itens ou compras", "Cantar", "Contar uma piada", "Dar um susto"]},
		{"pergunta": "Textos nos jornais que contam fatos reais que aconteceram no mundo são:", "correta": "Notícias", "alternativas": ["Notícias", "Poemas", "Contos de fadas", "Advinhas"]},
		{"pergunta": "O gênero textual que começa com 'Era uma vez...' e tem reis e fadas é o:", "correta": "Conto de Fadas", "alternativas": ["Conto de Fadas", "Bilhete", "Lista de compras", "Dicionário"]},
		{"pergunta": "As regras de um jogo servem para:", "correta": "Ensinar como se joga", "alternativas": ["Ensinar como se joga", "Rimar palavras", "Fazer uma comida", "Mandar um recado"]},
		{"pergunta": "Um texto curto que tenta nos convencer a comprar um brinquedo é um:", "correta": "Anúncio Publicitário", "alternativas": ["Anúncio Publicitário", "Poema", "Dicionário", "Conto"]},
		{"pergunta": "Onde encontramos o significado de várias palavras organizadas de A a Z?", "correta": "No Dicionário", "alternativas": ["No Dicionário", "Na Receita", "No Gibi", "No Bilhete"]},
		{"pergunta": "Textos rimados usados em brincadeiras de roda ou para rimar em parlendas são:", "correta": "Cantigas", "alternativas": ["Cantigas", "Bulas de remédio", "Notícias", "Listas"]},
		{"pergunta": "Um cartão de aniversário é um exemplo de gênero:", "correta": "Convite / Mensagem", "alternativas": ["Convite / Mensagem", "Receita médica", "Dicionário", "Notícia"]},
		{"pergunta": "Qual texto vem junto com o remédio para explicar como tomá-lo?", "correta": "Bula", "alternativas": ["Bula", "Poema", "Bilhete", "Carta"]},
		{"pergunta": "Textos curtos e engraçados que servem para fazer rir são chamados de:", "correta": "Piadas", "alternativas": ["Piadas", "Notícias", "Bulas", "Listas"]},
		{"pergunta": "Um diário serve para:", "correta": "Escrever sobre o próprio dia", "alternativas": ["Escrever sobre o próprio dia", "Fazer uma torta", "Vender um carro", "Convidar para o casamento"]},
		{"pergunta": "O texto de uma música que cantamos na escola é uma:", "correta": "Letra de Canção", "alternativas": ["Letra de Canção", "Bula", "Lista", "Notícia"]},
		{"pergunta": "Um cartaz na parede da escola avisando sobre a vacinação é um:", "correta": "Informativo / Comunicado", "alternativas": ["Informativo / Comunicado", "Conto de fadas", "Poema", "Bilhete"]},
		{"pergunta": "Textos que começam com 'O que é, o que é?' são chamados de:", "correta": "Adivinhas", "alternativas": ["Adivinhas", "Cartas", "Receitas", "Notícias"]},
		{"pergunta": "Uma fábula é uma história curta que geralmente tem:", "correta": "Animais que falam", "alternativas": ["Animais que falam", "Apenas números", "Gráficos de matemática", "Receitas de bolo"]},
		{"pergunta": "O manual de instruções de um brinquedo serve para:", "correta": "Ensinar a montar ou usar", "alternativas": ["Ensinar a montar ou usar", "Contar uma piada", "Fazer rimas", "Mandar uma carta"]}
	]

	banco[types.maiuscula_minus] = [
		{"pergunta": "Qual palavra deve SEMPRE começar com letra maiúscula?", "correta": "Brasil", "alternativas": ["Brasil", "Cachorro", "Abacaxi", "Caneta"]},
		{"pergunta": "Nomes de pessoas devem começar com qual tipo de letra?", "correta": "Maiúscula", "alternativas": ["Maiúscula", "Minúscula", "Tanto faz", "Nenhuma"]},
		{"pergunta": "Qual palavra deve ter letra maiúscula por ser um nome próprio?", "correta": "Mariana", "alternativas": ["Mariana", "gato", "mesa", "janela"]},
		{"pergunta": "No início de qualquer frase, usamos letra:", "correta": "Maiúscula", "alternativas": ["Maiúscula", "Minúscula", "Inclinada", "Pequena"]},
		{"pergunta": "Qual das opções está escrita corretamente seguindo as regras?", "correta": "O gato sumiu.", "alternativas": ["O gato sumiu.", "o gato sumiu.", "O Gato Sumiu.", "o Gato Sumiu."]},
		{"pergunta": "Nomes de cidades, como 'São Paulo', começam com letra:", "correta": "Maiúscula", "alternativas": ["Maiúscula", "Minúscula", "Colorida", "Símbolo"]},
		{"pergunta": "Qual palavra abaixo NÃO precisa começar com maiúscula no meio da frase?", "correta": "cadeira", "alternativas": ["cadeira", "Pedro", "Rio de Janeiro", "Argentina"]},
		{"pergunta": "Como se escreve o nome do nosso planeta?", "correta": "Terra", "alternativas": ["Terra", "terra", "TERra", "teRRa"]},
		{"pergunta": "Se eu escrever o nome do meu cachorro, a primeira letra deve ser:", "correta": "Maiúscula", "alternativas": ["Maiúscula", "Minúscula", "Um número", "Um desenho"]},
		{"pergunta": "Qual opção mostra o uso correto na frase?", "correta": "A menina estuda.", "alternativas": ["A menina estuda.", "a menina estuda.", "A Menina Estuda.", "a Menina Estuda."]},
		{"pergunta": "A letra maiúscula de 'a' é:", "correta": "A", "alternativas": ["A", "b", "B", "o"]},
		{"pergunta": "A letra minúscula de 'G' é:", "correta": "g", "alternativas": ["g", "j", "q", "p"]},
		{"pergunta": "Qual desses nomes de países está escrito de forma CORRETA?", "correta": "Japão", "alternativas": ["Japão", "japão", "JaPãO", "jApÃo"]},
		{"pergunta": "Nomes de lojas e supermercados começam com letra:", "correta": "Maiúscula", "alternativas": ["Maiúscula", "Minúscula", "Apagada", "Riscada"]},
		{"pergunta": "Qual palavra é um substantivo comum e usa letra minúscula?", "correta": "livro", "alternativas": ["livro", "Carlos", "Bahia", "Portugal"]},
		{"pergunta": "Qual é a letra maiúscula de 'm'?", "correta": "M", "alternativas": ["M", "W", "N", "n"]},
		{"pergunta": "Qual é a letra minúscula de 'R'?", "correta": "r", "alternativas": ["r", "s", "p", "v"]},
		{"pergunta": "Em 'fui ao parque com o Lucas.', qual palavra deveria ter maiúscula?", "correta": "Lucas e Fui", "alternativas": ["Lucas e Fui", "parque", "com", "ao"]},
		{"pergunta": "Os dias da semana (ex: segunda-feira) geralmente se escrevem com inicial:", "correta": "Minúscula", "alternativas": ["Minúscula", "Maiúscula", "Símbolo", "Número"]},
		{"pergunta": "Qual palavra é um nome de pessoa?", "correta": "Rafael", "alternativas": ["Rafael", "rato", "raposa", "rio"]},
		{"pergunta": "A letra maiúscula de 'e' é:", "correta": "E", "alternativas": ["E", "F", "3", "I"]}
	]

	banco[types.pontuacao] = [
		{"pergunta": "Qual sinal usamos para fazer uma PERGUNTA?", "correta": "?", "alternativas": ["?", "!", ".", ","]},
		{"pergunta": "Qual sinal indica uma surpresa ou espanto 'Que dia lindo_'", "correta": "!", "alternativas": ["!", "?", ".", ";"]},
		{"pergunta": "Qual ponto usamos para terminar uma frase simples (ponto final)?", "correta": ".", "alternativas": [".", "?", "!", ","]},
		{"pergunta": "Na frase 'Eu gosto de bolo_ sorvete e doce.', qual sinal falta no espaço?", "correta": ",", "alternativas": [",", "?", "!", "."]},
		{"pergunta": "Qual sinal usamos quando estamos muito felizes e gritamos 'Viva_'", "correta": "!", "alternativas": ["!", "?", ".", ","]},
		{"pergunta": "Qual é o nome do ponto '?' ?", "correta": "Ponto de Interrogação", "alternativas": ["Ponto de Interrogação", "Ponto de Exclamação", "Ponto Final", "Vírgula"]},
		{"pergunta": "Qual é o nome do ponto '!' ?", "correta": "Ponto de Exclamação", "alternativas": ["Ponto de Exclamação", "Ponto de Interrogação", "Ponto Final", "Dois Pontos"]},
		{"pergunta": "Para que serve a vírgula ( , ) ?", "correta": "Dar uma pequena pausa", "alternativas": ["Dar uma pequena pausa", "Fazer uma pergunta", "Gritar", "Terminar a história"]},
		{"pergunta": "Qual sinal usamos na frase 'Onde você mora_'", "correta": "?", "alternativas": ["?", "!", ".", ","]},
		{"pergunta": "Qual sinal usamos na frase 'O cachorro é bonito_'", "correta": ".", "alternativas": [".", "?", "!", ","]},
		{"pergunta": "Que ponto indica que alguém vai falar em uma história em quadrinhos?", "correta": "Balão de fala", "alternativas": ["Balão de fala", "Ponto Final", "Vírgula", "Ponto de Interrogação"]},
		{"pergunta": "Qual sinal indica uma lista, como em 'Comprei: maçã, uva...'", "correta": "Dois Pontos", "alternativas": ["Dois Pontos", "Ponto Final", "Ponto de Interrogação", "Ponto de Exclamação"]},
		{"pergunta": "Qual sinal de pontuação usamos para dar um susto: 'Bu_'", "correta": "!", "alternativas": ["!", "?", ".", ","]},
		{"pergunta": "Que sinal de pontuação é este ( . ) ?", "correta": "Ponto Final", "alternativas": ["Ponto Final", "Vírgula", "Travessão", "Parênteses"]},
		{"pergunta": "Qual frase está pontuada corretamente para uma PERGUNTA?", "correta": "Você quer brincar?", "alternativas": ["Você quer brincar?", "Você quer brincar!", "Você quer brincar.", "Você quer brincar,"]},
		{"pergunta": "Qual frase demonstra ESPANTO ou SURPRESA?", "correta": "Que susto você me deu!", "alternativas": ["Que susto você me deu!", "Que susto você me deu?", "Que susto você me deu.", "Que susto você me deu,"]},
		{"pergunta": "O travessão ( — ) serve para quê em um texto?", "correta": "Mostrar a fala de um personagem", "alternativas": ["Mostrar a fala de um personagem", "Fazer uma pergunta", "Terminar o texto", "Separar compras"]},
		{"pergunta": "Qual ponto usamos para dar tchau no fim da carta?", "correta": ".", "alternativas": [".", "?", "!", "—"]},
		{"pergunta": "Na frase 'Que horas são_ ', qual ponto usamos?", "correta": "?", "alternativas": ["?", "!", ".", ","]},
		{"pergunta": "Para separar o nome da cidade e a data (Ex: Rio_ 10 de maio), usamos:", "correta": ",", "alternativas": [",", ".", "?", "!"]},
		{"pergunta": "Qual ponto usamos em 'Eu terminei a minha lição_'", "correta": ".", "alternativas": [".", "?", "!", ","]},
		{"pergunta": "Se estou em dúvida, que ponto combina mais?", "correta": "?", "alternativas": ["?", "!", ".", ","]}
	]
	

	banco[types.acentos] = [
		{"pergunta": "Qual palavra precisa do acento circunflexo (^)?", "correta": "Vovô", "alternativas": ["Vovô", "Café", "Pé", "Água"]},
		{"pergunta": "Qual palavra usa o acento agudo (´) na letra A?", "correta": "Água", "alternativas": ["Água", "Cama", "Mala", "Casa"]},
		{"pergunta": "Qual palavra tem o som do 'vovó' (aberto, com acento agudo)?", "correta": "Café", "alternativas": ["Café", "Você", "Bênção", "Ônibus"]},
		{"pergunta": "O sinal do tio (~) serve para deixar o som:", "correta": "Nasal (pelo nariz)", "alternativas": ["Nasal (pelo nariz)", "Muito forte", "Fraco", "Mudo"]},
		{"pergunta": "Qual palavra precisa do acento do tio (~)?", "correta": "Avião", "alternativas": ["Avião", "Bola", "Dado", "Pato"]},
		{"pergunta": "Qual palavra usa o acento circunflexo (^) na letra O?", "correta": "Ônibus", "alternativas": ["Ônibus", "Óculos", "Copo", "Porta"]},
		{"pergunta": "Qual palavra precisa de acento agudo (´)?", "correta": "Picolé", "alternativas": ["Picolé", "Menino", "Mesa", "Caderno"]},
		{"pergunta": "Qual é o acento da palavra 'VOCÊ'?", "correta": "Circunflexo (^)", "alternativas": ["Circunflexo (^)", "Agudo (´)", "Tio (~)", "Nenhum"]},
		{"pergunta": "Qual palavra tem o sinal do Tio (~)?", "correta": "Maçã", "alternativas": ["Maçã", "Pé", "Vovô", "Gato"]},
		{"pergunta": "Qual palavra precisa de acento na letra U?", "correta": "Baú", "alternativas": ["Baú", "Uva", "Urubu", "Um"]},
		{"pergunta": "O acento agudo (´) deixa o som da vogal:", "correta": "Aberto", "alternativas": ["Aberto", "Fechado", "Nasal", "Sumiu"]},
		{"pergunta": "O acento circunflexo (^) deixa o som da vogal:", "correta": "Fechado", "alternativas": ["Fechado", "Aberto", "Longo", "Mudo"]},
		{"pergunta": "Qual palavra está acentuada CORRETAMENTE?", "correta": "Árvore", "alternativas": ["Árvore", "Arvorê", "Arvôre", "Arvore"]},
		{"pergunta": "Qual palavra precisa de acento agudo (´) na letra O?", "correta": "Óculos", "alternativas": ["Óculos", "Vovô", "Bolo", "Ovo"]},
		{"pergunta": "Qual palavra tem o acento do tio (~)?", "correta": "Sabão", "alternativas": ["Sabão", "Sopa", "Sapato", "Sino"]},
		{"pergunta": "Qual palavra precisa de acento na letra E?", "correta": "Jacaré", "alternativas": ["Jacaré", "Escola", "Estojo", "Elefante"]},
		{"pergunta": "Qual palavra usa o acento circunflexo (^)?", "correta": "Três", "alternativas": ["Três", "Pé", "Chá", "Lá"]},
		{"pergunta": "Qual palavra leva acento agudo (´) na letra I?", "correta": "Lápis", "alternativas": ["Lápis", "Livro", "Igreja", "Ilha"]},
		{"pergunta": "Qual o acento correto para a palavra 'PÁSSARO'?", "correta": "Agudo (´)", "alternativas": ["Agudo (´)", "Circunflexo (^)", "Tio (~)", "Nenhum"]},
		{"pergunta": "Qual palavra NÃO tem nenhum acento?", "correta": "Copo", "alternativas": ["Copo", "Café", "Vovô", "Maçã"]},
		{"pergunta": "Qual palavra precisa do tio (~) no A?", "correta": "Mão", "alternativas": ["Mão", "Mala", "Mapa", "Mesa"]}
	]

	banco[types.singular_plural] = [
		{"pergunta": "Qual é o plural da palavra 'CANETA'?", "correta": "Canetas", "alternativas": ["Canetas", "Canetões", "Caneta", "Canetases"]},
		{"pergunta": "Qual é o plural de 'GATO'?", "correta": "Gatos", "alternativas": ["Gatos", "Gatões", "Gato", "Gatases"]},
		{"pergunta": "Qual é o plural de 'FLOR'?", "correta": "Flores", "alternativas": ["Flores", "Flors", "Florezinhas", "Flor"]},
		{"pergunta": "Qual é o plural de 'CARRO'?", "correta": "Carros", "alternativas": ["Carros", "Carro", "Carrões", "Carris"]},
		{"pergunta": "Qual é o plural de 'BOLA'?", "correta": "Bolas", "alternativas": ["Bolas", "Boles", "Bolões", "Bola"]},
		{"pergunta": "Qual é o plural de 'CASA'?", "correta": "Casas", "alternativas": ["Casas", "Casões", "Casases", "Casa"]},
		{"pergunta": "Qual é o plural de 'ÁRVORE'?", "correta": "Árvores", "alternativas": ["Árvores", "Arvors", "Arvoreta", "Árvore"]},
		{"pergunta": "Qual é o plural de 'MENINO'?", "correta": "Meninos", "alternativas": ["Meninos", "Menino", "Meninões", "Meninis"]},
		{"pergunta": "Qual é o plural de 'PÃO'?", "correta": "Pães", "alternativas": ["Pães", "Pãos", "Pões", "Pãezinhos"]},
		{"pergunta": "Qual é o plural de 'CÃO'?", "correta": "Cães", "alternativas": ["Cães", "Cãos", "Cachorros", "Cões"]},
		{"pergunta": "Qual é o plural de 'ANIMAL'?", "correta": "Animais", "alternativas": ["Animais", "Animals", "Animau", "Animis"]},
		{"pergunta": "Qual é o plural de 'BALÃO'?", "correta": "Balões", "alternativas": ["Balões", "Balãos", "Balis", "Balon"]},
		{"pergunta": "Qual é o plural de 'PEIXE'?", "correta": "Peixes", "alternativas": ["Peixes", "Peixs", "Peixões", "Peixe"]},
		{"pergunta": "Qual é o plural de 'LUZ'?", "correta": "Luzes", "alternativas": ["Luzes", "Luzs", "Luzis", "Luz"]},
		{"pergunta": "Qual é o plural de 'JARDIM'?", "correta": "Jardins", "alternativas": ["Jardins", "Jardims", "Jardises", "Jardis"]},
		{"pergunta": "Qual é o plural de 'TREM'?", "correta": "Trens", "alternativas": ["Trens", "Trems", "Trenses", "Treis"]},
		{"pergunta": "Qual é o plural de 'PAPEL'?", "correta": "Papéis", "alternativas": ["Papéis", "Papels", "Papeis", "Paper"]},
		{"pergunta": "Qual é o plural de 'MAÇÃ'?", "correta": "Maçãs", "alternativas": ["Maçãs", "Maçã", "Maçanes", "Macas"]},
		{"pergunta": "Qual é o plural de 'SAPATO'?", "correta": "Sapatos", "alternativas": ["Sapatos", "Sapatoes", "Sapato", "Sapatis"]},
		{"pergunta": "Qual é o plural de 'CADERNO'?", "correta": "Cadernos", "alternativas": ["Cadernos", "Caderno", "Cadernis", "Cadernões"]},
		{"pergunta": "Qual é o plural de 'COLHER'?", "correta": "Colheres", "alternativas": ["Colheres", "Colhers", "Colher", "Colheris"]}
	]

	banco[types.genero_gramatical] = [
		{"pergunta": "Qual é o feminino da palavra 'CÃO'?", "correta": "Cadela", "alternativas": ["Cadela", "Gata", "Leoa", "Cão"]},
		{"pergunta": "Qual é o feminino de 'GATO'?", "correta": "Gata", "alternativas": ["Gata", "Rata", "Cadela", "Gato"]},
		{"pergunta": "Qual é o masculino de 'VACA'?", "correta": "Boi", "alternativas": ["Boi", "Cavalo", "Bode", "Vaco"]},
		{"pergunta": "Qual é o feminino de 'MENINO'?", "correta": "Menina", "alternativas": ["Menina", "Mulher", "Tia", "Mãe"]},
		{"pergunta": "Qual é o masculino de 'RAINHA'?", "correta": "Rei", "alternativas": ["Rei", "Príncipe", "Duque", "Rainho"]},
		{"pergunta": "Qual é o feminino de 'LEÃO'?", "correta": "Leoa", "alternativas": ["Leoa", "Tigresa", "Gata", "Loba"]},
		{"pergunta": "Qual é o masculino de 'GALINHA'?", "correta": "Galo", "alternativas": ["Galo", "Pinto", "Pato", "Galinho"]},
		{"pergunta": "Qual é o feminino de 'CAVALO'?", "correta": "Égua", "alternativas": ["Égua", "Éguo", "Cavala", "Zebra"]},
		{"pergunta": "Qual é o masculino de 'MÃE'?", "correta": "Papai / Pai", "alternativas": ["Papai / Pai", "Tio", "Vovô", "Irmão"]},
		{"pergunta": "Qual é o feminino de 'BODE'?", "correta": "Cabra", "alternativas": ["Cabra", "Ovelha", "Vaca", "Boda"]},
		{"pergunta": "Qual é o masculino de 'PRINCESA'?", "correta": "Príncipe", "alternativas": ["Príncipe", "Rei", "Duque", "Princeso"]},
		{"pergunta": "Qual é o feminino de 'URSO'?", "correta": "Ursa", "alternativas": ["Ursa", "Urso", "Urse", "Loba"]},
		{"pergunta": "Qual é o masculino de 'TITIA'?", "correta": "Tio", "alternativas": ["Tio", "Pai", "Vovô", "Irmão"]},
		{"pergunta": "Qual é o feminino de 'PATO'?", "correta": "Pata", "alternativas": ["Pata", "Galinha", "Gansa", "Pato"]},
		{"pergunta": "Qual é o masculino de 'IRMÃ'?", "correta": "Irmão", "alternativas": ["Irmão", "Primo", "Amigo", "Irmã"]},
		{"pergunta": "Qual é o feminino de 'LOBO'?", "correta": "Loba", "alternativas": ["Loba", "Raposa", "Cadela", "Ursa"]},
		{"pergunta": "Qual é o masculino de 'AVÓ'?", "correta": "Avô", "alternativas": ["Avô", "Pai", "Tio", "Primo"]},
		{"pergunta": "Qual é o feminino de 'MACACO'?", "correta": "Macaca", "alternativas": ["Macaca", "Macaquinho", "Gata", "Gorila"]},
		{"pergunta": "Qual é o masculino de 'DIRETORA'?", "correta": "Diretor", "alternativas": ["Diretor", "Professor", "Aluno", "Diretoro"]},
		{"pergunta": "Qual é o feminino de 'CANTOR'?", "correta": "Cantora", "alternativas": ["Cantora", "Atriz", "Música", "Cantores"]},
		{"pergunta": "Qual é o masculino de 'LEBRE'?", "correta": "Coelho", "alternativas": ["Coelho", "Rato", "Lebro", "Sapo"]}
	]
	

	banco[types.verbos] = [
		{"pergunta": "Na frase 'O menino correu na pista', qual palavra é o VERBO?", "correta": "correu", "alternativas": ["correu", "O", "menino", "pista"]},
		{"pergunta": "Na frase 'O passarinho voa alto', qual palavra é uma ação (VERBO)?", "correta": "voa", "alternativas": ["voa", "O", "passarinho", "alto"]},
		{"pergunta": "Qual das palavras abaixo indica uma ação (VERBO)?", "correta": "Pular", "alternativas": ["Pular", "Célula", "Bonito", "Célia"]},
		{"pergunta": "Na frase 'Eu comi um bolo gostoso', qual é o VERBO?", "correta": "comi", "alternativas": ["comi", "Eu", "bolo", "gostoso"]},
		{"pergunta": "Se eu digo 'Nós vamos jogar futebol', qual é a ação principal?", "correta": "jogar", "alternativas": ["jogar", "futebol", "Nós", "vamos"]},
		{"pergunta": "Na frase 'A menina estuda muito', qual palavra é o VERBO?", "correta": "estuda", "alternativas": ["estuda", "A", "menina", "muito"]},
		{"pergunta": "Qual palavra abaixo NÃO é um verbo?", "correta": "caneta", "alternativas": ["caneta", "correr", "nadar", "sorrir"]},
		{"pergunta": "Na frase 'O bebê dormiu no berço', qual palavra é a ação?", "correta": "dormiu", "alternativas": ["dormiu", "bebê", "no", "berço"]},
		{"pergunta": "Escolha o VERBO que completa: 'O peixe ___ na lagoa.'", "correta": "nada", "alternativas": ["nada", "voa", "anda", "fala"]},
		{"pergunta": "Na frase 'Mamãe canta uma música bonita', qual palavra é o VERBO?", "correta": "canta", "alternativas": ["canta", "Mamãe", "música", "bonita"]},
		{"pergunta": "Qual palavra indica o que fazemos com um livro?", "correta": "Ler", "alternativas": ["Ler", "Comer", "Chutar", "Dormir"]},
		{"pergunta": "Na frase 'O carro parou no sinal', qual palavra é o VERBO?", "correta": "parou", "alternativas": ["parou", "O", "carro", "sinal"]},
		{"pergunta": "Qual verbo completa: 'Eu ___ água quando tenho sede.'", "correta": "bebo", "alternativas": ["bebo", "como", "corro", "olho"]},
		{"pergunta": "Na frase 'O palhaço caiu e sorriu', quais são as ações (VERBOS)?", "correta": "caiu e sorriu", "alternativas": ["caiu e sorriu", "O palhaço", "palhaço", "e"]},
		{"pergunta": "Qual palavra representa a ação de fazer desenhos com lápis?", "correta": "Desenhar", "alternativas": ["Desenhar", "Papel", "Lápis", "Borracha"]},
		{"pergunta": "Na frase 'O sapo pulou na lama', qual palavra é o VERBO?", "correta": "pulou", "alternativas": ["pulou", "O", "sapo", "lama"]},
		{"pergunta": "Qual verbo usamos para expressar o som de rir alto?", "correta": "Gargalhar", "alternativas": ["Gargalhar", "Chorar", "Pensar", "Andar"]},
		{"pergunta": "Na frase 'Nós escrevemos uma carta', qual palavra é o VERBO?", "correta": "escrevemos", "alternativas": ["escrevemos", "Nós", "uma", "carta"]},
		{"pergunta": "Qual verbo completa: 'A professora ___ a lição no quadro.'", "correta": "escreve", "alternativas": ["escreve", "pula", "bebe", "canta"]},
		{"pergunta": "Na frase 'Eu gosto de sorvete', qual palavra é o VERBO?", "correta": "gosto", "alternativas": ["gosto", "Eu", "sorvete", "de"]},
		{"pergunta": "Qual das palavras abaixo é um VERBO?", "correta": "Dançar", "alternativas": ["Dançar", "Sapato", "Música", "Lindo"]}
	]
	
	banco[types.substantivos] = [
		{"pergunta": "Qual das palavras abaixo representa um SUBSTANTIVO (nome de objeto)?", "correta": "Mesa", "alternativas": ["Mesa", "Pular", "Bonito", "Ontem"]},
		{"pergunta": "Qual palavra abaixo é o nome de um ANIMAL (substantivo)?", "correta": "Cachorro", "alternativas": ["Cachorro", "Correr", "Azul", "Rápido"]},
		{"pergunta": "Qual palavra abaixo é um nome de PESSOA (substantivo próprio)?", "correta": "Lucas", "alternativas": ["Lucas", "Menino", "Brincar", "Alto"]},
		{"pergunta": "Substantivos servem para:", "correta": "Dar nome às coisas", "alternativas": ["Dar nome às coisas", "Indicar uma ação", "Mostrar uma qualidade", "Indicar o tempo"]},
		{"pergunta": "Qual das palavras é um substantivo que representa um LUGAR?", "correta": "Escola", "alternativas": ["Escola", "Estudar", "Grande", "Lá"]},
		{"pergunta": "Qual palavra abaixo é um SUBSTANTIVO (nome de fruta)?", "correta": "Banana", "alternativas": ["Banana", "Comer", "Amarela", "Doce"]},
		{"pergunta": "Encontre o SUBSTANTIVO na frase: 'A boneca é nova.'", "correta": "boneca", "alternativas": ["boneca", "A", "é", "nova"]},
		{"pergunta": "Qual palavra é um substantivo que usamos na escola para escrever?", "correta": "Lápis", "alternativas": ["Lápis", "Escrever", "Apagar", "Macio"]},
		{"pergunta": "Qual dessas palavras NÃO é um substantivo?", "correta": "Feliz", "alternativas": ["Feliz", "Cadeiras", "Gato", "Porta"]},
		{"pergunta": "Qual palavra é um substantivo que brilha no céu de dia?", "correta": "Sol", "alternativas": ["Sol", "Brilhar", "Quente", "Longe"]},
		{"pergunta": "Na frase 'O carro correu muito', qual palavra é o substantivo?", "correta": "carro", "alternativas": ["carro", "correu", "O", "muito"]},
		{"pergunta": "Qual das palavras abaixo é o nome de um sentimento (substantivo abstrato)?", "correta": "Amor", "alternativas": ["Amor", "Amar", "Lindo", "Amanhã"]},
		{"pergunta": "Qual palavra é o nome de algo que usamos para cobrir a cabeça?", "correta": "Boné", "alternativas": ["Boné", "Usar", "Cabeça", "Azul"]},
		{"pergunta": "Identifique o substantivo próprio (nome de país):", "correta": "Portugal", "alternativas": ["Portugal", "País", "Viajar", "Longe"]},
		{"pergunta": "Qual palavra abaixo é um nome de uma flor?", "correta": "Rosa", "alternativas": ["Rosa", "Cheirosa", "Plantar", "Jardim"]},
		{"pergunta": "Encontre o substantivo: 'O relógio quebrou.'", "correta": "relógio", "alternativas": ["relógio", "O", "quebrou", "ontem"]},
		{"pergunta": "Qual palavra representa uma parte do corpo humano?", "correta": "Mão", "alternativas": ["Mão", "Bater", "Limpa", "Cinco"]},
		{"pergunta": "Qual dessas palavras é o nome de um brinquedo?", "correta": "Bola", "alternativas": ["Bola", "Chutar", "Redonda", "Rápido"]},
		{"pergunta": "Na frase 'A casa é grande', qual palavra dá nome ao lugar?", "correta": "casa", "alternativas": ["casa", "grande", "A", "is"]},
		{"pergunta": "Qual palavra é o nome de um meio de transporte que voa?", "correta": "Avião", "alternativas": ["Avião", "Voar", "Nuvem", "Rápido"]},
		{"pergunta": "Qual palavra é um substantivo comum?", "correta": "Janela", "alternativas": ["Janela", "Abrir", "Transparente", "Muito"]}
	]
	
	banco[types.analise_ling] = [
		{"pergunta": "'O cachorro latiu.' Isso é uma:", "correta": "Frase", "alternativas": ["Frase", "Palavra", "Letra", "Sílaba"]},
		{"pergunta": "A letra 'B' sozinha é o quê?", "correta": "Uma letra", "alternativas": ["Uma letra", "Uma palavra", "Uma frase", "Um texto"]},
		{"pergunta": "O conjunto de palavras que passa uma mensagem com sentido completo é uma:", "correta": "Frase", "alternativas": ["Frase", "Letra", "Sílaba", "Vogal"]},
		{"pergunta": "A palavra 'BOLA' é formada por quantas LETRAS?", "correta": "4", "alternativas": ["4", "2", "3", "5"]},
		{"pergunta": "Várias frases juntas contando uma história maior formam um...", "correta": "Texto", "alternativas": ["Texto", "Sílaba", "Letra", "Alfabeto"]},
		{"pergunta": "Quantas PALAVRAS existem na frase: 'O gato miou.'?", "correta": "3", "alternativas": ["3", "2", "4", "1"]},
		{"pergunta": "O que se forma quando juntamos letras para dar nome a algo?", "correta": "Uma palavra", "alternativas": ["Uma palavra", "Uma frase", "Um ponto", "Um texto"]},
		{"pergunta": "Quantas FRASES tem este pequeno texto: 'O Sol brilha. O dia está lindo.'?", "correta": "2", "alternativas": ["2", "1", "3", "4"]},
		{"pergunta": "A palavra 'PIPOCA' tem quantas sílabas?", "correta": "3", "alternativas": ["3", "6", "2", "4"]},
		{"pergunta": "Quantas PALAVRAS existem na frase 'Eu gosto de estudar muito'?", "correta": "5", "alternativas": ["5", "4", "6", "3"]},
		{"pergunta": "O nosso alfabeto é formado por um conjunto de:", "correta": "Letras", "alternativas": ["Letras", "Frases", "Textos", "Números"]},
		{"pergunta": "Qual das opções abaixo é apenas UMA PALAVRA?", "correta": "Cachorro", "alternativas": ["Cachorro", "O cachorro correu.", "C", "A+B"]},
		{"pergunta": "As letras A, E, I, O, U são chamadas de:", "correta": "Vogais", "alternativas": ["Vogais", "Consoantes", "Frases", "Sílabas"]},
		{"pergunta": "As letras B, C, D, F... são chamadas de:", "correta": "Consoantes", "alternativas": ["Consoantes", "Vogais", "Palavras", "Frases"]},
		{"pergunta": "Para ler um livro de histórias, nós lemos um...", "correta": "Texto", "alternativas": ["Texto", "Sílaba apenas", "Letra solta", "Sinal de trânsito"]},
		{"pergunta": "Quantas PALAVRAS tem a frase: 'Parabéns!'?", "correta": "1", "alternativas": ["1", "2", "0", "3"]},
		{"pergunta": "O que indica onde termina uma frase escrita?", "correta": "O ponto final", "alternativas": ["O ponto final", "A primeira letra", "O espaço", "A vírgula"]},
		{"pergunta": "Quantas LETRAS tem a palavra 'SOL'?", "correta": "3", "alternativas": ["3", "1", "2", "4"]},
		{"pergunta": "O que usamos entre uma palavra e outra para elas não ficarem grudadas?", "correta": "Espaço em branco", "alternativas": ["Espaço em branco", "Um traço", "Uma letra", "Um número"]},
		{"pergunta": "Qual das alternativas é uma FRASE completa?", "correta": "A menina comeu maçã.", "alternativas": ["A menina comeu maçã.", "Menina maçã", "M", "De comer"]},
		{"pergunta": "Quantas letras tem o alfabeto completo da Língua Portuguesa?", "correta": "26", "alternativas": ["26", "23", "20", "30"]}
	]
	
	return banco

func check_if_correct(label):
	var is_correct = false

	if str(label.text) == str(resultado_final):
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
		
		# Define o assunto do erro baseado na categoria atual
		var current_subject = "Português"
		wrong_instance.current_exercise = current_subject
		add_child(wrong_instance)

func _on_Button_pressed(): check_if_correct($Button)
func _on_Button2_pressed(): check_if_correct($Button2)
func _on_Button3_pressed(): check_if_correct($Button3)
func _on_Button4_pressed(): check_if_correct($Button4)
