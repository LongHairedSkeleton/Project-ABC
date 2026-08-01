extends Node

#this is the player save btw, not the singleton "Save", it is this script that saves player name, points, occupation, etc.



var save_path = "user://player_data.json"

var player_data = {
	"first_time": true,
	"player_name": "",
	"max_points": 0,
	"teacher": false
}

func _ready():
	load_game_data()

	if player_data["first_time"]:
		print("Primeira vez no app!")
		player_data["first_time"] = false
		save_game_data()
	else:
		print("Já entrou antes. Nome atual: ", player_data["player_name"])

func save_game_data():
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_line(to_json(player_data))
		file.close()
		print("saved")

func load_game_data():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var test_json = JSON.parse(file.get_line())
			file.close()
			
			if test_json.error == OK:
				player_data = test_json.result
				print("loaded")
