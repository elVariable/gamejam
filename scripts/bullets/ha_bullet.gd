extends Bullet

class_name HaBullet

func _init():
    pass

func play_hit_sound():
    audio_queue.push_back($DefaultAudio)
    if audio_queue.size() == 1:
        audio_queue.pop_front().play()
