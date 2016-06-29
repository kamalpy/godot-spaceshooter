extends KinematicBody2D

var laser_speed = -5

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var cur_pos = self.get_pos()
	self.move(Vector2(0, laser_speed))
	if cur_pos.y < 0:
		self.queue_free()
	if self.is_colliding():
		var collider = self.get_collider()
		if collider.is_in_group("enemy"):
			globals.score += 1
			self.queue_free()