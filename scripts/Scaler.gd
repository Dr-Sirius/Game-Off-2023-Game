extends Node

@export var actors: Array[CharacterBody3D]

@onready var actors_scale = actors[0].scale
func _process(delta):
	if Input.is_action_just_pressed("wheel_down"):
		actor_scaler(actors,1.2)
	if Input.is_action_just_pressed("wheel_up"):
		actor_scaler(actors,0.83)
	if Input.is_action_just_pressed("2"):
		actor_origin(0)

func actor_scaler(actors: Array[CharacterBody3D],factor):
	print("gs")
	for actor in actors:
		print(actor.speed)
		actor.scale.x /= factor
		actor.scale.y /= factor
		actor.scale.z /= factor
		#actor.p_stats.MoveSpeed /= factor
		print(actor.scale)

func actor_origin(actor_index: int):
	actors[actor_index].scale.x = actors_scale.x
	actors[actor_index].scale.y = actors_scale.y
	actors[actor_index].scale.z = actors_scale.z
		
