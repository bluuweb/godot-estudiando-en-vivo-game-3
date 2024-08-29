extends Area2D

@export var speed = 100
var speed_rotation = 4.0
var enemy_position: Vector2
@export var damage := 50.0 

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += speed_rotation * delta
	if enemy_position:
		Vector2(1,0)
		#position += (enemy_position - position).normalized() * speed * delta
		position += enemy_position * speed * delta
	else:
		position.x -= delta * speed
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_group"):
		# TODO: quitarle vida al enemigo
		#area.queue_free()
		area.damage_received(damage)
		queue_free()

var flag_enemy = true
func _on_enemy_detected_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_group"):
		enemy_position = (area.position - position).normalized()
		print('Enemigo detectado')
		# Solución desconectando la señal
		$EnemyDetected.disconnect("area_entered", _on_enemy_detected_area_entered)
		# solución con flag
		#if flag_enemy:
			#flag_enemy = false
			#enemy_position = area.position
			#print('Enemigo detectado')
		
