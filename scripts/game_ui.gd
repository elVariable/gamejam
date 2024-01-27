extends Control

#@onready var score_texture = %Score/ScoreTexture
@onready var score_label = %Score/ScoreLabel
@onready var time_label = %Time/TimeLabel
@onready var life_label = %Life/LifeLabel
@onready var enemies_label = %Enemies/EnemiesLabel
@onready var kills_label = %Kills/KillsLabel

#@onready var death_label = %Death/DeathLabel


func _process(_delta):
    # Set the score label text to the score variable in game maanger script
    score_label.text = "Score %d" % GameManager.score

    var ingame_time_s = Time.get_ticks_msec() / 1000
    time_label.text = "Time since start %ds" % ingame_time_s
    #death_label.text = "Deaths: %d" % GameManager.death_counter

    var player = get_tree().root.get_node("/root/level/Player")
    life_label.text = "Life: %d" % player.player_life

    enemies_label.text = "Enemies alive: %d" % get_tree().get_nodes_in_group("Enemies").size()

    kills_label.text = "Enemies killed: %d" % GameManager.kills
