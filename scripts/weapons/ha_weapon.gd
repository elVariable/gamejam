extends Weapon

class_name HaWeapon

func _init():
    bullet_speed = 170
    bullet_dmg = 150
    bullet_pircing = 3
    base_spawn_time = 1
    base_spawn_rate = 1

    bullet_scene = load("res://scenes/prefabs/bullets/ha_bullet.tscn")
