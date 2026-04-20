extends Node2D
#Should have code for player environment besides Folder File Space


var player
var storage
var backButton
var forwardButton
var mainSpace
var mainFolder
#var currentFolder

# Called when the node enters the scene tree for the first time.
func _ready():
	#Will probably have to use $ and replace them when adding scripts so I can see what I can use
	player = $Player
	storage = $VBoxContainer/Storage
	backButton = $VBoxContainer/HBoxContainer/BackButton
	forwardButton = $VBoxContainer/HBoxContainer/ForwardButton
	mainSpace = $VBoxContainer/FolderFileSpacePlayer
	mainFolder = $VBoxContainer/FolderFileSpacePlayer/Protection
	#currentFolder = $VBoxContainer/FolderFileSpacePlayer/ItemList


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	#TODO Add backing functionality
	var backFolder = Globals.currentFolder.get_parent()
	mainSpace.disableFolder(Globals.currentFolder)
	mainSpace.enableFolder(backFolder)
	Globals.currentFolder = backFolder
	#If we are now in the mainPlayerFolder, we disable the button
	if Globals.currentFolder == mainFolder:
		backButton.disabled = true
	#else, if the folder is not the mainPlayerFolder, and the back button is
	#also disabled, then we enable it
	elif Globals.currentFolder != mainFolder and backButton.disabled == true:
		backButton.disabled = false
	pass


func _on_forward_button_pressed():
	#TODO Add forward functionality
	
	#TODO If we ar in the most recent folder, disable the button
	pass
