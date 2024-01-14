extends CharacterBody3D

@onready var sound = $AudioStreamPlayer3D
@onready var foot_sound = preload("res://sounds/pes descalços.wav")
@onready var jump_sound = preload("res://sounds/aaa.wav")

const SPEED = 4.0
const AERIALSPEED = 2.0
const JUMP_VELOCITY = 8.0

var speed : float = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var cameraC = $SpringArm3D
@onready var dir : Node3D = $Direction
@onready var anim_tree = $Direction/flowergirl2/AnimationTree

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		cameraC.rotation_degrees.y -= event.relative.x * 0.1
		cameraC.rotation_degrees.x -= event.relative.y * 0.1
		cameraC.rotation_degrees.x = clamp(cameraC.rotation_degrees.x, -50, 50)

func _physics_process(delta):
	if velocity.length() != 0:
		if is_on_floor():
			if !sound.playing:
				sound.stream = foot_sound
				sound.play()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		speed = AERIALSPEED
	else:
		speed = SPEED

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y += JUMP_VELOCITY
		sound.stream = jump_sound
		sound.play()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (cameraC.global_basis.x * -input_dir.x - cameraC.global_basis.z * -input_dir.y)
	direction.y = 0
	direction = direction.normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

	if Vector3(velocity.x, 0, velocity.z).length() > 0.001:
		var toRotate : float = atan2(velocity.x, velocity.z)
		dir.rotation.y = lerp_angle(dir.rotation.y, toRotate, 10 * delta)
	
	anim_tree.set("parameters/Speed/blend_position", lerp(anim_tree.get("parameters/Speed/blend_position"), Vector3(velocity.x, 0, velocity.z).length(), 6 * delta))
	anim_tree.set("parameters/OnAir/blend_amount", !is_on_floor())
	move_and_slide()
