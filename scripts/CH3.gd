extends Control

var index = 0
var lastLabelShrink
var lastLabel = null
var nextLabel
var container

func _ready():
	$Stab.play()
	$AnimationPlayer.play("Kill")
	nextLabel = get_node("TextureRect/" + str(index) + "/Expand")

func grab_label():
	index += 1
	lastLabel = get_node("TextureRect/" + str(index - 1))
	lastLabelShrink = get_node("TextureRect/" + str(index - 1) + "/Shrink")
	nextLabel = get_node("TextureRect/" + str(index) + "/Expand")
	if index >= 5 and index <= 10:
		if index == 6:
			$Glass.play()
		container = get_node("TextureRect/" + str(index-1) + "/VBoxContainer")
		$TextureRect/Timer.start()
	elif index == 12:
		container = get_node("TextureRect/" + str(index-1) + "/HBoxContainer")
		$Knock.play()
		$TextureRect/Timer.start()
	elif index == 13:
		$AnimationPlayer.play("FadeToYellow_FromWhite")
	print(index)

func _process(_delta):
	if index == 13 and lastLabel == null:
		get_tree().change_scene_to_file("res://scenes/chapters/CH4.tscn")
	elif nextLabel.wait_time >= 0.09 and lastLabel == null:
		nextLabel.start()
		grab_label()
	elif Input.get_action_strength("Next") and lastLabel == null:
		nextLabel.start()
		grab_label()

func _on_timer_timeout():
	if lastLabel.textSize >= lastLabel.totalSize:
		container.visible = true
		$AnimationPlayer.play("FadeInLabel_" + str(index-1))
	else:
		$TextureRect/Timer.start()

func _on__button_up():
	lastLabelShrink.start()
	$AnimationPlayer.play_backwards("FadeInLabel_" + str(index-1))

func _on_no_button_up():
	var noButton = $"TextureRect/11/HBoxContainer/No"
	if noButton.text == "> Yes <":
		_on_yes_button_up()
	noButton.text = "> Yes <"

func _on_yes_button_up():
	lastLabelShrink.start()
	$AnimationPlayer.play_backwards("FadeInLabel_11")


func _on_wind_finished():
	$Wind.play()
