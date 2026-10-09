extends Node


func _ready():
	RenderingServer.set_default_clear_color(Color(0.44,0.12,0.53,1.00))

func start_game():
	SceneManager.transition_to_scene("level1")
	
func exit_game():
	get_tree().quit()
	
