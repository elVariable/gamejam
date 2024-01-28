extends Bullet

class_name HaBullet

var sounds = [
    "res://Assets/Sound/ha1.wav",
    "res://Assets/Sound/ha2.wav",
    "res://Assets/Sound/ha3.wav",
]

func _init():
    $DefaultAudio.stream = load(sounds[int(Time.get_ticks_msec() / 10000) % sounds.size()])
    pass
