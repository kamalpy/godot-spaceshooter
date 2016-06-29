extends Node2D

var timer = Timer.new()
var laser_scene = load("res://scenes/laser.tscn")
var enemy_scene = load("res://scenes/enemy.tscn")
var spaceship_scene = load("res://scenes/spaceship.tscn")
onready var score_node = get_node("score")
var spaceship = null

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	spaceship = spaceship_scene.instance()
	spaceship.set_pos(Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y - 20))
	add_child(spaceship)
	timer.set_one_shot(false)
	timer.set_timer_process_mode(Timer.TIMER_PROCESS_FIXED)
	timer.set_wait_time(1)
	timer.connect("timeout", self, "_add_enemy")
	add_child(timer)
	timer.start()

func restart_game():
	var children = get_children()
	for child in children:
		if child.is_in_group("enemy") or child.is_in_group("laser"):
			child.queue_free()
	spaceship.set_pos(Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y - 20))
	globals.score = 0


func calculate_enemy_pos(enemy_size):
	var sizex = get_viewport_rect().size.x
	var pos = rand_range(enemy_size.x/2, sizex - enemy_size.x/2)
	return pos

func _add_enemy():
	var enemy = enemy_scene.instance()
	var enemy_size = enemy.get_node("sprite").get_texture().size
	enemy.set_pos(Vector2(calculate_enemy_pos(enemy_size), 20))
	add_child(enemy)

func _fixed_process(delta):
	score_node.set_text("Score: " + str(globals.score))
	var spaceship_size = spaceship.get_node("sprite").get_texture().size
	var sizex = get_viewport_rect().size.x
	var cur_pos = spaceship.get_pos()

	if (cur_pos.x + spaceship_size.x/2) > sizex:
		spaceship.set_pos(Vector2(sizex - spaceship_size.x/2, cur_pos.y))
	if (cur_pos.x - spaceship_size.x/2 < 0):
		spaceship.set_pos(Vector2(spaceship_size.x/2, cur_pos.y))

func _input(event):
	var cur_pos = spaceship.get_pos()
	if event.is_action_pressed("fire"):
		var laser = laser_scene.instance()
		var spaceship_pos = spaceship.get_pos()
		var spaceship_sprite_size = spaceship.get_node('sprite').get_texture().size
		laser.set_pos(Vector2(spaceship_pos.x, spaceship_pos.y - spaceship_sprite_size.y/2))
		add_child(laser)
	if event.is_action("move_left"):
		spaceship.move(Vector2(-spaceship.move_speed, 0))
	if event.is_action("move_right"):
		spaceship.move(Vector2(spaceship.move_speed, 0))

