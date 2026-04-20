extends Node2D

#Should have code for Player's Folder File space

var playerEnvironment
var mainFolder
var popupMenu
var addPopup
#var currentFolder
var backButton
var forwardButton
var player
var renameVar

# Called when the node enters the scene tree for the first time.
func _ready():
	playerEnvironment = get_parent()	#actually vBoxContainer, but that is the size of the entire env
	mainFolder = $Protection
	popupMenu = $PopupMenu
	addPopup = $PopupMenu/AddPopup
	Globals.currentFolder = $Protection
	backButton = playerEnvironment.get_child(1).get_child(0)
	forwardButton= playerEnvironment.get_child(1).get_child(1)
	player = get_parent().get_parent().get_child(1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_F2):
		$LineEdit.visible = true
	pass

#Function on when player clicks on the empty space in the ItemList
func _on_item_list_empty_clicked(at_position, mouse_button_index):
	if mouse_button_index == MOUSE_BUTTON_RIGHT:
		#Sets the popup menu, moves it to the mouse position, and makes it visible.
		#Also deselects the current item(s)
		popupMenu.clear()
		popupMenu.add_submenu_node_item("Add", addPopup, Globals.addID)
		popupMenu.add_item("Properties", Globals.propertiesID)
		popupMenu.position = get_global_mouse_position()
		popupMenu.reset_size()
		popupMenu.visible = true
		Globals.currentFolder.deselect_all()
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		#Deselect current item(s)
		Globals.currentFolder.deselect_all()
		pass

#TODO, fix (I must add a naming function to differentiate from folders (and files)
#On double click, will enter into the folder
func _on_item_list_item_activated(index):
	#TODO replace with current folder
	#Checks to see if selected double click is a folder
	if Globals.currentFolder.get_item_icon(index) == Globals.folderTexture:
		#interates thru all nodes in the current folder
		for nodes in Globals.currentFolder.get_children():
			#if "nodes" has the same name as the as the selected folder, we go into it
			if nodes.name == mainFolder.get_item_text(index):
				#hide "parent" folder, get the "child" folder make child folder visible,
				#then make current folder the child folder
				disableFolder(Globals.currentFolder)
				var newFold = get_node(get_path_to(nodes))
				enableFolder(newFold)
				Globals.currentFolder = newFold
				#if the currentfolder isnt the starter folder, enable the back button
				if (Globals.currentFolder != mainFolder):
					backButton.disabled = false
				break
				
	pass

#Function on when the player clicks some item
func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index == MOUSE_BUTTON_RIGHT:
		#Different popupMenu for file or folder
		if Globals.currentFolder.get_item_icon(index) == Globals.fileTexture:
			#Sets the popup menu, moves it to the mouse position, and makes it visible
			popupMenu.clear()
			popupMenu.add_item("Delete", Globals.deleteID)
			popupMenu.add_item("Properties", Globals.propertiesID)
			popupMenu.position = get_global_mouse_position()
			popupMenu.reset_size()
			popupMenu.visible = true
			Globals.currentFolder.deselect_all()
			Globals.currentFolder.select(index)
		else:
			popupMenu.clear()
			popupMenu.add_item("Properties", Globals.propertiesID)
			popupMenu.position = get_global_mouse_position()
			popupMenu.reset_size()
			popupMenu.visible = true
			Globals.currentFolder.deselect_all()
			Globals.currentFolder.select(index)
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		pass

#TODO add drag functionality here maybe?
func _on_item_list_multi_selected(index, selected):
	pass # Replace with function body.

#When a button is pressed on the popupMenu
func _on_popup_menu_id_pressed(id):
	var fold = Globals.currentFolder
	if id == Globals.deleteID:
		for index in fold.get_selected_items():
			fold.remove_item(index)
	#TODO complete properties code
	elif  id == Globals.propertiesID:
		pass
	pass

#When the add popup is about to add a file/folder
func _on_add_popup_index_pressed(index):
	#If folder, add folder
	#TODO Differentiate from main folder to other folders (naming)
	if addPopup.get_item_id(index) == Globals.folderID:
		#var num = get_child_count() (Old code getting replaced for child system
		#currentFolder.add_item("Folder" + (str)(num), Globals.folderTexture)
		##mainPlayerSpace.add_child(ItemList.new())
		#var newFolder = get_child(mainFolder.get_index()).duplicate()
		#add_child(newFolder)
		##mainPlayerSpace.get_child(mainFolder).duplicate()
		##TODO in the rename function, make sure to change the name of the correct itemlist
		#disableFolder(newFolder)
		#default_name(newFolder)
		#newFolder.clear()
		##rename the item here (in itemlist)
		#sort_by_alphabetical()
		
		var num = Globals.currentFolder.get_child_count()
		if num == 0:
			num = (str)(num)
			num = ""
		else:
			num += 1
		#TODO Currently, the LineEdit cannot be interacted with (and anthing else) if it intersects
		#into the Enemy Environment, as they are not related to each other in that way
		#To see what I''m talking about, look at the mouse options in inspector and look at
		#pass (propagate up)
		#In other words, it propagates up the tree via it's parents till it hits a MOUSE STOP node
		
		#TODO Not done yet, but will take user input via the LineEdit and set that 
		$LineEdit.visible = true
		$LineEdit.global_position = get_viewport_rect().size / 2 - $LineEdit.size / 2
		$LineEdit.placeholder_text = "Folder" + (str)(num)
		#await $LineEdit.text_submitted
		await $LineEdit.text_submitted
		Globals.currentFolder.add_item(renameVar, Globals.folderTexture)
		#$ItemList.duplicate()
		var newFolder = Globals.currentFolder.duplicate(DUPLICATE_SIGNALS)
		Globals.currentFolder.add_child(newFolder)
		disableFolder(newFolder)
		newFolder.name = renameVar
		newFolder.clear()
		sort_by_alphabetical()
		
	#Adds file of correct name to directory
	#TODO Differentiate from main folder to other folders
	if addPopup.get_item_id(index) == Globals.fileID:
		Globals.currentFolder.add_item(addPopup.get_item_text(index), Globals.fileTexture)
		sort_by_alphabetical()
	#Sorts the files/folders by folders then files
	

