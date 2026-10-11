
extends AnimatedSprite2D

var bullet_impact_effect = preload(
	"res://Player/bullet_impact_effect.tscn"
)

var speed: float = 600.0
var direction: int
var damage_amount: int = 1
var has_hit: bool = false


func _physics_process(delta: float) -> void:
	if has_hit:
		return

	move_local_x(direction * speed * delta)


func _on_timer_timeout() -> void:
	queue_free()



func _on_hitbox_area_entered(area: Area2D) -> void:
	if has_hit:
		return

	var target: Node = area

	while target != null:
		if target.is_in_group("Enemy") and target.has_method("take_damage"):
			if area.name == "AttackAea2D":
				return
			has_hit = true
			target.take_damage(damage_amount)
			Bullet_impact()
			return

		target = target.get_parent()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if has_hit:
		return

	var target: Node = body

	while target != null:
		if target.is_in_group("Enemy") and target.has_method("take_damage"):
			has_hit = true
			target.take_damage(damage_amount)
			Bullet_impact()
			return

		target = target.get_parent()


	has_hit = true
	Bullet_impact()


func get_damage_amount() -> int:
	return damage_amount


func Bullet_impact() -> void:
	var bullet_impact_effect_instance = (
		bullet_impact_effect.instantiate() as Node2D
	)

	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)
	queue_free()
