extends KinematicBody2D

var enemy_speed = 5

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var cur_pos = self.get_pos()
	if self.is_colliding():
		var collider = self.get_collider()
		self.queue_free()
	self.move(Vector2(0, enemy_speed))
	if cur_pos.y < 0:
		self.queue_free()
