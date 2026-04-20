extends LineEdit

@onready var used
signal rename_accepted

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var used = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if visibility_changed and visible:
		#if (Globals.currentFolder.item_count != 0):
			#for index in range(Globals.currentFolder.item_count):
				#if placeholder_text == Globals.currentFolder.get_item_text(index):
					#used = true
					#self_modulate = Color(255,0,0)
			#if !used:
				#self_modulate = Color(0,128,0)
	#else:
		pass
