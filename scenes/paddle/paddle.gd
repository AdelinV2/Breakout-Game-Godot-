extends CharacterBody2D


@onready var animated_sprite_2d = $AnimatedSprite2D


func _ready():
	velocity = Vector2(0.0, 0.0)


func move_paddle():
	var axis = Input.get_axis("a", "d")
	velocity = Vector2(axis * GameManager.PADDLE_SPEED, 0)
	
	move_and_slide()

func _physics_process(delta):
	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 80, 1200)
	move_paddle()


