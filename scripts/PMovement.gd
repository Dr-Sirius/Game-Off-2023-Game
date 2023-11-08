class_name PlayerMovement
extends CharacterBody3D


@export var camera: Camera3D
@export var p_stats: PlayerStats
@export var dash_timer: Timer

# Called when the node enters the scene tree for the first time.

var cam_sens: float
var speed: float
var jump_velocity: float
var sprint_mult: float
var air_dash_mult: float
var mouse_captured = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true
	ResourceSaver.save(p_stats)
	cam_sens = p_stats.CameraSens
	speed = p_stats.MoveSpeed
	jump_velocity = p_stats.JumpVelocity
	sprint_mult = p_stats.SprintMultiplier
	air_dash_mult = p_stats.AirDashMultiplier

func _process(_delta):
	cam_sens = p_stats.CameraSens
	speed = p_stats.MoveSpeed
	jump_velocity = p_stats.JumpVelocity
	sprint_mult = p_stats.SprintMultiplier
	air_dash_mult = p_stats.AirDashMultiplier
	if Input.is_action_just_pressed("ui_cancel") and mouse_captured:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_captured = false
		
	elif Input.is_action_just_pressed("ui_cancel") and !mouse_captured:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		mouse_captured = true
		
	

func _unhandled_input(event):
	if event is InputEventMouseMotion and mouse_captured:
		rotate_y(-event.relative.x * cam_sens)
		camera.rotate_x(-event.relative.y * cam_sens)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		#basis = head.basis
	else:
		pass
	


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	
	if Input.is_action_pressed("Sprint") and is_on_floor():
		speed *= sprint_mult
	
	else:
		pass

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		if Input.is_action_just_pressed("Sprint") and dash_timer.is_stopped():
			velocity.x = direction.x * speed * air_dash_mult
			velocity.z = direction.z * speed * air_dash_mult
			dash_timer.start()
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	
	move_and_slide()
	