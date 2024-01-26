extends Node2D

var enemy_scene = load("scences/enemy.tscn")
var enemy_spawn_timer = 2 # seconds
var enemy_spawn_amount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):    
    enemy_spawner(delta) 

func enemy_spawner(delta):
    if enemy_spawn_timer > 0:
        enemy_spawn_timer -= delta
    else:
        for i in range(enemy_spawn_amount):
            var enemy_instance = enemy_scene.instantiate()
            add_child(enemy_instance)
            enemy_instance.position = get_legit_spawn()
        enemy_spawn_timer = 5

func get_legit_spawn():
    var res = get_viewport_rect()
    var new_pos = Vector2(randi() % int(res.end.x), randi() % int(res.end.y))
    var min_dist_to_player = res.end.x / 2
        
    while true:
        # has potential to freeze the game - lol
        if get_node("%Player").position.distance_to(new_pos) > min_dist_to_player:
            return new_pos
        else:
            new_pos = Vector2(randi() % int(res.end.x), randi() % int(res.end.y))
        
