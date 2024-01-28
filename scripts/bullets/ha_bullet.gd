extends Bullet

class_name HaBullet

var sounds = [
    "res://Assets/Sound/ha1.wav",
    "res://Assets/Sound/ha2.wav",
    "res://Assets/Sound/ha3.wav",
]

func _init():
    $DefaultAudio.stream = load(sounds[(int(Time.get_ticks_msec() / 1000) / 2 ) % sounds.size()])
    $DefaultAudio.pitch_scale = randf_range(0.6, 1.4)
    pass
