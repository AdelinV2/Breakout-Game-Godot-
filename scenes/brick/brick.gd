extends StaticBody2D


@export var color_index: int = 0


@onready var sprite_2d = $Sprite2D

var damage: int = 0
var brick_textures: Array

func _ready():
	ImageManager.load_brick_images()
	update_texture()


func update_texture() -> void:
	sprite_2d.texture = ImageManager.brick_images[color_index * 2 + damage]["brick_texture"]
	

func take_damage():
	damage += 1
	if damage > 1:
		ScoreManager.score += 1
		SignalManager.brick_destroyed.emit()
		queue_free()
	
	else:
		update_texture()


func _on_brick_body_entered(body):
	if body.name == "Ball":
		take_damage()
