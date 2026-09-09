extends Camera3D

@export var point_a: Marker3D
@export var point_b: Marker3D

var points: Array[Marker3D] = []
var index = 0

func _ready() -> void:
	if point_a != null:
		points.append(point_a)
	if point_b != null:
		points.append(point_b)
	
	
func _input(_event: InputEvent) -> void:
	if points.size() > 0 && Input.is_action_just_pressed("camera_switch"):
		if !current:
			make_current()
		index = (index + 1) % points.size()
		start_camera_transition()

func start_camera_transition():
	var target_rotation := points[index].global_transform.looking_at(points[(index + 1) % points.size()].global_position, Vector3.UP).basis.get_euler()
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", points[index].global_position, 3)
	tween.parallel().tween_property(self, "global_rotation", target_rotation, 3)
