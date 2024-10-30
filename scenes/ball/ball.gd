extends CharacterBody2D


const SPEED: float = 400.0


func _ready():
	velocity = Vector2(0, -SPEED)
	
	
func _physics_process(delta):
	move_ball(delta)


func move_ball(delta) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var body = collision.get_collider().name
		
		if body == "Floor":
			SignalManager.die.emit()
		
		elif body == "Paddle":
			velocity = global_position - collision.get_collider().global_position
			velocity = velocity.normalized() * SPEED

		else:
			velocity = velocity.bounce(collision.get_normal())


