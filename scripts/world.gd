extends Node

@export var enemy_scene: PackedScene

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func create_enemy():
	var player = $Player
	var enemy = enemy_scene.instantiate()
	
	# Generar un ángulo aleatorio en radianes
	var angle = randf() * PI * 2
	
	# Generar una distancia aleatoria entre 100 y 200 píxeles (por ejemplo)
	var distance = randf_range(270, 300)

	# Convertir a coordenadas cartesianas para obtener la posición del enemigo
	var offset = Vector2(cos(angle), sin(angle)) * distance
	
	# Calcular la posición del enemigo basada en la posición del jugador más el offset
	enemy.position = player.position + offset
	
	# TODO: destruir enemigos si salen de un rango

	add_child(enemy)

func _on_timer_create_enemy_timeout() -> void:
	create_enemy()
	# TODO: tener su propio timer para los bullet
	
