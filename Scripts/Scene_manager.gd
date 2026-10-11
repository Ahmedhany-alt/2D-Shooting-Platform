extends Node

var scenes : Dictionary = { "level_1": "res://&&Levels/level_5.tscn",
							"level_2": "res://levels/test_levels/level_2.tscn"}


func transition_to_scene(level : String) :
	var scene_path : String = scenes.get(level)
	
	if scene_path != null:
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file(scene_path)
