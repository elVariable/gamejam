extends Node2D

class_name Weapon

var bullet_scene = load("scenes/prefabs/bullets/bullet.tscn")

var base_spawn_time = .1
var base_spawn_rate = 1

var bullet_speed = 1700
var bullet_dmg = 50
var bullet_pircing = 1

var bullet_timer : Timer = null
var resource = null

var weapon_lvl : int = 1

var weapon_name : String = "BaseWeapon"

# Called when the node enters the scene tree for the first time.
func _ready():
    bullet_timer = get_node("BulletTimer")
    bullet_timer.start(base_spawn_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

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

func fire_bullets():
    for i in range(base_spawn_rate):
        var direction = get_normalized_direction()
        
     #   var PlayShotAnimation = get_parent().get_node("AnimationPlayer")animation_player.play("Shot")
        if direction:
            var bullet_instance = bullet_scene.instantiate()
            get_parent().get_node("AnimationPlayer").play("Shot")
            bullet_instance.position = get_legit_spawn()
            bullet_instance.direction = get_normalized_direction()

            bullet_instance.speed = get_scaled_speed()
            bullet_instance.dmg = get_scaled_dmg()
            bullet_instance.pircing = get_scaled_pircing()

            get_node("/root/level").add_child(bullet_instance)

func _on_bullet_timer_timeout():
    fire_bullets()
    bullet_timer.start(base_spawn_time)

func create_instance():
    if resource:
        return resource.instantiate()

func get_scaled_dmg():
    return weapon_lvl * bullet_dmg

func get_scaled_speed():
    return (1 + weapon_lvl / 10) * bullet_speed

func get_scaled_pircing():
    return bullet_pircing

