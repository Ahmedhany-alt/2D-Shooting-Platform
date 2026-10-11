extends CharacterBody2D

var enemy_death_effect = preload(
	"res://Enemies/enemy_death_effect.tscn"
)

@export var patrol_points: Node2D
@export var speed: float = 150.0
@export var wait_time: float = 3.0
@export var health_amount: int = 3
@export var damage_amount: int = 1

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

const GRAVITY: float = 1000.0

enum State { IDLE, WALK, DEAD }

var current_state: State = State.IDLE
var direction: Vector2 = Vector2.LEFT

var point_positions: Array[Vector2] = []
var current_point_position: int = 0

var can_walk: bool = false
var is_dead: bool = false


func _ready() -> void:
	timer.wait_time = wait_time

	if patrol_points != null:
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)

		if point_positions.size() > 0:
			current_point_position = 0
			update_direction()
		else:
			print("Crab: No patrol points found.")
	else:
		print("Crab: PatrolPoints is not assigned.")

	current_state = State.IDLE


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	apply_gravity(delta)
	update_patrol(delta)

	move_and_slide()

	update_animation()


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta


func update_patrol(delta: float) -> void:
	if point_positions.is_empty():
		velocity.x = 0.0
		current_state = State.IDLE
		return

	if not can_walk:
		velocity.x = move_toward(
			velocity.x,
			0.0,
			speed * 5.0 * delta
		)

		current_state = State.IDLE
		return

	var target_x: float = point_positions[current_point_position].x
	var distance: float = target_x - global_position.x

	if abs(distance) > 2.0:
		direction = Vector2.RIGHT if distance > 0.0 else Vector2.LEFT
		velocity.x = direction.x * speed
		current_state = State.WALK
	else:
		velocity.x = 0.0
		current_state = State.IDLE

		current_point_position = (
			current_point_position + 1
		) % point_positions.size()

		update_direction()

		can_walk = false
		timer.start()


func update_direction() -> void:
	if point_positions.is_empty():
		return

	var target_x: float = point_positions[current_point_position].x

	if target_x > global_position.x:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.LEFT


func update_animation() -> void:
	animated_sprite_2d.flip_h = direction.x > 0.0

	match current_state:
		State.IDLE:
			animated_sprite_2d.play("idle")

		State.WALK:
			animated_sprite_2d.play("walk")

		State.DEAD:
			pass


func take_damage(amount: int) -> void:
	if is_dead:
		return

	health_amount -= amount

	print("Crab health: ", health_amount)

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


func _on_timer_timeout() -> void:
	can_walk = true


func _on_hurt_box_area_entered(area: Area2D) -> void:
	var bullet_node: Node = area

	if not bullet_node.has_method("get_damage_amount"):
		bullet_node = area.get_parent()

	if bullet_node.has_method("get_damage_amount"):
		var damage: int = bullet_node.get_damage_amount()
		take_damage(damage)
