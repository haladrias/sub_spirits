extends CharacterBody2D

@onready var player_collider: Area2D = $player_collider

@export var max_speed := 90.00
@export var acceleration := 200.00


func _physics_process(delta: float) -> void:
	var direction := global_position.direction_to(get_global_player_position())
	var distance := global_position.distance_to(get_global_player_position())
	var speed := max_speed if distance > 100 else distance

	var desired_velocity := direction * speed
	velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	move_and_slide()
	
	var bodies = player_collider.get_overlapping_bodies()
	if bodies != null:
		for body in bodies:
			if body.is_in_group("player"):
				velocity = -velocity
	



func get_global_player_position() -> Vector2:
	return get_tree().root.get_node("sub_spirits_main/Player").global_position
