extends Timer

var chickpea = preload("res://scenes/prefabs/chickpea.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_timeout():
    var level = get_tree().root
    var res = get_viewport().get_window().size
    var new_pos = Vector2(randi() % int(res.x), randi() % int(res.y))

    var chickpea_inst = chickpea.instantiate()
    chickpea_inst.position = new_pos
    level.add_child(chickpea_inst)
