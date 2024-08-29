extends CharacterBody2D
class_name Player

@export var SPEED = 50.0
@export var life = 100
@export var bullet_sword_scene: PackedScene
@export var bullet_thor_scene: PackedScene

var direction_player: Vector2

func _ready() -> void:
	$ProgressBar.value = life

func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#print('espacio')
		#create_bullet()
	pass

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		$AnimatedSprite2D.flip_h = direction.x < 0
		$AnimatedSprite2D.play("run")
		direction_player = direction
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

func create_bullet_sword():
	var bullet = bullet_sword_scene.instantiate()
	bullet.position = position
	bullet.direction_player = direction_player
	get_parent().add_child(bullet)

func _on_timer_sworm_arm_timeout() -> void:
	create_bullet_sword()
	
	
func create_bullet_thor():
	var bullet = bullet_thor_scene.instantiate()
	bullet.position = position
	get_parent().add_child(bullet)


func _on_timer_thor_arm_timeout() -> void:
	create_bullet_thor()
