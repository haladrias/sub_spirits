extends CharacterBody2D

#region declare variables

# onreadys
@onready var sprite = $AnimatedSprite2D

# constants
const MAX_SPEED = 100
const ACCEL = 600.0
const FRICTION = 300

# vars
var input = Vector2.ZERO
var has_key = false
var grandma_free = false
var mom_free = false
var dad_free = false
var sis_free = false
var bro_free = false

var tension_started = false

#endregion

#region player movement

func player_movement(input, delta):
	
	if input:
		velocity = velocity.move_toward(input * MAX_SPEED, delta * ACCEL)
	else:
		velocity = velocity.move_toward(Vector2(0,0), delta * FRICTION)

#endregion


func _physics_process(delta):
	
	if dad_free and mom_free and tension_started == false:
		$"../main_theme".playing = false
		$"../tension".playing = true
		tension_started = true
	
	if grandma_free == true:
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://scenes/levels/win.tscn")
	
	#region player movement also
	
	var input = Input.get_vector("move_left","move_right","move_up","move_down")
	player_movement(input, delta)
	move_and_slide()
	
	#endregion
	
	if velocity.x > 0:
		sprite.flip_h = true
	elif velocity.x < 0:
		sprite.flip_h = false
	
	#region ghost switching
	
	
	
	#endregion
	
