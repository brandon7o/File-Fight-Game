extends Node2D

#@onready var player = $VSeparator/PlayerEnvironment/Player
#@onready var popupMenuPlayer = $VSeparator/PlayerEnvironment/VBoxContainer/FolderFileSpacePlayer/PopupMenu
#@onready var AddPopup = $VSeparator/PlayerEnvironment/VBoxContainer/FolderFileSpacePlayer/PopupMenu/AddPopup
#@onready var mainPlayerFolder = $VSeparator/PlayerEnvironment/VBoxContainer/FolderFileSpacePlayer/ItemList
#@onready var mainPlayerSpace = $VSeparator/PlayerEnvironment/VBoxContainer/FolderFileSpacePlayer
#@onready var currentFolder = mainPlayerFolder
#@onready var backButton = $VSeparator/PlayerEnvironment/VBoxContainer/HBoxContainer/BackButton
#@onready var forwardButton = $VSeparator/PlayerEnvironment/VBoxContainer/HBoxContainer/ForwardButton

#START HERE: WHAT IS NEEDED FOR PRE-ALPHA
# = TODO
## = DOING
##- = DOING, ON PAUSE
### = DONE
###Add a way to sort the files/folders whenever one is added
#Add a way to drag files into folders
##Add naming for folders and files when you add them
#Maybe we dont add this? Just allow them to rename when they create something #Allow f2 button to rename files or folders
###Add a function to make the variable "currentFolder" know and recognise the current folder,
###replacing most variables of mainPlayerFolder/Space with this variable or close relatives
###-Add a back button functionality that goes back one folder and is unselectable in mainPlayerFolder
###Add a way to differentiate from items in itemlist (this will be done by adding a lot of empty
###texture2D's with the correct file ID, giving them correct ID varibles as seen in the ready function
###Move functions to different scripts into different nodes that makes it more organized
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
#Infinite enemies
#Seeded games to allow randomness in every run (in upgrades mainly)

# Called when the node enters the scene tree for the first time.
func _ready():
	#placed in globals.gd
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#TODO make escape menu
	#gets the escape key button press and quits the game
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
