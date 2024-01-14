extends Area3D

@export var impulse : float 

func _ready():
	connect("body_entered", _apply_impulse)

func _apply_impulse(body):
	if body is CharacterBody3D:
		body.velocity.y += impulse
