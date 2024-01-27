extends Node2D


var enemies: Dictionary = {
    "grumpy_cat" : preload("res://scenes/prefabs/enemies/grumpy_the_cat.tscn"),
    "grumpy_old_man" : preload("res://scenes/prefabs/enemies/grumpy_old_man.tscn"),
    "grumpy_house_plant" : preload("res://scenes/prefabs/enemies/grumpy_house_plant.tscn"),
}
var enemy_scene = enemies["grumpy_old_man"]

var enemy_spawn_timer = 3 # seconds
var last_enemy_spawn_time = 0
var current_start_difficulty = 1
var current_difficulty = 1
var enemy_spawn_amount = 2
var last_enemy_dificulty_increase_timer = 0
var next_enemy_dificulty_increase = 5

var wave_duration = 5 # seconds
var current_wave_duration = 0

var intermediate_scene = load("res://scenes/levels/intermediate.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    get_tree().root.add_child.call_deferred(intermediate_scene.instantiate())
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    update_enemy_difficulty(delta)
    enemy_spawner(delta)
    
    current_wave_duration += delta
    if current_wave_duration > wave_duration:
        end_wave()

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
    get_tree().paused = true

    GameManager.add_wave()

    # Show intermediate window
    get_node("/root/Intermediate").show()
    hide()

    # Prepare for next wave
    current_start_difficulty += 1
    current_wave_duration = 0
    current_difficulty = 3 * current_start_difficulty
    
    # clear all enemies
    for enemy in get_tree().get_nodes_in_group("Enemies"):
        enemy.queue_free()
    for bullet in get_tree().get_nodes_in_group("Bullets"):
        bullet.queue_free()
