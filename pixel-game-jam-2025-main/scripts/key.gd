extends Node2D

@onready var player_detector: Area2D = $player_detector
@onready var e: Label = $E

func _physics_process(delta: float) -> void:
	var bodies = player_detector.get_overlapping_bodies()
	if bodies != null:
		for body in bodies:
			if body.is_in_group("player"):
				e.visible = true
				if Input.is_action_just_pressed("interact"):
					body.has_key = true
					queue_free()
			else:
				e.visible = false
	else:
		e.visible = false
