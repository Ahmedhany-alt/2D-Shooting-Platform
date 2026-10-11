extends CharacterBody2D

var enemy_death_effect = preload(
	"res://Enemies/enemy_death_effect.tscn"
)


@export var health_amount: int = 3
@export var damage_amount: int = 1

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const GRAVITY: float = 1000.0

enum State { IDLE, ATTACK, DEAD }

var current_state: State = State.IDLE

var direction: Vector2 = Vector2.LEFT

var point_positions: Array[Vector2] = []
var current_point_position: int = 0

var can_walk: bool = false
var is_dead: bool = false



func _physics_process(delta: float) -> void:
	if is_dead:
		return

	enemy_gravity(delta)



func enemy_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta




func take_damage(amount: int) -> void:
	if is_dead:
		return

	health_amount -= amount

	print("dino health: ", health_amount)

	if health_amount <= 0:
		die()


func die() -> void:
	if is_dead:
		return

	is_dead = true
	current_state = State.DEAD
	velocity = Vector2.ZERO

	var death_effect_instance = enemy_death_effect.instantiate()

	get_parent().add_child(death_effect_instance)
	death_effect_instance.global_position = global_position

	queue_free()


func get_damage_amount() -> int:
	return damage_amount



func _on_hurt_box_area_entered(area: Area2D) -> void:
	var bullet_node: Node = area

	if not bullet_node.has_method("get_damage_amount"):
		bullet_node = bullet_node.get_parent()

	if bullet_node.has_method("get_damage_amount"):
		var damage: int = bullet_node.get_damage_amount()
		take_damage(damage)
