extends Control

#@onready var score_texture = %Score/ScoreTexture
@onready var score_label = %Score/ScoreLabel
@onready var time_label = %Time/TimeLabel

#@onready var death_label = %Death/DeathLabel


func _process(_delta):
    # Set the score label text to the score variable in game maanger script
    score_label.text = "Score %d" % GameManager.score

    var ingame_time_s = Time.get_ticks_msec() / 1000
    time_label.text = "Time since start %ds" % ingame_time_s
    #death_label.text = "Deaths: %d" % GameManager.death_counter
