extends Node2D

var enemies: Array = [
    GrumpyTheCat.new(),
    GrumpyOldMan.new(),
    GrumpyHousePlant.new(),
]

var enemy_spawn_timer = 3 # seconds

var current_start_difficulty = 1
var current_difficulty = 1

var last_enemy_dificulty_increase_timer = 0
var next_enemy_dificulty_increase = 5

var wave_duration = 25 # seconds

var intermediate_scene = load("res://scenes/levels/intermediate.tscn")

var difficulty_timer : Timer = null
var spawn_timer : Timer = null
var wave_timer : Timer = null

# Called when the node enters the scene tree for the first time.
func _ready():
    get_tree().root.add_child.call_deferred(intermediate_scene.instantiate())

    difficulty_timer = get_node("DifficutlyTimer")
    difficulty_timer.start(next_enemy_dificulty_increase)

    spawn_timer = get_node("SpawnTimer")
    spawn_timer.start(enemy_spawn_timer)

    wave_timer = get_node("WaveTimer")
    wave_timer.start(wave_duration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func end_wave():
    get_tree().paused = true

    GameManager.add_wave()

    # Show intermediate window
    get_node("/root/Intermediate").show()
    hide()

    # Prepare for next wave
    current_start_difficulty += 1
    current_difficulty = 3 * current_start_difficulty
    
    # clear all enemies
    for enemy in get_tree().get_nodes_in_group("Enemies"):
        enemy.queue_free()
    for bullet in get_tree().get_nodes_in_group("Bullets"):
        bullet.queue_free()
    for item in get_tree().get_nodes_in_group("Items"):
        item.queue_free()

func _on_difficutly_timer_timeout():
    current_difficulty += 1
    next_enemy_dificulty_increase = next_enemy_dificulty_increase * 1.3

    difficulty_timer.start(next_enemy_dificulty_increase)

func _on_spawn_timer_timeout():
    for e in enemies:
        var enemy_spawn_amount = e.get_enemy_spawn_amount(current_difficulty)
        for i in range(enemy_spawn_amount):
            var enemy_instance = e.create_instance()
            enemy_instance.position = e.get_legit_spawn(get_window().size, get_node("%Player").position)
            add_child(enemy_instance)

    spawn_timer.start(enemy_spawn_timer)

func _on_wave_timer_timeout():
    end_wave()
