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

#endregion

#region player movement

func player_movement(input, delta):
	
	if input:
		velocity = velocity.move_toward(input * MAX_SPEED, delta * ACCEL)
	else:
		velocity = velocity.move_toward(Vector2(0,0), delta * FRICTION)

#endregion


func _physics_process(delta):
	
	#region player movement also
	
	var input = Input.get_vector("move_left","move_right","move_up","move_down")
	player_movement(input, delta)
	move_and_slide()
	
	#endregion
	
	#region ghost switching
	
	
	
	#endregion
	
