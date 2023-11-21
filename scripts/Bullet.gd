extends Node3D

const SPEED = 40



@onready var mesh = $BulletMesh
@onready var ray = $BulletRay
@onready var particles = $GPUParticles3D


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if ray.is_colliding():
		
		mesh.visible = false
		particles.emitting = true
		ray.enabled = false
		if ray.get_collider().is_in_group("enemies"):
			ray.get_collider().hit()
		
		await get_tree().create_timer(1.0).timeout
		queue_free()


func _on_timer_timeout():
	queue_free()
