extends CharacterBody2D

@onready var player_collider: Area2D = $player_collider

@export var max_speed := 200.00
@export var acceleration := 600.00
@export var avoidance_stregnth := 31000.00

#@onready var _raycasts: Node2D = $Raycasts


func _physics_process(delta: float) -> void:
	var direction := global_position.direction_to(get_global_player_position())
	var distance := global_position.distance_to(get_global_player_position())
	var speed := max_speed if distance > 100 else distance

	var desired_velocity := direction * speed
	
	velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	#desired_velocity += calculate_avoidance_force() * delta
	move_and_slide()
	
	var bodies = player_collider.get_overlapping_bodies()
	if bodies != null:
		for body in bodies:
			if body.is_in_group("player"):
				velocity = Vector2(0,0)
	


func get_global_player_position() -> Vector2:
	return get_tree().root.get_node("sub_spirits_main/Player").global_position


		
#func calculate_avoidance_force() -> Vector2:
	#var avoidance_force := Vector2.ZERO
	#
	#for raycast: RayCast2D in _raycasts.get_children():
		#if raycast.is_colliding():
		#
			#var collision_position := raycast.get_collision_point()
			#var direction_away_from_obstacle := collision_position.direction_to(raycast.global_position)
		#
			#var ray_length := raycast.target_position.length()
			#var intensity := 1.0 - collision_position.distance_to(raycast.global_position) / ray_length
		#
			#var force := direction_away_from_obstacle * avoidance_stregnth * intensity
			#avoidance_force += force
	#
	#return avoidance_force
