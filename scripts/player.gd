extends CharacterBody2D

@export
var speed = 700



# Called when the node enters the scene tree for the first time.
func _ready():
    position = get_viewport_rect().size * 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    movement()
    fire()

func movement():
    var move_dir = Input.get_vector("Left", "Right", "Up", "Down")
    velocity = move_dir * speed

    position = position.clamp(Vector2.ZERO, get_viewport_rect().size)
    move_and_slide()

func fire():
    if Input.is_action_just_pressed("Fire0"):
        print("Fire0")
        modulate = Color(255, 0, 0)
    elif Input.is_action_just_pressed("Fire1"):
        print("Fire1")
        modulate = Color(0, 255, 0)
    elif Input.is_action_just_pressed("Fire2"):
        print("Fire2")
        modulate = Color(0, 0, 255)
    elif Input.is_action_just_pressed("Fire3"):
        print("Fire3")
        modulate = Color(120, 120, 0)
    elif Input.is_action_just_released("Fire0") or Input.is_action_just_released("Fire1") or Input.is_action_just_released("Fire2") or Input.is_action_just_released("Fire3"):
        modulate = Color(255, 255, 255)

func _on_collision_body_entered(_body):
    if _body.is_in_group("Enemies"):
        GameManager.add_score(-10)
