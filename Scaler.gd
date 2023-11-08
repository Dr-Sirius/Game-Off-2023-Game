extends Node

@export var actors: Array[CharacterBody3D]


func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		actor_scaler(actors)

func actor_scaler(actors: Array[CharacterBody3D]):
	print("gs")
	for actor in actors:
		actor.scale.x /= 1.2
		actor.scale.y /= 1.2
		actor.scale.z /= 1.2
		print(actor.scale)
		
