extends StaticBody3D

var player : CharacterBody3D
# Called when the node enters the scene tree for the first time.

func _process(delta):
	if player != null:
		global_position = Vector3(player.global_position.x, -0.5, player.global_position.z)
