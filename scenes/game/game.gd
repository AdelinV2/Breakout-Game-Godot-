extends Node2D


@onready var brick_container = $BrickContainer
@onready var ball = $Ball
@onready var paddle = $Paddle
@onready var timer = $Timer


const BRICK_SCENE = preload("res://scenes/brick/brick.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_bricks()
	SignalManager.die.connect(_die)
	SignalManager.game_won.connect(_die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func generate_bricks() -> void:
	for row in range(GameManager.ROWS):
		var color_index := row * 2 + 1
		
		for col in range(GameManager.COLLUMNS):
			var brick_instance = BRICK_SCENE.instantiate()
			brick_instance.position = Vector2(150 + col * (GameManager.BRICK_WIDTH + 8),
				50 + row * (GameManager.BRICK_HEIGHT + 30))
			
			brick_instance.color_index = color_index
			
			brick_container.add_child(brick_instance)
			

func _die() -> void:
	paddle.set_physics_process(false)
	ball.set_physics_process(false)
	timer.start()


func _on_timer_timeout():
	if GameManager.lives > 0 and ScoreManager.score != GameManager.WIN_SCORE:
		SignalManager.resume_game.emit()
		
		paddle.position = Vector2(640, 640)
		paddle.set_physics_process(true)
		
		ball.position = Vector2(640, 600)
		ball._ready()
		ball.set_physics_process(true)
	
	else:
		ScoreManager.score = 0
		GameManager.lives = 3
		get_tree().reload_current_scene()
	




