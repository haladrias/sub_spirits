extends CharacterBody2D

@onready var parent = get_parent()
@onready var nav_agent = $NavigationAgent2D
@onready var animation_player = $AnimationPlayer


@export var return_point : Area2D

var state = "path"
@export var max_speed := 80.00
@export var acceleration := 1000.00
@export var path_speed = 50

var last_path_position = Vector2(0,0)
var last_position = global_position

func _physics_process(delta):
	#sprite changes
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			#right
			animation_player.current_animation = "walk_right"
		if velocity.x < 0:
			#left
			animation_player.current_animation = "walk_left"
	elif abs(velocity.y) > abs(velocity.x):
		if velocity.y > 0:
			#down
			animation_player.current_animation = "walk_down"
		if velocity.y < 0:
			#up
			animation_player.current_animation = "walk_up"

func _process(delta):
	
	match state:
		"return":
			var direction = Vector3()
			
			nav_agent.set_target_position(return_point.global_position)
			
			direction = nav_agent.get_next_path_position() - global_position
			direction = direction.normalized()
			
			velocity = velocity.lerp(direction * max_speed, max_speed * delta)
			
			move_and_slide()
			
			if nav_agent.distance_to_target() < 2:
				global_position = return_point.global_position
				velocity = Vector2.ZERO
				state = "path"
		"path":
			parent.progress += delta * path_speed
			
			var direction = (global_position - last_position)
			
			last_position = global_position
			
			print(str(direction))
			
			if abs(direction.x) > abs(direction.y):
				if direction.x > 0:
					animation_player.current_animation = "walk_right"
				if direction.x < 0:
					animation_player.current_animation = "walk_left"
			if abs(direction.x) < abs(direction.y):
				if direction.y > 0:
					animation_player.current_animation = "walk_down"
				if direction.y < 0:
					animation_player.current_animation = "walk_up"
			
		"chase":
			var direction := global_position.direction_to(get_global_player_position())
			var distance := global_position.distance_to(get_global_player_position())
			var speed := max_speed if distance > 100 else  max_speed * distance / 100
			
			var desired_velocity := direction * speed
			velocity = velocity.move_toward(desired_velocity, acceleration * delta)
			move_and_slide()


func get_global_player_position() -> Vector2:
	return get_tree().root.get_node("HoverMotionPrototype/Player").global_position

func _on_light_beam_area_body_entered(body):
	if body.is_in_group("player"):#when you switch active ghost that ghost gets put in the group player
		if state == "path":
			last_path_position = global_position
			return_point.global_position = last_path_position
		if state != "chase":
			state = "chase"


func _on_player_chaser_body_exited(body):
	if body.is_in_group("player"):
		if state == "chase":
			state = "return"
