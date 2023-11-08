extends CharacterBody3D


const SPEED = 5.0

@export var player: CharacterBody3D
@export var max_dist: int

@onready var nav_agent = $NavigationAgent3D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	
	nav_agent.target_position = player.global_transform.origin 
	var next_path = nav_agent.get_next_path_position()
	var new_velocity = (next_path - global_transform.origin).normalized() * SPEED
	nav_agent.set_velocity(new_velocity)
	
	
func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	if global_transform.origin.distance_to(player.global_transform.origin) <= max_dist:
		velocity = velocity.move_toward(safe_velocity, 0)

	else:
		velocity = velocity.move_toward(safe_velocity, 0.25)
		look_at(Vector3(player.global_position.x,global_position.y,player.global_position.z),Vector3.UP)
		move_and_slide()

