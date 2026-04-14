extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#TODO make escape menu
	#gets the escape key button press and quits the game
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


#gets popup context menu
func _on_item_list_empty_clicked(at_position: Vector2, mouse_button_index: int) -> void:
	if mouse_button_index == 2:
		$VSeparator/PlayerEnvironment/PopupMenu.position = (at_position + Vector2(192,108))
		$VSeparator/PlayerEnvironment/PopupMenu.visible = true
	if mouse_button_index == 1:
		pass
