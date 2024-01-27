# This script is an autoload, that can be accessed from any other script!

extends Node2D

var score : int = 0
var death_counter : int = 0
var is_game_over : bool = false

func _process(delta):
    check_exit()

func do_restart():
    score = 0
    is_game_over = false

# Adds 1 to score variable
func add_score(num = 1):
    score += num

func add_death():
    death_counter += 1
    print(death_counter)

## Loads next level
#func load_next_level(next_scene : PackedScene):
    #get_tree().change_scene_to_packed(next_scene)
func check_exit():
    if Input.is_action_just_pressed("Exit"):
        get_tree().quit()

func trigger_game_over():
    if not is_game_over:
        is_game_over = true
        get_tree().change_scene_to_file("res://scenes/levels/game_over.tscn")
