extends Node2D

var enemy_speed = 5
onready var enemy = get_node("enemy_body")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var cur_pos = get_pos()
	if enemy.is_colliding():
		var collider = enemy.get_collider()
		queue_free()
	enemy.move(Vector2(0, enemy_speed))
	if cur_pos.y < 0:
		self.queue_free()
