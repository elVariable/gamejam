extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if Input.is_action_just_pressed("Exit"):
        get_tree().quit()

func _on_continue_pressed():
    hide()
    get_node("/root/level").show()
    get_tree().paused = false
