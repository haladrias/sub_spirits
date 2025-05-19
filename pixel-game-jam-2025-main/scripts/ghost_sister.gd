extends CharacterBody2D



@export var max_speed := 150.00
@export var acceleration := 250.00


func _physics_process(delta: float) -> void:
	var direction := global_position.direction_to(get_global_player_position())
	var distance := global_position.distance_to(get_global_player_position())
	var speed := max_speed if distance > 100 else max_speed * distance / 100

	var desired_velocity := direction * speed
	velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	move_and_slide()


func get_global_player_position() -> Vector2:
	return get_tree().root.get_node("sub_spirits_main/Player").global_position

func _on_player_collider_body_entered(body):
	if body.is_in_group("Player"):
		velocity *= 0.9
