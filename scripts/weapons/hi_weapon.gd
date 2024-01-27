extends Weapon

class_name HiWeapon

func _init():
    bullet_speed = 1000
    bullet_dmg = 20
    bullet_pircing = 1
    base_spawn_time = 0.15
    base_spawn_rate = 1
    
    get_node("WeaponView/hi_box").modulate = Color.WHITE
    get_node("WeaponView/hi_box").color = Color.WHITE

    bullet_scene = load("res://scenes/prefabs/bullets/hi_bullet.tscn")
