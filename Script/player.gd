extends CharacterBody2D

var attack_range = false
var cooldown = true
var health = 3
var player_status = true
var attack_ip = false
var player_input = false
@export var speed = 150 
@export var arrow : PackedScene
@onready var Animation_sprite = $AnimatedSprite2D
var animation_status = "down"
@onready var shoot_point = $Proj_origin
var min_x = 0
var min_y = 0
var max_x = 528
var max_y = 288
@onready var health_status = $CanvasLayer/Health
func _ready():
	add_to_group("Player")
	player()
	update_health()
func _physics_process(delta):
	player_movement(delta)
	slime_attack()
	
	if health <= 0:
		player_status = false
		health = 0
		print("player died")
		self.queue_free()
func player_movement(delta):
	if Input.is_action_pressed("attack") and not attack_ip:
		attack_ip = true
		velocity.x = 0
		velocity.y = 0
		shoot()
		if animation_status == "down":
			Animation_sprite.play("Attack_down")
		elif animation_status == "up":
			Animation_sprite.play("Attack_up")
		elif animation_status == "right":
			Animation_sprite.flip_h = false
			Animation_sprite.play("Attack_side")
		elif animation_status == "left":
			Animation_sprite.flip_h = true
			Animation_sprite.play("Attack_side")
	elif attack_ip:
		move_and_slide()
		return
		
	elif Input.is_action_pressed("Down"):
		velocity.y = speed
		velocity.x = 0
		Animation_sprite.play("Walk_down")
		animation_status = "down"
		
	elif Input.is_action_pressed("Left"):
		velocity.x = -speed
		velocity.y = 0
		Animation_sprite.flip_h = true
		Animation_sprite.play("Walk_side")
		animation_status = "left"
		
	elif Input.is_action_pressed("Up"):
		velocity.y = -speed
		velocity.x = 0
		Animation_sprite.play("Walk_up")
		animation_status = "up"
		
	elif Input.is_action_pressed("Right"):
		velocity.x = speed
		velocity.y = 0
		Animation_sprite.flip_h = false
		Animation_sprite.play("Walk_side")
		animation_status = "right"
	

	else:
		velocity.x = 0
		velocity.y = 0
		if animation_status == "down":
			Animation_sprite.play("Idle_down")
		if animation_status == "up":
			Animation_sprite.play("idle_up")
		if animation_status == "right":
			Animation_sprite.play("Idle_side")
			Animation_sprite.flip_h = false
		if animation_status == "left":
			Animation_sprite.play("Idle_side")
			Animation_sprite.flip_h = true
	move_and_slide()
	global_position.x = clamp(global_position.x, min_x, max_x)
	global_position.y = clamp(global_position.y, min_y, max_y)



func _on_player_hitbox_body_entered(body):
	if body.has_method("slime"):
		attack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("slime"):
		attack_range = false

func slime_attack():
	if attack_range and cooldown == true:
		print("damage taken")
		health -= 1
		$Attack_cd.start()
		print(health)
		cooldown = false	


func _on_attack_cd_timeout():
	cooldown = true

func player():
	pass
func _on_animated_sprite_2d_animation_finished():
	if attack_ip:
		attack_ip = false
func shoot():
	var projectile = arrow.instantiate()
	if animation_status == "down":
		projectile.direction = Vector2(0, 1)
	if animation_status == "up":
		projectile.direction = Vector2(0, -1)
	if animation_status == "right":
		projectile.direction = Vector2(1, 0)
	if animation_status == "left":
		projectile.direction = Vector2(-1, 0)
	projectile.position = shoot_point.global_position
	get_tree().current_scene.add_child(projectile)
func update_health():
	health_status.text = "Player Health: " + str(health)
func reset_player():
	health = 3
	player_input = true
	visible = true
