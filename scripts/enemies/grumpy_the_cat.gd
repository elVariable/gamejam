extends Enemy

class_name GrumpyTheCat

func _init():
    resource = preload("res://scenes/prefabs/enemies/grumpy_the_cat.tscn")

func _ready():
    pass

func get_enemy_spawn_amount(
    difficulty: int,
):
    return pow(1.2, difficulty)
