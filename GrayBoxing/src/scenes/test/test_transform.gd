extends Node3D

func attack():
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print(global_transform, " Soy el cuadrado")
	# [X: (1.0, 0.0, 0.0), Y: (0.0, 1.0, 0.0), Z: (0.0, 0.0, 1.0), O: (0.0, 1.128144, -1.975487)]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print(global_transform.basis)
	if Input.is_action_just_pressed("ui_left"):
		rotate_x(deg_to_rad(45))
	if Input.is_action_just_pressed("ui_right"):
		rotate_x(deg_to_rad(-45))
	if Input.is_action_just_pressed("ui_up"):
		rotate_z(deg_to_rad(45))
	if Input.is_action_just_pressed("ui_down"):
		rotate_z(deg_to_rad(-45))
 
