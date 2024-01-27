extends Weapon

class_name HiWeapon

func _init():
    bullet_speed = 1000
    bullet_dmg = 20
    bullet_pircing = 1
    base_spawn_time = 0.15
    base_spawn_rate = 1

    bullet_scene = load("res://scenes/prefabs/bullets/hi_bullet.tscn")
