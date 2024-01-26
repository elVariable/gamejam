extends CharacterBody2D

var VELOCITY = 700

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    movement()

func movement():
    #var hor_inputAxis = Input.get_axis("Left", "Right")
    #var vert_inputAxis = Input.get_axis("Left", "Right")
    
    var move_dir = Input.get_vector("Left", "Right", "Up", "Down")
    velocity = move_dir * VELOCITY

    print(velocity)
    move_and_slide()
