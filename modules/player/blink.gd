extends MeshInstance3D
@export var blink_interval : float  = 1
@export var blink_offset : float = 0.5

var timer : Timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.wait_time = blink_interval
	timer.start()
	timer.connect("timeout", blink)

func blink():
	timer.wait_time = randi_range(1, 2)
	get_active_material(0).set("uv1_offset",  Vector2(blink_offset, 0)) 
	await get_tree().create_timer(0.1).timeout
	get_active_material(0).set("uv1_offset", Vector2.ZERO) 
