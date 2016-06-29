extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

var move_speed = 5

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	print('ready')

func _on_collision_body_enter( body ):
	print(body)
	if body.is_in_group("enemy"):
		queue_free()
		globals.score = 0


func _on_collision_area_enter( area ):
	print(area)


func _on_collision_body_enter_shape( body_id, body, body_shape, area_shape ):
	print('here')
