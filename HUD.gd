extends CanvasLayer

signal start_game

func update_score(score):
	$ScoreLabel.text = str(score)

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Dodge the Creeps"
	$MessageLabel.show()
	$InstructionsLabel.show()
	$Button.show()
	yield(get_tree().create_timer(1.0), "timeout")


func _on_Button_pressed():
	$Button.hide()
	$InstructionsLabel.hide()
	self.emit_signal("start_game")


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
