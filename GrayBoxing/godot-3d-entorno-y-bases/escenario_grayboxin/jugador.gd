extends CharacterBody3D


@export var velocidad := 5.0
@export var aceleracion := 20.0
@export var velocidad_de_salto := 5.0
@export var camara: CameraPlayer
@export var saltos_maximos := 2
var saltos_restantes := saltos_maximos

func _physics_process(delta: float) -> void:
	# Obtengo hacia donde presionó el usuario como un vector 2D (x,y)
	var input: Vector2 = Input.get_vector("player_left", "player_right", "player_forward", "player_back")

	# Obtengo la direción en espacio 3D aplicando la direción 3D al basis actual y normalizando.
	var direction: Vector3 = (transform.basis * Vector3(input.x, 0.0, input.y)).normalized()
	
	if is_on_floor():
		saltos_restantes = saltos_maximos
	else:
		velocity.y += get_gravity().y * delta
	# Convertimos el movimiento al espacio del Player
	#direction = direction.rotated(Vector3.UP, camera_player.global_rotation.y)

	
	if Input.is_action_just_pressed("player_jump") and saltos_restantes > 0:
		velocity.y = velocidad_de_salto
		saltos_restantes -= 1
	if direction.length() > 0.0:
		# Aplicamos cambios en la velocidad dada la dirección y speed que definimos.
		velocity.x = move_toward(velocity.x, direction.x * velocidad, aceleracion * delta)
		velocity.z = move_toward(velocity.z, direction.z * velocidad, aceleracion * delta)
	else:
		# Desacelera si no hay movimiento o dirección aplicada (no hay tecla presionada)
		velocity.x = move_toward(velocity.x, 0.0, aceleracion * delta)
		velocity.z = move_toward(velocity.z, 0.0, aceleracion * delta)

	move_and_slide()
