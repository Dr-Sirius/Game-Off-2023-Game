extends Node3D

const SPEED = 500



@onready var mesh = $BulletMesh
@onready var ray = $BulletRay
@onready var particles = $GPUParticles3D
var bulletPos
var newPosition
var prevPos
# Called when the node enters the scene tree for the first time.

func _ready():
	bulletPos = global_transform.basis.z
	prevPos = global_transform.origin
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	newPosition = global_transform.origin - (bulletPos * SPEED * delta)
	global_transform.origin = newPosition

	prevPos = newPosition
	
	
	
func _on_timer_timeout():
	queue_free()


func _on_bullet_ray_body_entered(body):
	
	if body is CollisionShape3D:
		
		mesh.visible = false
		particles.emitting = true
		await get_tree().create_timer(1.0).timeout
		queue_free()




func _on_bullet_ray_area_entered(area):
	print("Detected")
	mesh.visible = false
	particles.emitting = true
	if area.is_in_group("enemies"):
		
		area.hit(10)
		
	await get_tree().create_timer(1.0).timeout
	queue_free()
