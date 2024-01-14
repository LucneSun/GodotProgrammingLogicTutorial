extends Node

@onready var player_scene = preload("res://modules/player/character_body_3d.tscn")
@onready var enviro_scene = preload("res://modules/enviro/enviro.tscn")
@onready var enemy_scene = preload("res://modules/enemy/enemy.tscn")
var player
var enemy
var enviro

var current_scene : int = 0
@export var scenes : Array[PackedScene]

var current_flowers_in_scene : int

func _ready():
	scenes = []
	
	var _dir = DirAccess.open("res://scenes/")
	if _dir:
		_dir.list_dir_begin()
		var file_name = _dir.get_next()
		while  file_name != "":
			if _dir.current_is_dir():
				pass
			else:
				var scene : PackedScene = load("res://scenes/" + file_name.replace(".remap", "")) as PackedScene
				print_debug(file_name)
				scenes.append(scene)
			file_name = _dir.get_next()
		_dir.list_dir_end()
	

func _setup_game():
	get_tree().change_scene_to_packed(scenes[0])
	_setup_scene()
	current_flowers_in_scene = get_tree().get_nodes_in_group("flowers").size()

func _setup_scene():
	player = player_scene.instantiate()
	get_tree().root.call_deferred("add_child", player)
	enviro = enviro_scene.instantiate()
	get_tree().root.call_deferred("add_child", enviro)
	enemy = enemy_scene.instantiate()
	get_tree().root.call_deferred("add_child", enemy)
	enemy.player = player
	enviro.player = player

func _refresh_flowers():
	current_flowers_in_scene = get_tree().get_nodes_in_group("flowers").size()
	
	if current_flowers_in_scene <= 0:
		current_scene += 1
		get_tree().change_scene_to_packed(scenes[current_scene])
		
		if enviro:
			enviro.queue_free()
		if enemy:
			enemy.queue_free()
		if player:
			player.queue_free()
		
		if current_scene < scenes.size() - 1:
			_setup_scene()

func _die():
	if enviro:
			enviro.queue_free()
	if enemy:
			enemy.queue_free()
	if player:
			player.queue_free()
	get_tree().reload_current_scene()
	_setup_scene()

func _reset():
	current_scene = 0
	_setup_game()
