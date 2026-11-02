extends CharacterBody2D

var speed = 75
var player_chase = false
var player
@onready var slime_animation = $AnimatedSprite2D
var health = 3
var player_inattack_zone = false


func _ready():
	slime_animation.play("idle_down")
	
func _physics_process(delta):
	death()
	if player_chase == true and player != null:
		
		var direction = player.position - position
		velocity = direction.normalized() * speed
		move_and_slide()
		if abs(direction.x) > abs(direction.y):
			if(player.position.x - position.x) < 0:
				slime_animation.flip_h = true
				slime_animation.play("move_side")
			elif(player.position.x - position.x) > 0:
				slime_animation.flip_h = false
				slime_animation.play("move_side")
		else:
			if(player.position.y - position.y) < 0:
				slime_animation.play("move_up")
			elif(player.position.y - position.y) > 0:
				slime_animation.play("move_down")
	else:
		velocity = Vector2.ZERO
func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true



func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player = null
		player_chase = false



func _on_slime_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_slime_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		
func death():
	if health <= 0:
		self.queue_free()
