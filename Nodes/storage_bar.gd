extends ProgressBar

#gets the bar color
var barCol = get_theme_stylebox("fill") as StyleBoxFlat
#TODO
#Must set this to current player's storage max
var maxStorage = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#On every value change of the storage progess bar, will check to see if the bar should change to a different color
func _on_value_changed(value):
	var yellowThresh = (int)(maxStorage * 0.75)
	var redThresh = (int)(maxStorage * 0.85)
	if (value >= redThresh):
		barCol.bg_color = Color.RED
	elif (value >= yellowThresh):
		barCol.bg_color = Color.YELLOW
	elif (barCol.bg_color != Color.GREEN):
		barCol.bg_color = Color.GREEN
	else:
		pass
