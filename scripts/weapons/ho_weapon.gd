extends Weapon

class_name HoWeapon

func _init():
    bullet_speed = 100
    bullet_dmg = 100
    bullet_pircing = 10
    base_spawn_time = 2
    base_spawn_rate = 1

    bullet_scene = load("res://scenes/prefabs/bullets/ho_bullet.tscn")
