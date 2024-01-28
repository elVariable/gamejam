extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
    pass
    #$Control/Option1.set_shortcut(Input.get("Fire0"))
    #$Control/Option2.set_shortcut(Input.get("Fire1"))
    #$Control/Option3.set_shortcut(Input.get("Fire2"))
    #$Control/Option4.set_shortcut(Input.get("Fire3"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    handle_input()

func handle_input():
    if Input.is_action_just_pressed("Exit"):
        get_tree().quit()

    if Input.is_action_just_pressed("Fire0"):
        $Control/Option1.emit_signal("pressed")
    elif Input.is_action_just_pressed("Fire1"):
        $Control/Option2.emit_signal("pressed")
    elif Input.is_action_just_pressed("Fire2"):
        $Control/Option3.emit_signal("pressed")
    elif Input.is_action_just_pressed("Fire3"):
        $Control/Option4.emit_signal("pressed")

func _on_continue_pressed():
    end()

func end():
    hide()
    get_node("/root/level").show()
    get_tree().paused = false

func roll_and_show_upgrades():
    $Control/Option1.text = GameManager.weapons["ha_weapon"].weapon_name + "\nLvl" + str(GameManager.weapons["ha_weapon"].weapon_lvl)
    $Control/Option2.text = GameManager.weapons["hi_weapon"].weapon_name + "\nLvl" + str(GameManager.weapons["hi_weapon"].weapon_lvl)
    $Control/Option3.text = GameManager.weapons["he_weapon"].weapon_name + "\nLvl" + str(GameManager.weapons["he_weapon"].weapon_lvl)
    $Control/Option4.text = GameManager.weapons["ho_weapon"].weapon_name + "\nLvl" + str(GameManager.weapons["ho_weapon"].weapon_lvl)

func _on_visibility_changed():
    if visible:
        $Control/Text.clear()
        $Control/Text.append_text("[b]Wave:[/b] " + str(GameManager.wave) + "\n")
        $Control/Text.append_text("[b]Score:[/b] " + str(GameManager.score) + "\n")

        roll_and_show_upgrades()

func _on_option_1_pressed():
    GameManager.weapons["ha_weapon"].weapon_lvl += 1
    end()

func _on_option_2_pressed():
    GameManager.weapons["hi_weapon"].weapon_lvl += 1
    end()

func _on_option_3_pressed():
    GameManager.weapons["he_weapon"].weapon_lvl += 1
    end()

func _on_option_4_pressed():
    GameManager.weapons["ho_weapon"].weapon_lvl += 1
    end()

