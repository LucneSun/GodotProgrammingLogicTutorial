extends Area3D

@onready var graphics =$MeshInstance3D
@onready var audio = $AudioStreamPlayer
var time : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _collected)
	add_to_group("flowers")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta * 2
	graphics.position.y = sin(time) * 1

func _collected(area):
	if area is CharacterBody3D:
		disconnect("body_entered", _collected)
		remove_from_group("flowers")
		visible = false
		audio.play()
		await  audio.finished
		queue_free()
		Global._refresh_flowers()
