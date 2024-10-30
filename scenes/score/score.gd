extends Control


@onready var score = $CanvasLayer/MC/HBoxContainer/Score
@onready var die_label = $CanvasLayer/MC/VBoxContainer2/DieLabel
@onready var go_sound = $GOSound
@onready var score_sound = $ScoreSound


func _ready():
	SignalManager.die.connect(_die)
	SignalManager.brick_destroyed.connect(_increase_score)
	SignalManager.resume_game.connect(_resume)


func _increase_score() -> void:
	score.text = str(ScoreManager.score)
	score_sound.play()
	
	if ScoreManager.score == GameManager.WIN_SCORE:
		SignalManager.game_won.emit()
		die_label.text = "you win!"
		die_label.show()


func _die() -> void:
	go_sound.play()
	
	if GameManager.lives == 0:
		die_label.text = "game over"
		die_label.show()
	
	else:
		die_label.show()


func _resume() -> void:
	die_label.hide()
	
