extends Area3D

signal body_hit
# Called when the node enters the scene tree for the first time.
func hit(damage):
	print("hit")
	emit_signal("body_hit",damage)



