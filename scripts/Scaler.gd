extends Node

@export var actors: Array[CharacterBody3D]


func _process(delta):
	if Input.is_action_just_pressed("wheel_down"):
		actor_scaler(actors,1.2)
	if Input.is_action_just_pressed("wheel_up"):
		actor_scaler(actors,0.83)

func actor_scaler(actors: Array[CharacterBody3D],factor):
	print("gs")
	for actor in actors:
		actor.scale.x /= factor
		actor.scale.y /= factor
		actor.scale.z /= factor
		print(actor.scale)
		
