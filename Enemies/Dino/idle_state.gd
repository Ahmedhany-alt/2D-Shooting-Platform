extends NodeState
@export var Character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var slow_down_speed : int = 50

func on_process(delta : float):
	pass
	
func on_physics_process(delta : float):
	Character_body_2d.velocity.x = move_toward(Character_body_2d.velocity.x, 0, slow_down_speed * delta)

func enter():
		pass
func exit():
	pass
