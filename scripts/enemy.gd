extends CharacterBody2D

var speed = 500 # pixel per second
var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
    #speed = get_node("%Player").speed * 0.7
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var target_pos = get_node("/root/level/Player").position
    var direction = (target_pos - position).normalized()
    var motion = direction * speed * delta
    
    move_and_collide(motion)
