extends Bullet

class_name HoBullet

var sounds = [
    "res://Assets/Sound/ho1.wav",
    "res://Assets/Sound/ho2.wav",
    "res://Assets/Sound/ho3.wav",
]

func _init():
    $DefaultAudio.stream = load(sounds[(int(Time.get_ticks_msec() / 1000) / 2 ) % sounds.size()])
    $DefaultAudio.pitch_scale = randf_range(0.6, 1.4)
    pass
