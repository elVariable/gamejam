extends Node2D

var bullet_scene = load("scenes/prefabs/bullet.tscn")

var base_spawn_time = .5
var base_spawn_rate = 1

var cnt_spawn_time = base_spawn_time

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if cnt_spawn_time > 0:
        cnt_spawn_time -= delta
    else:
        for i in range(base_spawn_rate):
            var direction = get_normalized_direction()
            if direction:
                var bullet_instance = bullet_scene.instantiate()
                get_tree().root.add_child(bullet_instance)
                bullet_instance.position = get_legit_spawn()
                bullet_instance.direction = get_normalized_direction()
        cnt_spawn_time = base_spawn_time

func get_legit_spawn():
    return global_position

func get_normalized_direction():
    var enemy = get_closest_enemy_or_null()

    if enemy:
        var direction = (enemy.global_position - global_position).normalized()
        return direction

    return null

func get_closest_enemy_or_null():
    var enemies = get_tree().get_nodes_in_group("Enemies")

    var closest_enemy = null
 
    if (enemies.size() > 0):
        closest_enemy = enemies[0]
        for e in enemies:
            var distance_to_this_enemy = global_position.distance_squared_to(e.global_position)
            var distance_to_closest_enemy = global_position.distance_squared_to(closest_enemy.global_position)
            if (distance_to_this_enemy < distance_to_closest_enemy):
                closest_enemy = e

    if closest_enemy:
        closest_enemy.modulate = Color(120, 0, 0)

    return closest_enemy
