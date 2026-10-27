@tool
class_name ToDoBoard
extends Control

const BOARD_SCENE = preload("uid://ogwaajakj736")


func build_panels(todos: Dictionary[String, Array]) -> void:
	for child in get_children():
		child.queue_free()

	for tag in ToDoItem.get_all_tags():
		var panel_instance = TagPanel.create_new(ToDoItem.get_type(tag), todos)
		add_child(panel_instance)


static func create_new() -> ToDoBoard:
	var new_board := BOARD_SCENE.instantiate()
	return new_board
