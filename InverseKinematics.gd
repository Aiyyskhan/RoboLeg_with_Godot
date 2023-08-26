extends Node

# func calculate_1(coord: Vector3, c_len: float, f_len: float, t_len: float) -> Dictionary:
# 	var angles = Dictionary()

# 	var l0 = sqrt(coord.z * coord.z + coord.y * coord.y)
# 	var l1 = l0 - c_len
# 	var l2 = sqrt(coord.x * coord.x + l1 * l1)
# 	l2 = l2 if l2 <= (f_len + t_len) else f_len + t_len
# 	var alpha = acos((coord.x / l2)) + acos(((l2 * l2 + f_len * f_len - t_len * t_len) / (2.0 * l2 * f_len)))
# 	var beta = acos(((f_len * f_len + t_len * t_len - l2 * l2) / (2.0 * f_len * t_len)))
# 	var gamma = atan2(coord.z, coord.y) #atan(coord.y / coord.z)

# 	angles.c_ang = PI + gamma #PI / 2.0 - gamma
# 	angles.f_ang = PI / 2.0 - alpha #PI - alpha
# 	angles.t_ang = PI - beta #PI - beta

# 	# print("Target coord: ", coord)
# 	# print("l0: ", l0)
# 	# print("l1: ", l1)
# 	# print("l2: ", l2)
# 	# print("f len: ", f_len)
# 	# print("t len: ", t_len)
# 	# print("alpha: ", alpha)
# 	# print("beta: ", beta)
# 	# print("gamma: ", gamma)

# 	return angles
	
func calculate(coord: Vector3, c_len: float, f_len: float, t_len: float) -> Dictionary:
	var angles = Dictionary()

	var l0 = sqrt(coord.z * coord.z + coord.y * coord.y)
	var l1 = l0 - c_len
	var l2 = sqrt(coord.x * coord.x + l1 * l1)
	l2 = l2 if l2 <= (f_len + t_len) else f_len + t_len
	var alpha = atan2(coord.x, l1) - acos((l2 * l2 + f_len * f_len - t_len * t_len) / (2.0 * l2 * f_len))
	var beta = acos(((f_len * f_len) + (t_len * t_len) - (l2 * l2)) / (2.0 * f_len * t_len))
	var gamma = atan2(coord.z, coord.y) #atan(coord.y / coord.z)

	angles.c_ang = PI + gamma #PI / 2.0 + gamma
	angles.f_ang = alpha #PI + alpha
	angles.t_ang = PI - beta #PI - beta

	# print("Target coord: ", coord)
	# print("l0: ", l0)
	# print("l1: ", l1)
	# print("l2: ", l2)
	# print("f len: ", f_len)
	# print("t len: ", t_len)
	# print("alpha: ", alpha)
	# print("beta: ", beta)
	# print("gamma: ", gamma)

	return angles
