extends Control

#@onready var score_texture = %Score/ScoreTexture
@onready var score_label = %Score/ScoreLabel
#@onready var death_label = %Death/DeathLabel


func _process(_delta):
    # Set the score label text to the score variable in game maanger script
    score_label.text = "Score %d" % GameManager.score
    #death_label.text = "Deaths: %d" % GameManager.death_counter
