extends KinematicBody

puppet var puppet_pos = Vector3()
puppet var puppet_motion = Vector3()

func _ready():
	pass

func _physics_process(_delta):
	var motion = Vector3()

	if is_network_master():
		if Input.is_action_pressed("ui_left"):
			motion += Vector3(-0.01, 0, 0)
		if Input.is_action_pressed("ui_right"):
			motion += Vector3(0.01, 0, 0)
		if Input.is_action_pressed("ui_up"):
			motion += Vector3(0, 0.01, 0)
		if Input.is_action_pressed("ui_down"):
			motion += Vector3(0, -0.01, 0)

		rset("puppet_motion", motion)
		rset("puppet_pos", translation)
	
	else:
		translation = puppet_pos
		motion = puppet_motion
	
	move_and_collide(motion)
	
	if get_tree().is_network_server():
		Network.update_position(int(name), translation)


func init(nickname, start_position, is_slave):
	
	translation = start_position
	if is_slave:
#		$Sprite.texture = load('res://player/player-alt.png')
		$MeshInstance.get_surface_material(0).albedo_color = Color(50, 250, 50, 250)