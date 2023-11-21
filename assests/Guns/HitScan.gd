extends Node3D

const SPEED = 40


signal shot
@onready var ray = $RayCast3D

@onready var rate = $FireRate

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("Shoot") and rate.is_stopped():
		print("Shooting")
		if ray.is_colliding():
			print("Hit")
			
			if ray.get_collider().is_in_group("enemies"):
				print("Shot")
				emit_signal("shot")
				ray.get_collider().hit()
		rate.start()
			
			
