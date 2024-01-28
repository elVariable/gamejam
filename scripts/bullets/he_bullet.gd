extends Bullet

class_name HeBullet

var sounds = [
    "res://Assets/Sound/he1.wav",
    "res://Assets/Sound/he2.wav"
]

func _init():
    $DefaultAudio.stream = load(sounds[int(Time.get_ticks_msec() / 10000) % sounds.size()])
    pass
