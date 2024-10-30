extends Control


@onready var heart_sprite = $HeartSprite
@onready var heart_sprite_2 = $HeartSprite2
@onready var heart_sprite_3 = $HeartSprite3


func _ready():
	SignalManager.die.connect(_die)


func _die():
	GameManager.lives -= 1
	
	if GameManager.lives == 2:
		heart_sprite_3.hide()
	
	elif GameManager.lives == 1:
		heart_sprite_2.hide()
	
	elif GameManager.lives == 0:
		heart_sprite.hide()
