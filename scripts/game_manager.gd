# This script is an autoload, that can be accessed from any other script!

extends Node2D

var score : int = 0
var death_counter : int = 0
var is_game_over : bool = false
var wave : int = 1
var kills : int = 0

var default_bullet_speed : int = 100
var default_bullet_dmg : int = 20
var default_bullet_direction: Vector2 = Vector2(0, 0)
var default_bullet_pircing: int = 1

var last_restart_time = 0

var weapons: Dictionary = {
    "ha_weapon" : HaWeapon.new(), 
    "he_weapon" : HeWeapon.new(),
    "hi_weapon" : HiWeapon.new(),
    "ho_weapon" : HoWeapon.new(),
}

func _process(delta):
    check_exit()

func do_restart():
    score = 0
    kills = 0
    wave = 1
    last_restart_time = Time.get_ticks_msec()
    is_game_over = false

    for w in weapons.values():
        w.weapon_lvl = 1

# Adds 1 to score variable
func add_score(num = 1):
    score += num

func add_kills(num = 1):
    kills += num

func add_death():
    death_counter += 1

func add_wave():
    wave += 1

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
