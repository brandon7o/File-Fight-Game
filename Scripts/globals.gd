extends Node

@onready var folderID = 1
@onready var fileID = 0
@onready var addID = 0
@onready var deleteID = 1
@onready var propertiesID = 2
@onready var cutID = 3
@onready var pasteInID = 4
@onready var pasteSelID = 5
@onready var fileTexture
@onready var folderTexture
@onready var currentFolder

# Called when the node enters the scene tree for the first time.
func _ready():
	fileTexture = preload("res://Textures/IDs/fileTexture.tres")
	folderTexture = preload("res://Textures/IDs/folderTexture.tres")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
