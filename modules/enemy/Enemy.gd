extends Node3D

var player : CharacterBody3D

func _ready():
	connect("body_entered", _die)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player == null:
		return
	
	global_position = lerp(global_position, player.global_position + Vector3.UP * 1, 1.3 * delta)

func _die(area):
	if area is CharacterBody3D:
		Global._die()
