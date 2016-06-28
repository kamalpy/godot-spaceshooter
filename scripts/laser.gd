extends Node2D

var laser_speed = -5
onready var laser = get_node("laser_body")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var cur_pos = get_pos()
	laser.move(Vector2(0, laser_speed))
	if cur_pos.y < 0:
		self.queue_free()
	if laser.is_colliding():
		var collider = laser.get_collider()
		if collider.is_in_group("enemy"):
			globals.score += 1
			self.queue_free()