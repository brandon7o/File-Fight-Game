extends Node2D

#var doubleClickTimer = Timer.new()
@onready var player = $VSeparator/PlayerEnvironment/Player
@onready var folderID = 1
@onready var fileID = 0
@onready var addID = 0
@onready var deleteID = 1
@onready var propertiesID = 2
@onready var fileTexture
@onready var folderTexture
@onready var popupMenuPlayer = $VSeparator/PlayerEnvironment/VBoxContainer/FolderFileSpace/PopupMenu
@onready var AddPopup = $VSeparator/PlayerEnvironment/VBoxContainer/FolderFileSpace/PopupMenu/AddPopup
#TODO make function so that we know which "folder" we are currently in at all times
@onready var mainPlayerFolder = $VSeparator/PlayerEnvironment/VBoxContainer/FolderFileSpace/ItemList
@onready var mainPlayerSpace = $VSeparator/PlayerEnvironment/VBoxContainer/FolderFileSpace
@onready var currentFolder

#START HERE
#Add a way to sort the files/folders whenever one is added
#Add a way to drag files into folders
#Add a function to make the variable "currentFolder" know and recognise the current folder,
#replacing most variables of mainPlayerFolder/Space with this variable or close relatives
#Add a back button functionality that goes back one folder and is unselectable in mainPlayerFolder
#Add a way to differentiate from items in itemlist (this will be done by adding a lot of empty
#texture2D's with the correct file ID, giving them correct ID varibles as seen in the ready function

# Called when the node enters the scene tree for the first time.
func _ready():
	fileTexture = preload("res://Textures/IDs/fileTexture.tres")
	folderTexture = preload("res://Textures/IDs/folderTexture.tres")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#TODO make escape menu
	#gets the escape key button press and quits the game
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

#ITEMLIST TESTING------------------------------------------------------------------------------------------

#Function on when player clicks on the empty space in the ItemList
#TODO Differentiate from main folder to other folders
func _on_item_list_empty_clicked(at_position: Vector2, mouse_button_index: int) -> void:
	if mouse_button_index == MOUSE_BUTTON_RIGHT:
		#Sets the popup menu, moves it to the mouse position, and makes it visible. Also deselects the current item(s)
		popupMenuPlayer.clear()
		popupMenuPlayer.add_submenu_node_item("Add", AddPopup, addID)
		popupMenuPlayer.add_item("Properties", propertiesID)
		popupMenuPlayer.position = get_global_mouse_position()
		popupMenuPlayer.reset_size()
		popupMenuPlayer.visible = true
		mainPlayerFolder.deselect_all()
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		#Deselect current item(s)
		mainPlayerFolder.deselect_all()
		pass

#Function on when the player clicks some item
#TODO Differentiate from main folder to other folders
func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index == MOUSE_BUTTON_RIGHT:
		if mainPlayerFolder.get_item_icon(index) == fileTexture:
			#Sets the popup menu, moves it to the mouse position, and makes it visible
			popupMenuPlayer.clear()
			popupMenuPlayer.add_item("Delete", deleteID)
			popupMenuPlayer.add_item("Properties", propertiesID)
			popupMenuPlayer.position = get_global_mouse_position()
			popupMenuPlayer.reset_size()
			popupMenuPlayer.visible = true
			mainPlayerFolder.deselect_all()
			mainPlayerFolder.select(index)
		else:
			popupMenuPlayer.clear()
			popupMenuPlayer.add_item("Properties", propertiesID)
			popupMenuPlayer.position = get_global_mouse_position()
			popupMenuPlayer.reset_size()
			popupMenuPlayer.visible = true
			mainPlayerFolder.deselect_all()
			mainPlayerFolder.select(index)
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		pass
	

#TODO
#On a double click, check if a file or a folder. Files do nothing, while folders will
#replace current Itemlist (making it invisible) with a new item list of the folder's contents.
#PLAN-----------------------------------------------------------------------------------------------------
#Each folder is it's own ItemList, with files being it's items.
#PLAN-----------------------------------------------------------------------------------------------------
func _on_item_list_item_activated(index):
	var fold
	#TODO replace with current folder
	if mainPlayerFolder.get_item_icon(index) == folderTexture:
		for nodes in mainPlayerSpace.get_children():
			if nodes.name == mainPlayerFolder.get_item_text(index):
				mainPlayerFolder.visible = false
				var testFold = get_node(get_path_to(nodes))
				testFold.visible = true
				testFold.add_item("testing", fileTexture)
				break
				
	pass

#TODO replace with adjustable one
func _on_popup_menu_id_pressed(id):
	var fold = mainPlayerFolder
	#Currently adds just a "file" named testing
	#TODO: Add popup menu to allow for adding a file (from list of files you have) or folder
	#if id == addID:
		#fold.add_item("testing")
	if id == deleteID:
		for ind in fold.get_selected_items():
			fold.remove_item(ind)
	#TODO complete properties code
	elif  id == propertiesID:
		pass
	pass


func _on_item_list_multi_selected(index, selected):
	pass

#When the add popup is about to show
func _on_add_popup_about_to_popup():
	AddPopup.clear()
	var addPopup = AddPopup
	if player.foldersAllowed:
		addPopup.add_item("Folder", folderID)
	for str in player.filesArray:
		addPopup.add_item(str, fileID)

#When the add popup is about to add a file/folder
func _on_add_popup_index_pressed(index):
	var addPopup = AddPopup
	#If folder, add folder
	#TODO Differentiate from main folder to other folders
	if addPopup.get_item_id(index) == folderID:
		mainPlayerFolder.add_item("Folder", folderTexture)
		#mainPlayerSpace.add_child(ItemList.new())
		var newFolder = mainPlayerSpace.get_child(mainPlayerFolder.get_index()).duplicate()
		mainPlayerSpace.add_child(newFolder)
		#mainPlayerSpace.get_child(mainPlayerFolder).duplicate()
		#TODO in the rename function, make sure to change the name of the correct itemlist
		#mainPlayerSpace.get_child(mainPlayerFolder.get_child_count()-1).visible = false
		#mainPlayerSpace.get_child(mainPlayerFolder.get_child_count()-1).name = "Folder"
		#mainPlayerSpace.get_child(mainPlayerFolder.get_child_count()-1).size = mainPlayerFolder.size
		newFolder.visible = false
		newFolder.name = "Folder"
		newFolder.clear()
		#mainPlayerSpace.get_node(get_path_to(get_child(mainPlayerFolder.get_child_count()-1)))
		pass
	#Adds file of correct name to directory
	#TODO Differentiate from main folder to other folders
	if addPopup.get_item_id(index) == fileID:
		mainPlayerFolder.add_item(addPopup.get_item_text(index), fileTexture)
		pass
	pass # Replace with function body.
