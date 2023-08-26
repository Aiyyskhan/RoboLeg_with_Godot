extends Spatial

var invKin = load("InverseKinematics.gd").new()
var bezier = load("Bezier.gd").new()

var prev_angles = Dictionary()
var c_len = 1.1
var f_len = 2.5
var t_len = 2.3

var cur_angles
onready var skel = $Leg_2/Armature/Skeleton

onready var p0: Node = $p0
onready var p1: Node = $p1
onready var p2: Node = $p2
onready var p3: Node = $p3
onready var target: Node = $target

func _ready():
	prev_angles.c_ang = 0.0
	prev_angles.f_ang = 0.0
	prev_angles.t_ang = 0.0

	set_process(true)
	#var id = skel.find_bone("bone_coxa_1")
	#print("bone id:", id)
	#var parent = skel.get_bone_parent(id)
	#print("bone parent id:", parent)
	#var t = skel.get_bone_global_pose(id)
	#print("bone transform: ", t)

var bone = "bone_coxa_1"
var coordinate = 0

func set_bone_rot(bone_arg, ax, ang):
	var b = skel.find_bone(bone_arg)
	print("Bone idx: ", b)
	var rest = skel.get_bone_pose(b)
	#var rest = skel.get_bone_rest(b)
	
	# var newpose = rest.rotated(Vector3(1.0, 0.0, 0.0), ang.x * delta)
	# newpose = newpose.rotated(Vector3(0.0, 1.0, 0.0), ang.y * delta)
	# newpose = newpose.rotated(Vector3(0.0, 0.0, 1.0), ang.z * delta)
	var newpose = rest.rotated(ax, ang)
	skel.set_bone_pose(b, newpose)
	# skel.set_bone_rest(b, newpose)

var	control_val = 0.0
var return_target = false

func _physics_process(delta):
	if control_val < 1.0 and !return_target:
		control_val += delta * 0.1
		if control_val >= 1.0 :
			return_target = true
	elif control_val > 0.0 and return_target:
		control_val -= delta * 0.1
		if control_val <= 0.0 :
			return_target = false

	target.translation = bezier.getPoint(p0.translation, p1.translation, p2.translation, p3.translation, control_val)
	# target.rotation = bezier.getFDeriv(p0.position, p1.position, p2.position, p3.position, control_val).angle()

	cur_angles = invKin.calculate(target.translation, c_len, f_len, t_len)

	print("Skel translation: ", skel.translation)
	print("Tar translation: ", target.translation)	
	print("Cur angles: ", cur_angles)

	set_bone_rot("bone_coxa_1", Vector3(0.0, 1.0, 0.0), cur_angles.c_ang - prev_angles.c_ang)
	set_bone_rot("bone_femur", Vector3(1.0, 0.0, 0.0), cur_angles.f_ang - prev_angles.f_ang)
	set_bone_rot("bone_tibia", Vector3(1.0, 0.0, 0.0), cur_angles.t_ang - prev_angles.t_ang)

	prev_angles.c_ang = cur_angles.c_ang
	prev_angles.f_ang = cur_angles.f_ang
	prev_angles.t_ang = cur_angles.t_ang


# func _physics_process(delta):
# 	if Input.is_action_pressed("select_coxa"):
# 		bone = "bone_coxa_1"
# 	elif Input.is_action_pressed("select_femur"):
# 		bone = "bone_femur"
# 	elif Input.is_action_pressed("select_tibia"):
# 		bone = "bone_tibia"
# 	elif Input.is_action_pressed("increment"):
# 		if bone == "bone_tibia":
# 			set_bone_rot("bone_tibia", Vector3(1.0, 0.0, 0.0), 1, delta)
# 		elif bone == "bone_femur":
# 			set_bone_rot("bone_femur", Vector3(1.0, 0.0, 0.0), 1, delta)
# 		elif bone == "bone_coxa_1":
# 			set_bone_rot("bone_coxa_1", Vector3(0.0, 1.0, 0.0), 1, delta)
# 	elif Input.is_action_pressed("decrement"):
# 		if bone == "bone_tibia":
# 			set_bone_rot("bone_tibia", Vector3(1.0, 0.0, 0.0), -1, delta)
# 		elif bone == "bone_femur":
# 			set_bone_rot("bone_femur", Vector3(1.0, 0.0, 0.0), -1, delta)
# 		elif bone == "bone_coxa_1":
# 			set_bone_rot("bone_coxa_1", Vector3(0.0, 1.0, 0.0), -1, delta)
