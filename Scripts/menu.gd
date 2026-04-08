extends Node2D

#var level: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/MainButtons/Play.grab_focus()
	# Makes the fullscreen checkbox set correctly at the start of the game
	$CenterContainer/SettingsMenu/Fullscreen.button_pressed = true if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN else false
	$CenterContainer/SettingsMenu/MainVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$CenterContainer/SettingsMenu/MusicVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("MUSIC")))
	$CenterContainer/SettingsMenu/SfxVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Click on "Play button", then go to node on the right side, then find the correct signal
func _on_play_pressed():
	# if you have a level global var, get that at the start (look above for how that looks)
	# assuming you have a folder called "Levels" that you store your level nodes in
	#get_tree().change_scene_to_file(str("res://Levels/", level, ".tscn"))
	pass # Replace with function body.


func _on_settings_pressed():
	$CenterContainer/MainButtons.visible = false
	$CenterContainer/SettingsMenu.visible = true
	$CenterContainer/SettingsMenu/Back.grab_focus()


func _on_credit_pressed():
	$CenterContainer/MainButtons.visible = false
	$CenterContainer/CreditsMenu.visible = true
	$CenterContainer/CreditsMenu/Back.grab_focus()


func _on_quit_pressed():
	get_tree().quit()

# shared by both back buttons in the settings and credits menus
func _on_back_pressed():
	$CenterContainer/MainButtons.visible = true
	if ($CenterContainer/SettingsMenu.visible):
		$CenterContainer/SettingsMenu.visible = false
		$CenterContainer/MainButtons/Settings.grab_focus()
	if $CenterContainer/CreditsMenu.visible:
		$CenterContainer/CreditsMenu.visible = false
		$CenterContainer/MainButtons/Credit.grab_focus()


func _on_fullscreen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_main_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)


func _on_music_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("MUSIC"), value)


func _on_sfx_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)
