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
@onready var popupMenuPlayer = $VSeparator/PlayerEnvironment/VBoxContainer/FolderFileSpacePlayer/PopupMenu
@onready var AddPopup = $VSeparator/PlayerEnvironment/VBoxContainer/FolderFileSpacePlayer/PopupMenu/AddPopup
#TODO make function so that we know which "folder" we are currently in at all times
@onready var mainPlayerFolder = $VSeparator/PlayerEnvironment/VBoxContainer/FolderFileSpacePlayer/ItemList
@onready var mainPlayerSpace = $VSeparator/PlayerEnvironment/VBoxContainer/FolderFileSpacePlayer
@onready var currentFolder = mainPlayerFolder
@onready var backButton = $VSeparator/PlayerEnvironment/VBoxContainer/HBoxContainer/BackButton
@onready var forwardButton = $VSeparator/PlayerEnvironment/VBoxContainer/HBoxContainer/ForwardButton

#START HERE: WHAT IS NEEDED FOR PRE-ALPHA
# = TODO
## = DOING
##- = DOING, ON PAUSE
### = DONE
##Add a way to sort the files/folders whenever one is added
#Add a way to drag files into folders
#Add naming for folders and files when you add them, also f2 can rename files/folders
###Add a function to make the variable "currentFolder" know and recognise the current folder,
###replacing most variables of mainPlayerFolder/Space with this variable or close relatives
##-Add a back button functionality that goes back one folder and is unselectable in mainPlayerFolder
#Add a way to differentiate from items in itemlist (this will be done by adding a lot of empty
#texture2D's with the correct file ID, giving them correct ID varibles as seen in the ready function
#Move functions to different scripts into different nodes that makes it more organized
#Add turn-based gameplay
#Add simple enemy and give it custom-made "ai"
#Add UI for player HP and enemy HP
#Add win-loss screen

#START HERE: WHAT ELSE IS NEEDED FOR ALPHA
#Upgrade screen that gives player new files
#Levels and exp for player, giving more actions per turn
#More enemies, up to level 10
#General balancing

#START HERE: WHAT ELSE IS NEEDED FOR BETA
#Polish
#Infinate enemies
#Seeded games to allow randomness in every run (in upgrades mainly)

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
		currentFolder.deselect_all()
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		#Deselect current item(s)
		currentFolder.deselect_all()
		pass

#Function on when the player clicks some item
#TODO Differentiate from main folder to other folders
func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index == MOUSE_BUTTON_RIGHT:
		if currentFolder.get_item_icon(index) == fileTexture:
			#Sets the popup menu, moves it to the mouse position, and makes it visible
			popupMenuPlayer.clear()
			popupMenuPlayer.add_item("Delete", deleteID)
			popupMenuPlayer.add_item("Properties", propertiesID)
			popupMenuPlayer.position = get_global_mouse_position()
			popupMenuPlayer.reset_size()
			popupMenuPlayer.visible = true
			currentFolder.deselect_all()
			currentFolder.select(index)
		else:
			popupMenuPlayer.clear()
			popupMenuPlayer.add_item("Properties", propertiesID)
			popupMenuPlayer.position = get_global_mouse_position()
			popupMenuPlayer.reset_size()
			popupMenuPlayer.visible = true
			currentFolder.deselect_all()
			currentFolder.select(index)
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
	if currentFolder.get_item_icon(index) == folderTexture:
		for nodes in mainPlayerSpace.get_children():
			if nodes.name == mainPlayerFolder.get_item_text(index):
				currentFolder.visible = false
				var testFold = get_node(get_path_to(nodes))
				testFold.visible = true
				currentFolder = testFold
				if (currentFolder != mainPlayerFolder):
					backButton.disabled = false
				testFold.add_item("testing", fileTexture)
				break
				
	pass

#TODO replace with adjustable one
func _on_popup_menu_id_pressed(id):
	var fold = currentFolder
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
		currentFolder.add_item("Folder", folderTexture)
		#mainPlayerSpace.add_child(ItemList.new())
		var newFolder = mainPlayerSpace.get_child(mainPlayerFolder.get_index()).duplicate()
		mainPlayerSpace.add_child(newFolder)
		#mainPlayerSpace.get_child(mainPlayerFolder).duplicate()
		#TODO in the rename function, make sure to change the name of the correct itemlist
		newFolder.visible = false
		newFolder.name = "Folder"
		newFolder.clear()
		sort_by_alphabetical()
	#Adds file of correct name to directory
	#TODO Differentiate from main folder to other folders
	if addPopup.get_item_id(index) == fileID:
		currentFolder.add_item(addPopup.get_item_text(index), fileTexture)
		sort_by_alphabetical()
	#Sorts the files/folders by folders then files
	
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	#TODO Add backing functionality
	
	#If we are now in the mainPlayerFolder, we disable the button
	if currentFolder == mainPlayerFolder:
		backButton.disabled = true
	#else, if the folder is not the mainPlayerFolder, and the back button is
	#also disabled, then we enable it
	elif currentFolder != mainPlayerFolder and backButton.disabled == true:
		backButton.disabled = false
	pass


func _on_forward_button_pressed() -> void:
	#TODO Add forward functionality
	
	#TODO If we ar in the most recent folder, disable the button
	pass


#sorting functions based on what is needed
#TODO using mainplayerfolder to see methdos, change to currfolder when done
func sort_by_alphabetical():
	#gets the array of items
	var itemsArray = []
	for i in range(currentFolder.item_count):
		itemsArray.append({
			"text": currentFolder.get_item_text(i),
			"icon": currentFolder.get_item_icon(i),
			"metadata": currentFolder.get_item_metadata(i)
		})
	#Sorts the array
	itemsArray.sort_custom(sort_alphabetical_helper)
	mainPlayerFolder.clear()
	for item in itemsArray:
		if item["text"] != "":
			var index = mainPlayerFolder.add_item(item["text"], item["icon"])
			mainPlayerFolder.set_item_metadata(index, item["metadata"])

func sort_alphabetical_helper(a,b):
	var a_is_folder = a["icon"] == folderTexture
	var b_is_folder = b["icon"] == folderTexture
	if a_is_folder != b_is_folder:
		return a_is_folder
	return a["text"].to_lower() < b["text"].to_lower()

func sort_by_size():
	#gets the array of items
	var itemsArray = []
	for i in range(mainPlayerFolder.item_count):
		itemsArray.append({
			"text": mainPlayerFolder.get_item_text(i),
			"icon": mainPlayerFolder.get_item_icon(i),
			"metadata": mainPlayerFolder.get_item_metadata(i)
		})
	#Sorts the array
	

func sort_size_helper():
	pass

func sort_by_last_edited():
	#gets the array of items
	var itemsArray = []
	for i in range(mainPlayerFolder.item_count):
		itemsArray.append({
			"text": mainPlayerFolder.get_item_text(i),
			"icon": mainPlayerFolder.get_item_icon(i),
			"metadata": mainPlayerFolder.get_item_metadata(i)
		})
	#Sorts the array
	

func sort_last_edited_helper():
	pass
