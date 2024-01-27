extends Node2D

var possible_upgrades = ["HA", "HE", "HI", "HO", "HU"]

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

func roll_and_show_upgrades():
    var op1 = randi() % 5
    var op2 = randi() % 5
    var op3 = randi() % 5

    $Control/Option1.text = possible_upgrades[op1]
    $Control/Option2.text = possible_upgrades[op2]
    $Control/Option3.text = possible_upgrades[op3]


func _on_visibility_changed():
    if visible:
        $Control/Text.clear()
        $Control/Text.append_text("[b]Wave:[/b] " + str(GameManager.wave) + "\n")
        $Control/Text.append_text("[b]Score:[/b] " + str(GameManager.score) + "\n")
        
        roll_and_show_upgrades()
