extends Area2D

@export var speed = 200

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	$AnimatedSprite2D.rotate(90)
	# TODO: de forma aleatoria tire la bullet
	# TODO IDEA: disparar con el mouse
	position.x += speed * delta
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_group"):
		# TODO: quitarle vida al enemigo
		area.queue_free()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
