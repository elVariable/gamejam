extends Enemy

class_name GrumpyHousePlant

func _init():
    resource = preload("res://scenes/prefabs/enemies/grumpy_house_plant.tscn")

func _ready():
    pass

func get_enemy_spawn_amount(
    difficulty: int,
):
    var enemy_spawn_amount = pow(2, difficulty)
    return 1
