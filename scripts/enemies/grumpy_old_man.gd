extends Enemy

class_name GrumpyOldMan

var active_target_pos = Vector2(0,0)

func _init():
    resource = preload("res://scenes/prefabs/enemies/grumpy_old_man.tscn")
    speed = 250

func _ready():
    $UpdateTargetTimer.start(2)
    pass

func movement(delta, target_pos):
    super.movement(delta, active_target_pos)

func update_target_pos():
    active_target_pos = get_node("/root/level/Player").position

func get_enemy_spawn_amount(
    difficulty: int,
):
    var enemy_spawn_amount = pow(2, difficulty)
    return 2
