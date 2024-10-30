extends Control


@onready var score = $MC/VBoxContainer/HBoxContainer/Score
@onready var die_label = $MC/VBoxContainer/VBoxContainer/DieLabel




func _ready():
	SignalManager.die.connect(_die)
	SignalManager.brick_destroyed.connect(_increase_score)


func _increase_score():
	score.text = str(ScoreManager.score)


func _die():
	
	if GameManager.lives == 0:
		die_label.text = "game over"
		die_label.show()
	
	else:
		die_label.show()
