extends Node2D

var doubleClickTimer = Timer.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#TODO make escape menu
	#gets the escape key button press and quits the game
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

#ITEMLIST TESTING------------------------------------------------------------------------------------------

#gets popup context menu
func _on_item_list_empty_clicked(at_position: Vector2, mouse_button_index: int) -> void:
	if mouse_button_index == MOUSE_BUTTON_RIGHT:
		#Sets the popup menu to the mouse position and makes it visible, also deselects the current item
		$PopupMenu.position = get_global_mouse_position()#(at_position + Vector2(192,244))
		$PopupMenu.visible = true
		$VSeparator/PlayerEnvironment/VBoxContainer/ItemList.deselect_all()
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		#Deselect current item
		$VSeparator/PlayerEnvironment/VBoxContainer/ItemList.deselect_all()


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index == MOUSE_BUTTON_RIGHT:
		#Sets the popup menu to the mouse position and makes it visible
		$PopupMenu.position = get_global_mouse_position()#(at_position + Vector2(192,244))
		$PopupMenu.visible = true
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		pass
	

#TODO
#On a double click, check if a file or a folder. Files do nothing, while folders will
#replace current Itemlist (making it invisible) with a new item list of the folder's contents.
#PLAN-----------------------------------------------------------------------------------------------------
#Each folder is it's own ItemList, with files being it's items.
#PLAN-----------------------------------------------------------------------------------------------------
func _on_item_list_item_activated(index):
	pass
