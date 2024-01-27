extends Weapon

class_name HoWeapon

func _init():
    bullet_speed = 1700
    bullet_dmg = 10
    bullet_pircing = 10
    base_spawn_time = 10
    base_spawn_rate = 1
    bullet_scale = Vector2(3, 3)

    bullet_scene = load("res://scenes/prefabs/bullets/ho_bullet.tscn")
