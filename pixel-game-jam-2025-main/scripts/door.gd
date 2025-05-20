extends Node2D

@export var grandma_door = false
@export var parent_door = false
@onready var player: CharacterBody2D = $"../Player"

func _physics_process(delta: float) -> void:
	if player.sis_free and player.bro_free:
		if parent_door == true:
			queue_free()
	if player.mom_free and player.dad_free:
		if grandma_door == true:
			queue_free()
