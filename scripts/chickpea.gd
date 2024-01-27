extends CharacterBody2D

class_name ChickPea

var heal : int = 5

func _process(delta):
    $AnimationPlayer.play("Idle")
