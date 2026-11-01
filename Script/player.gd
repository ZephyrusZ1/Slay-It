extends CharacterBody2D


	
@export var speed = 150 
@onready var Animation_sprite = $AnimatedSprite2D
var animation_status = ""


func _physics_process(delta):
	player_movement(delta)


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
	
