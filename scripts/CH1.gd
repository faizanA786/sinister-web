extends Control

var index = 0
var lastLabel = null
var lastLabelShrink
var nextLabel
var container

func _ready():
	nextLabel = get_node("TextureRect/" + str(index) + "/Expand")
	$AnimationPlayer.play("FadeToYellow_FromWhite")

func grab_label():
	index += 1
	lastLabelShrink = get_node("TextureRect/" + str(index - 1) + "/Shrink")
	lastLabel = get_node("TextureRect/" + str(index - 1))
	nextLabel = get_node("TextureRect/" + str(index) + "/Expand")
	if index == 4: # label 3
		$AnimationPlayer.play("FadeToWhite_FromYellow")
	elif index >= 7 and index <= 15:
		container = get_node("TextureRect/" + str(index-1) + "/VBoxContainer")
		$TextureRect/Timer.start()
	elif index == 17: # label 16
		container = get_node("TextureRect/" + str(index-1) + "/Selection")
		$TextureRect/Timer.start()
		$Voice.play()
	elif index == 18: # label 17
		$AnimationPlayer.play("FadeToYellow_FromWhite")
	print(index)

func _on_timer_timeout():
	if lastLabel.textSize >= lastLabel.totalSize:
		container.visible = true
		$AnimationPlayer.play("FadeInLabel_" + str(index-1))
	else:
		$TextureRect/Timer.start()

func _process(_delta):
	if index == 18 and lastLabel == null:
		get_tree().change_scene_to_file("res://scenes/chapters/CH2.tscn")
	elif nextLabel.wait_time >= 0.09 and lastLabel == null:
		nextLabel.start()
		grab_label()
	elif Input.get_action_strength("Next") and lastLabel == null:
		nextLabel.start()
		grab_label()

func _on__button_up(): # mini-survey
	lastLabelShrink.start()
	$AnimationPlayer.play_backwards("FadeInLabel_" + str(index-1))

func _on_yes_button_up(): # label 11 - to CH2
	lastLabelShrink.start()
	$AnimationPlayer.play_backwards("FadeInLabel_16")
func _on_no_button_up(): # label 11
	$Glitch.play()
	$AnimationPlayer.play("Blackout")
	$"TextureRect/16/Selection/No".queue_free()
