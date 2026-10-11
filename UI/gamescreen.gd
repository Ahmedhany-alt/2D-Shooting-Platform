extends CanvasLayer

@onready var collectable_label = $MarginContainer/VBoxContainer/HBoxContainer/CollectableLabel

func _ready():
	CollectableManager.on_collectable_award_recieved.connect(on_collectable_award_recieved)



func on_collectable_award_recieved(total_award : int):
	collectable_label.text = str(total_award)



func _on_pause_texture_button_pressed() -> void:
	GameManager.pause_game()