#When the add popup is about to show
func _on_add_popup_about_to_popup():
	addPopup.clear()
	if player.foldersAllowed:
		addPopup.add_item("Folder", Globals.folderID)
	for str in player.filesArray:
		addPopup.add_item(str, Globals.fileID)


#sorting functions based on what is needed
#TODO using mainFolder to see methdos, change to currfolder when done
func sort_by_alphabetical():
	#gets the array of items
	var itemsArray = []
	for i in range(Globals.currentFolder.item_count):
		itemsArray.append({
			"text": Globals.currentFolder.get_item_text(i),
			"icon": Globals.currentFolder.get_item_icon(i),
			"metadata": Globals.currentFolder.get_item_metadata(i)
		})
	#Sorts the array
	itemsArray.sort_custom(sort_alphabetical_helper)
	Globals.currentFolder.clear()
	for item in itemsArray:
		if item["text"] != "":
			var index = Globals.currentFolder.add_item(item["text"], item["icon"])
			Globals.currentFolder.set_item_metadata(index, item["metadata"])

func sort_alphabetical_helper(a,b):
	var a_is_folder = a["icon"] == Globals.folderTexture
	var b_is_folder = b["icon"] == Globals.folderTexture
	if a_is_folder != b_is_folder:
		return a_is_folder
	return a["text"].to_lower() < b["text"].to_lower()

func sort_by_size():
	#gets the array of items
	var itemsArray = []
	for i in range(mainFolder.item_count):
		itemsArray.append({
			"text": mainFolder.get_item_text(i),
			"icon": mainFolder.get_item_icon(i),
			"metadata": mainFolder.get_item_metadata(i)
		})
	#Sorts the array
	

func sort_size_helper():
	pass

func sort_by_last_edited():
	#gets the array of items
	var itemsArray = []
	for i in range(mainFolder.item_count):
		itemsArray.append({
			"text": mainFolder.get_item_text(i),
			"icon": mainFolder.get_item_icon(i),
			"metadata": mainFolder.get_item_metadata(i)
		})
	#Sorts the array
	

func sort_last_edited_helper():
	pass


#Renaming here
func default_name(folder):
	var folderNum = Globals.currentFolder.get_child_count()
	if folderNum == 0:
		folderNum = (str)(folderNum)
		folderNum = ""
	else:
		folderNum += 1
	folder.name = "Folder" + (str)(folderNum)

func enableFolder(node):
	node.self_modulate.a = 1.0
	node.mouse_filter = Control.MOUSE_FILTER_STOP

func disableFolder(node):
	node.self_modulate.a = 0.0
	node.mouse_filter = Control.MOUSE_FILTER_IGNORE

#TODO Implement these functions for renaming
#Called when editing is toggled
func _on_line_edit_editing_toggled(toggled_on):
	pass # Replace with function body.

#called when the text changes
func _on_line_edit_text_changed(new_text):
	var used = false
	if (Globals.currentFolder.item_count != 0):
		for index in range(Globals.currentFolder.item_count):
			print(Globals.currentFolder.get_child(index).name)
			if Globals.currentFolder.get_child(index).name == new_text:
				#Name is already a folder
				used = true
				$LineEdit.self_modulate = Color(255,0,0)
		if !used:
			$LineEdit.self_modulate = Color(0,128,0)

#Idea, class variable that checks if current text is useable in above function
#Then idk

#called when the text is submitted
func _on_line_edit_text_submitted(new_text):
	#check if text is already a folder
	var passed = true
	var whilePassed = false
	print(Globals.currentFolder.item_count)
	if (Globals.currentFolder.item_count != 0):
		for index in range(Globals.currentFolder.item_count):
			print(Globals.currentFolder.get_child(index).name)
			if Globals.currentFolder.get_child(index).name == new_text:
				passed = false
	if passed == true:
		#Add rename implementation here
		if (new_text == ""):
			new_text = $LineEdit.placeholder_text
		renameVar = new_text
		print("passed text")
		$LineEdit.visible = false
		whilePassed = true
	else:
		await $LineEdit.text_submitted
		print("failed text")
		
		#Add fail Implementation here
	
