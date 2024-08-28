extends CharacterBody2D


const SPEED = 50.0

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		$AnimatedSprite2D.flip_h = direction.x > 0
		$AnimatedSprite2D.play("run")
	else:
		velocity = Vector2(0,0)
		$AnimatedSprite2D.play("idle")

	move_and_slide()

func death():
	print('me morisí')
