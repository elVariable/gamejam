extends Enemy

class_name GrumpyHousePlant

func _init():
    resource = preload("res://scenes/prefabs/enemies/grumpy_house_plant.tscn")

func _ready():
    pass

func update_rotation(target_pos):
    pass

func movement(delta, target_pos):
    $AnimationPlayer.play("Walk")
    pass

func get_enemy_spawn_amount(
    difficulty: int,
):
    var enemy_spawn_amount = pow(2, difficulty)
    return 1

func get_legit_spawn(window_size, player_pos, min_dist_to_player = -1):
    min_dist_to_player = window_size.x / 10
    return super.get_legit_spawn(window_size, player_pos, min_dist_to_player)
