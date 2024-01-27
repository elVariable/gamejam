extends CharacterBody2D

class_name Enemy

var speed = 500 # pixel per second
var health = 100
var score = 20

var dmg = 10

# Called when the node enters the scene tree for the first time.
func _ready():
    #speed = get_node("%Player").speed * 0.7
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var target_pos = get_node("/root/level/Player").position
    var direction = (target_pos - position).normalized()

    velocity = direction * speed
    look_at(target_pos)

    $AnimationPlayer.play("Walk")
    if direction.x < 0:
        $Icon.flip_v = true
    else:
        $Icon.flip_v = false

    if position.distance_to(target_pos) > 5:
        move_and_slide()

func handle_bullet_hit(bullet: Bullet):
    health -= bullet.dmg
    bullet.pircing -= 1
    if bullet.pircing <= 0:
        despawn_bullet(bullet)
    if health <= 0:
        despawn_enemy()

func despawn_enemy():
    GameManager.add_score(score)
    queue_free()

func despawn_bullet(bullet: Bullet):
    bullet.queue_free()

func _on_area_2d_body_entered(_body):
    if _body.is_in_group("Bullets"):
        handle_bullet_hit(_body)

