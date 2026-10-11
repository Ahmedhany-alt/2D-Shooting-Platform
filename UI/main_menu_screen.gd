extends CanvasLayer

var setting_menu_screen = preload("res://UI/Settings_Menu_Screen.tscn")
func _on_play_button_pressed():
	GameManager.start_game()
	queue_free()




func _on_exit_button_pressed():
	GameManager.exit_game()
	


func _on_settings_button_pressed():
	var setting_menu_screen_instance = setting_menu_screen.instantiate()
	get_tree().root.add_child(setting_menu_screen_instance)
