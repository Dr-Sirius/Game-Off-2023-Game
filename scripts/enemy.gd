extends CharacterBody3D


const SPEED = 5.0

@export var player: CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var health_bar = $HealthBar
@onready var gun = $EnemyGun
@onready var attack_timer = $attack
@onready var ray = $RayCast3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var health = 20
@onready var target = player
var state = SURROUND
var random
enum {
	SURROUND,
	ATTACK,
	HIT,
	
}

func _ready():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	random = rand.randf()
	health_bar.text = str(health)
	

func _physics_process(_delta):
	

	match state:
		
		SURROUND:
			
			move(get_ran_pos(random))
		ATTACK:
			
			if global_position.distance_to(target.global_position) >= 10:
				state = SURROUND
			else:
				move(reached(random))
				if attack_timer.is_stopped() and ray.is_colliding() and (ray.get_collider().is_in_group("player") or ray.get_collider().name == "Player"):
					state = HIT
					
		HIT:
			
			gun.enemy_shoot()
			attack_timer.start()
			state = ATTACK
		
			
	
func move(target):
	if not is_on_floor():
		velocity.y -= gravity
	nav_agent.target_position = target
	var next_path = nav_agent.get_next_path_position()
	var new_velocity = (next_path - global_transform.origin).normalized() * SPEED
	nav_agent.set_velocity(new_velocity)
	
	


	
func get_ran_pos(random) -> Vector3:
	var player_circle = target.global_position
	var radius = 5
	var angle = random * PI * 2
	var x = player_circle.x + cos(angle) * radius
	var z = player_circle.z + sin(angle) * radius
	var y = player_circle.y
	return Vector3(x,y,z)

func reached(random) -> Vector3:
	var player_circle = target.global_position
	var radius = 3
	var angle = random * PI * 2
	var x = player_circle.x + cos(angle) * radius
	var z = player_circle.z + sin(angle) * radius
	var y = player_circle.y
	return Vector3(x,y,z)
	
func _on_navigation_agent_3d_velocity_computed(safe_velocity):
		
		velocity = velocity.move_toward(safe_velocity, 0.25)
		if state == ATTACK or state == HIT:
			look_at(Vector3(target.global_position.x+1 ,global_position.y,target.global_position.z),Vector3.UP)
		else:
			look_at(Vector3(target.global_position.x ,global_position.y,target.global_position.z),Vector3.UP)
		move_and_slide()
		



func _on_navigation_agent_3d_navigation_finished():
	state = ATTACK





func _on_hit_box_body_hit(dam):
	
	if health > 0:
		health -= dam
		health_bar.text = str(health)
		if health == 0:
			queue_free()
	if health <= 0:
		queue_free()
