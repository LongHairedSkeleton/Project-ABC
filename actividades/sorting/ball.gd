extends drag_queen

func _exit_tree():
	# If this specific ball was being dragged when it died, unlock the parent
	if is_dragging:
		get_parent().is_any_item_dragging = false
