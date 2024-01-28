extends Bullet

class_name HoBullet

var sounds = [
    "res://Assets/Sound/ho1.wav",
    "res://Assets/Sound/ho2.wav",
    "res://Assets/Sound/ho3.wav",
]

func _init():
    $DefaultAudio.stream = load(sounds[int(Time.get_ticks_msec() / 10000) % sounds.size()])
    pass
