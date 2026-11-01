extends CharacterBody2D

var attack_range = false
var cooldown = true
var health = 100
var player_status = true
var attack_ip = false
	
@export var speed = 150 
@onready var Animation_sprite = $AnimatedSprite2D
var animation_status = ""

func _ready():
	pass
func _physics_process(delta):
	player_movement(delta)
	slime_attack()
	
	if health <= 0:
		player_status = false
		health = 0
		print("player died")
		self.queue_free()
func player_movement(delta):
	if Input.is_action_pressed("Down"):
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
	elif Input.is_action_just_pressed("attack"):
		velocity.x = 0
		velocity.y = 0
		Animation_sprite.play("Attack_down")
		
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
	



func _on_player_hitbox_body_entered(body):
	if body.has_method("slime"):
		attack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("slime"):
		attack_range = false

func slime_attack():
	if attack_range and cooldown == true:
		print("damage taken")
		health -= 20
		$Attack_cd.start()
		print(health)
		cooldown = false	


func _on_attack_cd_timeout():
	cooldown = true
