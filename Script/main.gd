extends Node2D

@onready var spawn_timer = $spawn_timer
@onready var player_spawn = $start_pos
@onready var player = $Player
@onready var hud = $HUD
@export var slime_scene: PackedScene
var waves = [1, 3, 5, 7, 10] 
var current_wave = 0
var enemies_spawned = 0
var min_x = 0
var max_x = 528
var min_y = 0
var max_y = 288
func _ready():
	if hud != null:
		hud.start_game.connect(_on_game_started)
		hud.update_wave_count(0)

func _process(delta):
	if enemies_spawned >= waves[current_wave]:
		if get_tree().get_nodes_in_group("Slimes").size() == 0:
			current_wave += 1
			if current_wave  < waves.size():
				start_wave()
			else:
				if hud != null:
					hud.wave_counter.text = "You Win!"
				set_process(false)
func _on_game_started():
	current_wave = 0
	enemies_spawned = 0
	set_process(true)
	get_tree().call_group("Slimes", "queue_free")
	player.global_position = player_spawn.global_position
	player.reset_player()
	start_wave()
	
func start_wave():
	enemies_spawned = 0
	spawn_timer.start()
	if hud != null:
		hud.update_wave_count(current_wave + 1)
		

func _on_spawn_timer_timeout():
	if slime_scene != null:
		var random_x = randf_range(min_x, max_x)
		var random_y = randf_range(min_y, max_y)
		var slime = slime_scene.instantiate()
		slime.global_position = Vector2(random_x, random_y)
		call_deferred("add_child", slime)
		enemies_spawned += 1
		if enemies_spawned >= waves[current_wave]:
			spawn_timer.stop()
