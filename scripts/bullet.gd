extends Area2D

@export var speed = 200
var direction_player: Vector2

@export var damage := 70.0

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	# TODO: de forma aleatoria tire la bullet
	# TODO IDEA: disparar con el mouse
	if direction_player:
		position += speed * delta * direction_player
		$AnimatedSprite2D.rotation = deg_to_rad(90) + direction_player.angle()
	else:
		position.x += speed * delta
		$AnimatedSprite2D.rotation = deg_to_rad(90)
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_group"):
		# TODO: quitarle vida al enemigo
		#area.queue_free()
		area.damage_received(damage)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
