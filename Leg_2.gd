extends Spatial

# var coxa_angle = Vector3()
# var femur_angle = Vector3()
# var tibia_angle = Vector3()
var skel

func _ready():
	skel = $Leg_2/Armature/Skeleton
	set_process(true)
	#var id = skel.find_bone("bone_coxa_1")
	#print("bone id:", id)
	#var parent = skel.get_bone_parent(id)
	#print("bone parent id:", parent)
	#var t = skel.get_bone_global_pose(id)
	#print("bone transform: ", t)

var bone = "bone_coxa_1"
var coordinate = 0

func set_bone_rot(bone_arg, ax, ang, delta):
	var b = skel.find_bone(bone_arg)
	var rest = skel.get_bone_pose(b)
	#var rest = skel.get_bone_rest(b)
	
	var newpose = rest.rotated(ax, ang * delta)
	skel.set_bone_pose(b, newpose)
	# skel.set_bone_rest(b, newpose)

func _physics_process(delta):
	if Input.is_action_pressed("select_coxa"):
		bone = "bone_coxa_1"
	elif Input.is_action_pressed("select_femur"):
		bone = "bone_femur"
	elif Input.is_action_pressed("select_tibia"):
		bone = "bone_tibia"
	elif Input.is_action_pressed("increment"):
		if bone == "bone_tibia":
			set_bone_rot("bone_tibia", Vector3(1.0, 0.0, 0.0), 1, delta)
		elif bone == "bone_femur":
			set_bone_rot("bone_femur", Vector3(1.0, 0.0, 0.0), 1, delta)
		elif bone == "bone_coxa_1":
			set_bone_rot("bone_coxa_1", Vector3(0.0, 1.0, 0.0), 1, delta)
	elif Input.is_action_pressed("decrement"):
		if bone == "bone_tibia":
			set_bone_rot("bone_tibia", Vector3(1.0, 0.0, 0.0), -1, delta)
		elif bone == "bone_femur":
			set_bone_rot("bone_femur", Vector3(1.0, 0.0, 0.0), -1, delta)
		elif bone == "bone_coxa_1":
			set_bone_rot("bone_coxa_1", Vector3(0.0, 1.0, 0.0), -1, delta)

# func set_bone_rot(bone_arg, ang, delta):
# 	var b = skel.find_bone(bone_arg)
# 	var rest = skel.get_bone_pose(b)
# 	#var rest = skel.get_bone_rest(b)
	
# 	var newpose = rest.rotated(Vector3(1.0, 0.0, 0.0), ang.x * delta)
# 	newpose = newpose.rotated(Vector3(0.0, 1.0, 0.0), ang.y * delta)
# 	newpose = newpose.rotated(Vector3(0.0, 0.0, 1.0), ang.z * delta)
# 	skel.set_bone_pose(b, newpose)
# 	# skel.set_bone_rest(b, newpose)

# func _physics_process(delta):
# 	if Input.is_action_pressed("select_coxa"):
# 		bone = "bone_coxa_1"
# 	elif Input.is_action_pressed("select_femur"):
# 		bone = "bone_femur"
# 	elif Input.is_action_pressed("select_tibia"):
# 		bone = "bone_tibia"
# 	elif Input.is_action_pressed("increment"):
# 		if bone == "bone_tibia":
# 			tibia_angle[0] = 1
# 			set_bone_rot("bone_tibia", tibia_angle, delta)
# 			tibia_angle[0] = 0
# 		elif bone == "bone_femur":
# 			femur_angle[0] = 1
# 			set_bone_rot("bone_femur", femur_angle, delta)
# 			femur_angle[0] = 0
# 		elif bone == "bone_coxa_1":
# 			coxa_angle[1] = 1
# 			set_bone_rot("bone_coxa_1", coxa_angle, delta)
# 			coxa_angle[1] = 0
# 	elif Input.is_action_pressed("decrement"):
# 		if bone == "bone_tibia":
# 			tibia_angle[0] = -1
# 			set_bone_rot("bone_tibia", tibia_angle, delta)
# 			tibia_angle[0] = 0
# 		elif bone == "bone_femur":
# 			femur_angle[0] = -1
# 			set_bone_rot("bone_femur", femur_angle, delta)
# 			femur_angle[0] = 0
# 		elif bone == "bone_coxa_1":
# 			coxa_angle[1] = -1
# 			set_bone_rot("bone_coxa_1", coxa_angle, delta)
# 			coxa_angle[1] = 0

