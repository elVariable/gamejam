extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    

func movement():
    var inputAxis = Input.get_axis("Left", "Right")
    velocity = Vector2(inputAxis * move_speed, velocity.y)
    move_and_slide()
