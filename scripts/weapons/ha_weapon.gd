extends Weapon

class_name HaWeapon

func _init():
    bullet_speed = 170
    bullet_dmg = 150
    bullet_pircing = 3
    base_spawn_time = 1
    base_spawn_rate = 1

    weapon_name = "HaWeapon"

    bullet_scene = load("res://scenes/prefabs/bullets/ha_bullet.tscn")
    resource = preload("res://scenes/prefabs/weapons/ha_weapon.tscn")

func _ready():
    get_node("WeaponView/ha_box").modulate = Color.WHITE
    get_node("WeaponView/ha_box").color = Color.WHITE
    super._ready()

func _process(delta):
    weapon_lvl = GameManager.weapons["ha_weapon"].weapon_lvl
