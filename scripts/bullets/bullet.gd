extends CharacterBody2D

class_name Bullet

var speed = GameManager.default_bullet_speed
var direction = GameManager.default_bullet_direction
var dmg = GameManager.default_bullet_dmg
var pircing = GameManager.default_bullet_pircing

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimationPlayer.play("shot")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

    var motion = direction * speed * delta

    move_and_collide(motion)
