extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
    $Control/TextEdit.text = "You DIED. HAHA\nYour score: " + str(GameManager.score)
    $HTTPRequest.request_completed.connect(self._http_request_completed)
    $HTTPRequest.set_tls_options(TLSOptions.client_unsafe())
    update_scoreboard()

# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
    var json = JSON.new()
    var j = body.get_string_from_utf8()
    
    # this is how we solve bugs
    var first = j.rfind("[")
    var last = j.rfind("]")
    j = j.substr(first, last+1-first)
    
    json.parse(j)
    update_scoreboard_text(json.get_data())

func update_scoreboard():
    $Control/ScoreView.text = "[b][rainbow][font_size=22]Worldwide Highscore[/font_size][/rainbow][/b]\nLoading..."
    # Perform a GET request. The URL below returns JSON as of writing.
    var error = $HTTPRequest.request("https://msg.elvariable.de/index.php?json")
    if error != OK:
        push_error("An error occurred in the HTTP request.")

func update_scoreboard_text(json_data):
    if not json_data:
        update_scoreboard()
        return
    $Control/ScoreView.clear()

    $Control/ScoreView.text = "[b][rainbow][font_size=22]Worldwide Highscore[/font_size][/rainbow][/b]"

    # Sorting is already done by the backend (at least I hope so)
    var i = 0
    for entry in json_data:
        var color = Color.WEB_GRAY.to_html()
        if i == 0:
            color = Color.GOLD.to_html()
        elif i == 1:
            color = Color.SILVER.to_html()
        elif i == 2:
            color = Color.SADDLE_BROWN.to_html()

        $Control/ScoreView.text += ("\n[color=" + str(color) + "]" + entry["name"] + ": " + str(entry["score"]) + "[/color]")
        i+=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _on_button_pressed_restart():
    # reload main scene and restart
    GameManager.do_restart()
    get_tree().change_scene_to_file("res://scenes/levels/main.tscn")

func _on_button_pressed_submit():
    var name = $Control/SubmitScore/UserName.text
    var score = GameManager.score

    if name == "":
        return

    var fields = {"name": name, "score": score}
    var queryString = ""
    for field in fields:
        queryString += field + "=" + str(fields[field]) + "&"
    queryString = queryString.substr(0, queryString.length() - 1)
    
    var headers = ["Content-Type: application/x-www-form-urlencoded", "Content-Length: " + str(queryString.length())]
    # var result = httpClient.request(httpClient.METHOD_POST, "index.php", headers, queryString)

    $HTTPRequest.request("http://msgs.elvariable.de/index.php", headers, HTTPClient.METHOD_POST, queryString)
    $Control/SubmitScore/Button.disabled = true


