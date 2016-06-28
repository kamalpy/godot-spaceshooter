extends Node2D

var timer = Timer.new()
var laser_scene = load("res://scenes/laser.tscn")
var enemy_scene = load("res://scenes/enemy.tscn")
onready var score_node = get_node("score")
var move_speed = 4

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	timer.set_one_shot(false)
	timer.set_timer_process_mode(Timer.TIMER_PROCESS_FIXED)
	timer.set_wait_time(1)
	timer.connect("timeout", self, "_add_enemy")
	add_child(timer)
	timer.start()

func calculate_enemy_pos(enemy_size):
	var sizex = get_viewport_rect().size.x
	var pos = rand_range(enemy_size.x/2, sizex - enemy_size.x/2)
	return pos

func _add_enemy():
	var enemy = enemy_scene.instance()
	var enemy_size = enemy.get_node("enemy_body").get_node("enemy_sprite").get_texture().size
	enemy.set_pos(Vector2(calculate_enemy_pos(enemy_size), 20))
	add_child(enemy)

func _fixed_process(delta):
	score_node.set_text("Score: " + str(globals.score))
	var spaceship = get_node("spaceship")
	var spaceship_size = spaceship.get_node("sprite").get_texture().size
	var sizex = get_viewport_rect().size.x
	var cur_pos = spaceship.get_pos()
	if spaceship.is_colliding():
		spaceship.set_pos(Vector2(get_viewport_rect().size.x/2, cur_pos.y))
		globals.score = 0
	if (cur_pos.x + spaceship_size.x/2) > sizex:
		spaceship.set_pos(Vector2(sizex - spaceship_size.x/2, cur_pos.y))
	if (cur_pos.x - spaceship_size.x/2 < 0):
		spaceship.set_pos(Vector2(spaceship_size.x/2, cur_pos.y))

func _input(event):
	var spaceship = get_node("spaceship")
	var cur_pos = spaceship.get_pos()
	if event.is_action_pressed("fire"):
		var laser = laser_scene.instance()
		laser.set_pos(Vector2(cur_pos.x, cur_pos.y))
		add_child(laser)
	if event.is_action("move_left"):
		spaceship.move(Vector2(-move_speed, 0))
	if event.is_action("move_right"):
		spaceship.move(Vector2(move_speed, 0))

