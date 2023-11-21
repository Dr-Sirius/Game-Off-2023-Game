extends Control

@onready var cross = $CrossHair

@export var before_cross: Texture
@export var after_cross: Texture
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	



func _on_hit_scan_gun_shot():
	cross.texture = after_cross
	await get_tree().create_timer(0.1).timeout
	cross.texture = before_cross
