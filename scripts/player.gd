extends CharacterBody2D

@export
var speed = 700

@export
var player_life = 100

var weapon = null

# Called when the node enters the scene tree for the first time.
func _ready():
    position = get_viewport_rect().size * 0.5
    switch_weapon("he_weapon")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    movement()
    fire()

func movement():
    var move_dir = Input.get_vector("Left", "Right", "Up", "Down")
    velocity = move_dir * speed
    
    if Input.is_action_just_pressed("Left"):
        $Icon.flip_h = true
        if weapon.position.x > 0:
            weapon.position.x = -weapon.position.x
    
    if Input.is_action_just_pressed("Right"):
        $Icon.flip_h = false
        if weapon.position.x < 0:
            weapon.position.x = -weapon.position.x
    
    if not velocity.is_zero_approx():
        $AnimationPlayer.play("Move")
    else:
        pass
       # $AnimationPlayer.play("Idle")    

    position = position.clamp(Vector2.ZERO, get_viewport_rect().size)
    move_and_slide()

func fire():
    if Input.is_action_just_pressed("Fire0"):
        #print("Fire0")
        #modulate = Color(255, 0, 0)
        switch_weapon("ha_weapon")
    elif Input.is_action_just_pressed("Fire1"):
        #print("Fire1")
        #modulate = Color(0, 255, 0)
        switch_weapon("hi_weapon")
    elif Input.is_action_just_pressed("Fire2"):
        #print("Fire2")
        #modulate = Color(0, 0, 255)
        switch_weapon("he_weapon")
    elif Input.is_action_just_pressed("Fire3"):
        #print("Fire3")
        #modulate = Color(120, 120, 0)
        switch_weapon("ho_weapon")
    elif Input.is_action_just_released("Fire0") or Input.is_action_just_released("Fire1") or Input.is_action_just_released("Fire2") or Input.is_action_just_released("Fire3"):
        pass

func switch_weapon(name):
    var new_weapon = GameManager.weapons[name].create_instance()

    if weapon:
        weapon.queue_free()

    add_child(new_weapon)
    weapon = new_weapon

func animate_color_blink(flash_color):
    modulate = flash_color
    await get_tree().create_timer(0.2).timeout
    modulate = Color.WHITE
    await get_tree().create_timer(0.1).timeout
    modulate = flash_color
    await get_tree().create_timer(0.2).timeout
    modulate = Color.WHITE

func _on_collision_body_entered(_body):
    if _body.is_in_group("Enemies"):
        player_life -= _body.dmg
        _body.queue_free()
        animate_color_blink(Color.RED)

        if player_life <= 0:
            GameManager.trigger_game_over()
    elif _body.is_in_group("Items"):
        if _body.heal:
            player_life += _body.heal
            _body.queue_free()
            animate_color_blink(Color.LIGHT_GREEN)
