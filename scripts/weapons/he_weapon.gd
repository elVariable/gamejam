extends Weapon

class_name HeWeapon

func _init():
    bullet_speed = 700
    bullet_dmg = 10
    bullet_pircing = 1
    base_spawn_time = 0.1
    base_spawn_rate = 1

    weapon_name = "HeWeapon"

    bullet_scene = load("res://scenes/prefabs/bullets/he_bullet.tscn")
    resource = preload("res://scenes/prefabs/weapons/he_weapon.tscn")

func _ready():
    get_node("WeaponView/he_box").modulate = Color.WHITE
    get_node("WeaponView/he_box").color = Color.WHITE
    super._ready()

func _process(delta):
    weapon_lvl = GameManager.weapons["he_weapon"].weapon_lvl
