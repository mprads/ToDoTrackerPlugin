@tool
class_name Card
extends Control

const CARD_SCENE = preload("uid://cjnnh0o10do25")

@onready var path_label: LinkButton = %PathLabel
@onready var body: Label = %Body

var todo_item: ToDoItem: set = set_item


func set_item(value: ToDoItem) -> void:
	if not is_node_ready():
		await ready

	todo_item = value
	path_label.text = value.script_path
	path_label.pressed.connect(_on_button_pressed)
	body.text = value.description


func _on_button_pressed() -> void:
	var editor := EditorInterface.get_script_editor()
	var base_editor := editor.get_current_editor()
	base_editor.emit_signal("request_open_script_at_line", load(todo_item.script_path), todo_item.line)


static func create_new(new_item: ToDoItem) -> Card:
	var new_card: Card = CARD_SCENE.instantiate()
	new_card.todo_item = new_item
	return new_card
