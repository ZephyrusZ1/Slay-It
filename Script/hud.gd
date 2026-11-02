extends CanvasLayer

@onready var wave_counter = $Wave_counter
@onready var start_button = $Start_Button
signal start_game


func _on_start_button_pressed():
	$Start_Button.hide()
	start_game.emit()
	
func update_wave_count(wave_number):
	wave_counter.text = "Wave " + str(wave_number)

func show_game_over():
	wave_counter.text = "Game Over!"
	start_button.show()
	
func game_over():
	wave_counter.text = "Game Over!"
	start_button.show()
