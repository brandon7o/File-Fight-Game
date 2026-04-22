extends ItemList


var parentFolder

# Called when the node enters the scene tree for the first time.
func _ready():
	if name != "Protection":
		parentFolder = get_parent()
	else:
		parentFolder = get_parent().get_child(0)
		pass
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Called when you grab the data
func _get_drag_data(at_position):
	#return get_selected_items()
	pass

#called when you can drop the files into a folder/current space
func _can_drop_data(at_position, data):
	#if 
	pass

#called when you drop the data
func _drop_data(at_position, data):
	pass
