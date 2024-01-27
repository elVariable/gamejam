extends Node2D


var enemy_scene = load("scenes/prefabs/enemy.tscn")
var enemy_spawn_timer = 3 # seconds
var last_enemy_spawn_time = 0
var current_start_difficulty = 1
var current_difficulty = 1
var enemy_spawn_amount = 2
var last_enemy_dificulty_increase_timer = 0
var next_enemy_dificulty_increase = 5

var wave_duration = 30 # seconds

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    update_enemy_difficulty(delta)
    enemy_spawner(delta) 

func update_enemy_difficulty(delta):
    if last_enemy_dificulty_increase_timer > next_enemy_dificulty_increase:
        current_difficulty += 1
        enemy_spawn_amount += 2 * current_difficulty
        last_enemy_dificulty_increase_timer = 0
        next_enemy_dificulty_increase = next_enemy_dificulty_increase * 1.3
    else:
        last_enemy_dificulty_increase_timer += delta

func enemy_spawner(delta):
    if last_enemy_spawn_time < enemy_spawn_timer:
        last_enemy_spawn_time += delta
    else:
        for i in range(enemy_spawn_amount):
            var enemy_instance = enemy_scene.instantiate()
            add_child(enemy_instance)
            enemy_instance.position = get_legit_spawn()
        last_enemy_spawn_time = 0

func get_legit_spawn():
    var res = get_viewport_rect()
    var new_pos = Vector2(randi() % int(res.end.x), randi() % int(res.end.y))
    var min_dist_to_player = res.end.x / 2.5
        
    while true:
        # has potential to freeze the game - lol
        if get_node("%Player").position.distance_to(new_pos) > min_dist_to_player:
            return new_pos
        else:
            new_pos = Vector2(randi() % int(res.end.x), randi() % int(res.end.y))

func end_wave():
    # load intermediate
    # pause game
    # clear enemies
    # set start difficulty
    pass
