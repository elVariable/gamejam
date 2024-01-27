extends Weapon

class_name HeWeapon

func _init():
    bullet_speed = 1700
    bullet_dmg = 10
    bullet_pircing = 1
    base_spawn_time = 0.1
    base_spawn_rate = 1
    bullet_scale = Vector2(7.3, 7.3)

    bullet_scene = load("res://scenes/prefabs/bullets/he_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass
