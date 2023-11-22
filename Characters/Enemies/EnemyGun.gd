extends Node3D

const SPEED = 40


signal shot
@onready var ray = $RayCast3D

@onready var rate = $FireRate

@export var dam: float
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func enemy_shoot():
	
	if ray.is_colliding():
		if ray.get_collider().is_in_group("player") and rate.is_stopped():
			
			
			ray.get_collider().hit(dam)
		
		rate.start()
			
