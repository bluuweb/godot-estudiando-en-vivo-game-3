extends Area2D

@export var SPEED := 10
@export var damage := 1
var player
#@onready var player: CharacterBody2D = $"../Players/Player"

func _ready() -> void:
	#player = get_parent().get_node("Player")
	player = get_tree().get_nodes_in_group("player_group")[0]

func _process(delta: float) -> void:
	if player:
		var direction = (player.position - position).normalized()
		position += direction * delta * SPEED
		
		$AnimatedSprite2D.flip_h = direction.x > 0

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.decrease_life(damage)
		$TimerDamage.start()

func _on_body_exited(body: Node2D) -> void:
	$TimerDamage.stop()

func _on_timer_damage_timeout() -> void:
	player.decrease_life(damage)

# Alternativa #1: Esto nos sirve para destruir todo lo que esté fuera de este rango 
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("eliminar enemigo screen_notifier")
	queue_free()
