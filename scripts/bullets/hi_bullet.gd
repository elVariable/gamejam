extends Bullet

class_name HiBullet

var sounds = [
    "res://Assets/Sound/hi1.wav",
    "res://Assets/Sound/hi2.wav",
    "res://Assets/Sound/hi3.wav",
]

func _init():
    $DefaultAudio.stream = load(sounds[(int(Time.get_ticks_msec() / 1000) / 2 ) % sounds.size()])
    pass
