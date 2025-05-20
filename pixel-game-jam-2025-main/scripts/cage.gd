extends Node2D

@onready var player_detector: Area2D = $player_detector
@onready var e: Label = $E

@export var grandma_cage = false
@export var mom_cage = false
@export var dad_cage = false
@export var sis_cage = false
@export var bro_cage = false

func _physics_process(delta: float) -> void:
	var bodies = player_detector.get_overlapping_bodies()
	if bodies != null:
		for body in bodies:
			if body.is_in_group("player") and body.has_key == true:
				e.visible = true
				if Input.is_action_just_pressed("interact"):
					if body.has_key == true:
						if grandma_cage == true:
							body.grandma_free = true
						if mom_cage == true:
							body.mom_free = true
						if dad_cage == true:
							body.dad_free = true
						if sis_cage == true:
							body.sis_free = true
						if bro_cage == true:
							body.bro_free = true
						queue_free()
			else:
				e.visible = false
	else:
		e.visible = false
