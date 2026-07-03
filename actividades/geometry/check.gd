extends Control

func check_remaining():
	if $"%spawner".get_child_count() == 5:
		yield(get_tree().create_timer(1),"timeout")
		emit_signal("task_completed")

