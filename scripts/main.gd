extends Node2D

var enemy_scene = load("scences/enemy.tscn")
var enemy_spawn_timer = 3 # seconds
var enemy_spawn_amount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):    
    enemy_spawner(delta) 

func enemy_spawner(delta):
    print(enemy_spawn_timer)
    if enemy_spawn_timer > 0:
        enemy_spawn_timer -= delta
    else:
        print("now")
        for i in range(enemy_spawn_amount):
            var enemy_instance = enemy_scene.instantiate()
            enemy_instance.position = Vector2(randi() % 1000, randi() % 1000)
            add_child(enemy_instance)
        enemy_spawn_timer = 5
