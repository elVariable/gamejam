extends Weapon

class_name HaWeapon

func _init():
    bullet_speed = 170
    bullet_dmg = 150
    bullet_pircing = 3
    base_spawn_time = 1
    base_spawn_rate = 1
    
    get_node("WeaponView/ha_box").modulate = Color.WHITE
    get_node("WeaponView/ha_box").color = Color.WHITE

    bullet_scene = load("res://scenes/prefabs/bullets/ha_bullet.tscn")
