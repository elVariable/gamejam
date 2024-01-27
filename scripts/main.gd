extends Node2D

var enemies: Array = [
    GrumpyTheCat.new(),
    GrumpyOldMan.new(),
    GrumpyHousePlant.new(),
]

var enemy_spawn_timer = 3 # seconds
var last_enemy_spawn_time = 0
var current_start_difficulty = 1
var current_difficulty = 1

var last_enemy_dificulty_increase_timer = 0
var next_enemy_dificulty_increase = 5

var wave_duration = 40 # seconds
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
        last_enemy_dificulty_increase_timer = 0
        next_enemy_dificulty_increase = next_enemy_dificulty_increase * 1.3
    else:
        last_enemy_dificulty_increase_timer += delta

func enemy_spawner(delta):
    if last_enemy_spawn_time < enemy_spawn_timer:
        last_enemy_spawn_time += delta
    else:
        for e in enemies:
            var enemy_spawn_amount = e.get_enemy_spawn_amount(current_difficulty)
            for i in range(enemy_spawn_amount):
                var enemy_instance = e.create_instance()
                add_child(enemy_instance)
                enemy_instance.position = e.get_legit_spawn(get_window().size, get_node("%Player").position)
            last_enemy_spawn_time = 0

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
    for item in get_tree().get_nodes_in_group("Items"):
        item.queue_free()
