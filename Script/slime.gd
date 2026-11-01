extends CharacterBody2D

var speed = 75
var player_chase = false
var player
@onready var slime_animation = $AnimatedSprite2D
var health = 100
var player_inattack_zone = false


func _ready():
	slime_animation.play("idle_down")
	slime()
func _physics_process(delta):
	if player_chase == true:
		deal_damage()
		
		var direction = player.position - position
		position += (player.position - position) / speed
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
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true



func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func slime():
	pass

func _on_slime_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_slime_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		
func deal_damage():
	if player_inattack_zone and Global.player_current_attack == true:
		health -= 10
		print(health)
		if health <= 0:
			self.queue_free()
