extends Node3D

var player

@onready var enemy = preload("res://Characters/Enemies/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(get_child_count() - 6)
	if Input.is_action_pressed("ui_text_indent"):
		enemy_spawn(enemy)
	if Input.is_action_just_pressed("1"):
		enemy_spawn(enemy)
		
func enemy_spawn(enemy):
	var instance = enemy.instantiate()
	instance.global_position = Vector3(0,10,0)
	instance.player = player
	add_child(instance)


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		player.global_position = Vector3(0,10,0)
	else:
		remove_child(body)
