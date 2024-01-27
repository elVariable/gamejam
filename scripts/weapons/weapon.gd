extends Node2D

class_name Weapon

var bullet_scene = load("scenes/prefabs/bullets/bullet.tscn")

var base_spawn_time = .1
var base_spawn_rate = 1

var cnt_spawn_time = base_spawn_time

var bullet_speed = 1700
var bullet_dmg = 50
var bullet_pircing = 1

var bullet_scale = Vector2(1, 1)

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
                bullet_instance.speed = bullet_speed
                bullet_instance.dmg = bullet_dmg
                bullet_instance.pircing = bullet_pircing
                bullet_instance.scale = bullet_scale
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

    return closest_enemy