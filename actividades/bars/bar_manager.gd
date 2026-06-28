extends HBoxContainer

var bar1 = 0
var bar2 = 0
var bar3 = 0
var bar4 = 0

var rng = [0,1,2,3,4,5,6,7,8,9,10]

var bar = preload("res://actividades/bars/bar.tscn")

var loops = 0

func _ready():
	randomize()
	roll()

	connect("check", self, "bar_check")

var biggest = 0
var smallest = 0

var correct = 0

func roll():
	for child in get_children():
		child.queue_free()
	
	var loops = 4
	var bar_counts = [] 
	var created_bars = [] 
	
	randomize() 

	for i in range(loops):
		var bar_instance = bar.instance() # Godot 3 syntax
		add_child(bar_instance)
		created_bars.append(bar_instance)
		bar_instance.connect("check", self, "bar_check")

	for child in created_bars:
		child.less(rand_range(1, 9)) # Godot 3 syntax
		
		yield(get_tree().create_timer(0.1), "timeout")
		var count = child.get_child_count()
		bar_counts.append(count)

	biggest = bar_counts.max()
	smallest = bar_counts.min()
	
	correct = [smallest, biggest].pick_random()
	
	if correct == smallest:
		$"../../Label2".text = "selecione o menor número"
	else:
		$"../../Label2".text = "selecione o maior número"

func bar_check(children, obj):
	if children == correct:
		print("win")
	else:
		print("lose")
	roll()
