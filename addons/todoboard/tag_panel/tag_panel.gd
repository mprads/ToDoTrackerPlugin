@tool
class_name TagPanel
extends Panel

const PANEL_SCENE = preload("uid://cpgr0qhbes0oo")

@onready var header_color: ColorRect = %HeaderColor
@onready var task_count: Label = %TaskCount
@onready var panel_tag: Label = %PanelTag
@onready var task_container: VBoxContainer = %TaskContainer

var panel_type: int : set = set_type
var todos: Dictionary[String, Array] = {} : set = set_todos 
var panel_todos: Array[ToDoItem] = []


func set_todos(value: Dictionary[String, Array]) -> void:
	if not is_node_ready():
		await ready

	todos = value
	var filtered_todos: Array[ToDoItem] = []

	for path in value:
		for todo: ToDoItem in value[path]:
			if todo.type == panel_type:
				filtered_todos.append(todo)

	panel_todos = filtered_todos

	if panel_todos.size():
		_create_cards()
		task_count.text = str(panel_todos.size())


func set_type(value: int) -> void:
	if not is_node_ready():
		await ready

	panel_type = value
	panel_tag.text = ToDoItem.get_tag(panel_type)
	header_color.color = Color(ToDoItem.get_color(panel_type))


func _create_cards() -> void:
	if not is_node_ready():
		await ready

	for child in task_container.get_children():
		child.queue_free()

	for todo: ToDoItem in panel_todos:
		var card_instance = Card.create_new(todo)
		task_container.add_child(card_instance)


static func create_new(type: int, new_todos: Dictionary[String, Array]) -> TagPanel:
	var new_panel := PANEL_SCENE.instantiate()
	new_panel.panel_type = type
	new_panel.todos = new_todos
	return new_panel
