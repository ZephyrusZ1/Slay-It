extends CharacterBody2D



@export var speed = 150 
@onready var Animation_sprite = $AnimatedSprite2D



func _physics_process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("Down"):
		direction.y += 1
		Animation_sprite.play("Walk_down")
	if Input.is_action_pressed("Left"):
		direction.x -= 1
		Animation_sprite.flip_h = true
		Animation_sprite.play("Walk_side")
	if Input.is_action_pressed("Up"):
		direction.y -= 1
		Animation_sprite.play("Walk_up")
	if Input.is_action_pressed("Right"):
		Animation_sprite.flip_h = false
		Animation_sprite.play("Walk_side")
		direction.x += 1
	if direction.x == 0 and direction.y == 0:
		Animation_sprite.play("Idle_down")
	
	if direction.length() > 0:
		direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()


func Animation_trigger():
	pass
	
