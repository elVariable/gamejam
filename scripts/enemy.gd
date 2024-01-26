extends CharacterBody2D

var speed = 500 # pixel per second
var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
    speed = get_node("%Player").speed * 0.7


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var target_pos = get_node("%Player").position
    var direction = (target_pos - position).normalized()
    var motion = direction * speed * delta
    

    if move_and_collide(motion):
        get_tree().change_scene_to_file("res://scences/game_over.tscn")

        
