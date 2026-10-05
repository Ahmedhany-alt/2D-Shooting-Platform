extends CanvasLayer
@onready var window_mode_option_button: OptionButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/WindowModeOptionButton
@onready var main_menu_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/MainMenuButton
var window_mode : Dictionary = {"Fullscreen" : DisplayServer.WINDOW_MODE_FULLSCREEN, "Window" : DisplayServer.WINDOW_MODE_WINDOWED, "Window_Maximized" : DisplayServer.WINDOW_MODE_MAXIMIZED}
var resolution : Dictionary = {"320*180" : Vector2i(320,180), "480*270" : Vector2i(480,270),"640*360" : Vector2i(640,360),"854*480" : Vector2i(640,360),"1280*720" : Vector2i(1280,720),}

func _ready():
	for window_mode in window_mode:
		window_mode_option_button.add_item(window_mode)
