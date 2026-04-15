extends Node2D

#Player stats
@onready var hp = 100
@onready var storage = 500
@onready var bandwidth = 0
@onready var turns = 1
@onready var actionsPerTurn = 1
@onready var foldersAllowed = true
@onready var filesArray = [] as Array[String]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	filesArray.append("Damage File")
	filesArray.append("Heal File")
	filesArray.append("Damage Boost File")
	filesArray.append("Block File")
	filesArray.append("Slow File")
	filesArray.append("Dummy File")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
