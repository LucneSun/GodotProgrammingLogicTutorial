extends Node3D

var can_reset : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") && can_reset == true:
		Global._reset()

func _can_reset():
	can_reset = true
