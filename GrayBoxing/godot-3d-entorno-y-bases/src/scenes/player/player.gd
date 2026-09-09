class_name PlayerController
extends CharacterBody3D


@export var speed := 5.0
@export var acceleration := 20.0
@export var jump_velocity := 5.0
@export var camera_player: CameraPlayer


func _physics_process(delta: float) -> void:
	# Obtengo hacia donde presionó el usuario como un vector 2D (x,y)
	var input: Vector2 = Input.get_vector("player_left", "player_right", "player_forward", "player_back")

	# Obtengo la direción en espacio 3D aplicando la direción 3D al basis actual y normalizando.
	var direction: Vector3 = (transform.basis * Vector3(input.x, 0.0, input.y)).normalized()

	# Convertimos el movimiento al espacio del Player
	#direction = direction.rotated(Vector3.UP, camera_player.global_rotation.y)

	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = jump_velocity
	if direction.length() > 0.0:
		# Aplicamos cambios en la velocidad dada la dirección y speed que definimos.
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
		velocity.z = move_toward(velocity.z, direction.z * speed, acceleration * delta)
	else:
		# Desacelera si no hay movimiento o dirección aplicada (no hay tecla presionada)
		velocity.x = move_toward(velocity.x, 0.0, acceleration * delta)
		velocity.z = move_toward(velocity.z, 0.0, acceleration * delta)

	move_and_slide()
