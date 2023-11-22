extends Node3D

const SPEED = 40


signal shot
@onready var ray = $RayCast3D
@onready var barrel = $Barrel
@onready var rate = $FireRate

@export var dam: float
# Called when the node enters the scene tree for the first time.
var bullet = load("res://assests/Guns/Bullet.tscn")
var instance
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("Shoot"):
		instance = bullet.instantiate()
		
		barrel.add_child(instance)
		
		
			
			#if ray.get_collider().is_in_group("enemies"):
				
				#emit_signal("shot")
				#ray.get_collider().hit(dam)
		
	

			
