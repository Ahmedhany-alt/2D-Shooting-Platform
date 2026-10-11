extends Node
var setting_data : SettingsDataResource
var save_settings_path = "user://game_data/"
var save_file_name = "settings_data.tres"
func load_settings():
	if !DirAccess.dir_exists_absolute(save_settings_path):
		DirAccess.make_dir_absolute(save_settings_path)
	if ResourceLoader.exists(save_settings_path + save_file_name):
		setting_data = ResourceLoader.load(save_settings_path + save_file_name)
	if setting_data == null:
		setting_data = SettingsDataResource.new()
		
	if setting_data != null:
		set_window_mode(setting_data.window_mode,setting_data.window_mode_index)
		set_resolution(setting_data.resolution,setting_data.resolution_index)
		

func set_window_mode(window_mode: int, window_mode_index: int) -> void:
	DisplayServer.window_set_mode(window_mode)

	setting_data.window_mode = window_mode
	setting_data.window_mode_index = window_mode_index

	
	
func set_resolution(resolution: Vector2i,resolution_index : int):
	get_tree().root.content_scale_size = resolution
	setting_data.resolution = resolution
	setting_data.resolution_index = resolution_index
	
func get_setting() -> SettingsDataResource:
	return setting_data


func save_setting():
	ResourceSaver.save(setting_data,save_settings_path + save_file_name)
	
