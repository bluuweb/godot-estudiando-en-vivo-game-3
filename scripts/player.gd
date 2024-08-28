extends CharacterBody2D
class_name Player

@export var SPEED = 50.0
@export var life = 100
@export var bullet_scene: PackedScene

func _ready() -> void:
	$ProgressBar.value = life

func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print('espacio')
		create_bullet()

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
	
func decrease_life(value):
	life -= value
	$ProgressBar.value = life
	if life == 0:
		death()

func death():
	print('me morisí')

# Alternativa #2: Esto nos sirve para destruir todo lo que esté fuera de este rango
func _on_limit_enemy_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy_group"):
		area.queue_free()
		print('enemigo eliminado por salir de los límites del player')

func create_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	get_parent().add_child(bullet)
	
