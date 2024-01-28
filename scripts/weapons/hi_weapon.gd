extends Weapon

class_name HiWeapon

func _init():
    bullet_speed = 1000
    bullet_dmg = 20
    bullet_pircing = 1
    base_spawn_time = 0.15
    base_spawn_rate = 1

    weapon_name = "HiWeapon"

    bullet_scene = load("res://scenes/prefabs/bullets/hi_bullet.tscn")
    resource = preload("res://scenes/prefabs/weapons/hi_weapon.tscn")

func _ready():
    get_node("WeaponView/hi_box").modulate = Color.WHITE
    get_node("WeaponView/hi_box").color = Color.WHITE
    super._ready()
