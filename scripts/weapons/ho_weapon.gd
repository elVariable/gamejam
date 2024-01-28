extends Weapon

class_name HoWeapon

func _init():
    bullet_speed = 100
    bullet_dmg = 100
    bullet_pircing = 10
    base_spawn_time = 2
    base_spawn_rate = 1

    weapon_name = "HoWeapon"

    bullet_scene = load("res://scenes/prefabs/bullets/ho_bullet.tscn")
    resource = preload("res://scenes/prefabs/weapons/ho_weapon.tscn")

func _ready():
    get_node("WeaponView/ho_box").modulate = Color.WHITE
    get_node("WeaponView/ho_box").color = Color.WHITE
    super._ready()
