extends CharacterBody2D

class_name Enemy

var speed = 500 # pixel per second
var health = 100
var score = 20

var dmg = 10

var resource = null

# Called when the node enters the scene tree for the first time.
func _ready():
    #speed = get_node("%Player").speed * 0.7
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var player_pos = get_node("/root/level/Player").position
    update_rotation(player_pos)
    movement(delta, player_pos)

func update_rotation(target_pos):
    look_at(target_pos)

func movement(delta, target_pos):
    var direction = (target_pos - position).normalized()
    velocity = direction * speed

    $AnimationPlayer.play("Walk")
    if direction.x < 0:
        $Icon.flip_v = true
    else:
        $Icon.flip_v = false

    if position.distance_to(target_pos) > 5: # fix shaky behaviour
        move_and_slide()

func animate_color_blink(flash_color):
    modulate = flash_color
    await get_tree().create_timer(0.2).timeout
    modulate = Color.WHITE
    await get_tree().create_timer(0.1).timeout
    modulate = flash_color
    await get_tree().create_timer(0.2).timeout
    modulate = Color.WHITE

func handle_bullet_hit(bullet: Bullet):
    health -= bullet.dmg
    bullet.pircing -= 1
    bullet.play_hit_sound()
    if bullet.pircing <= 0:
        despawn_bullet(bullet)
    if health <= 0:
        despawn_enemy()
    else:
        animate_color_blink(Color.INDIAN_RED)

func despawn_enemy():
    GameManager.add_score(score)
    GameManager.add_kills()
    queue_free()

func despawn_bullet(bullet: Bullet):
    bullet.cleanup()

func _on_area_2d_body_entered(_body):
    if _body.is_in_group("Bullets"):
        handle_bullet_hit(_body)

func get_enemy_spawn_amount(
    difficulty: int,
):
    var enemy_spawn_amount = pow(2, difficulty)
    return enemy_spawn_amount

func create_instance():
    if resource:
        return resource.instantiate()

func get_legit_spawn(window_size, player_pos, min_dist_to_player = -1):
    var new_pos = Vector2(randi() % int(window_size.x), randi() % int(window_size.y))    
    if min_dist_to_player == -1:
     min_dist_to_player = window_size.x / 2.5

    while true:
        # has potential to freeze the game - lol
        if player_pos.distance_to(new_pos) > min_dist_to_player:
            return new_pos
        else:
            new_pos = Vector2(randi() % int(window_size.x), randi() % int(window_size.y))
