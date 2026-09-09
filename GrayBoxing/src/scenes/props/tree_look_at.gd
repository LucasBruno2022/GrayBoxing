class_name TreeLookAt
extends Sprite3D

@export var player_controller: PlayerController

func _physics_process(_delta: float) -> void:
	if player_controller != null:
		# Tomo la posición global del player pero reemplazo la coordenada Y para que no cambie la altura.
		var target: Vector3 = player_controller.global_position
		target.y = global_position.y
		look_at(target)
