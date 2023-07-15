extends Control

var index = 0
var lastLabel = null
var nextLabel

func _ready():
	nextLabel = get_node("TextureRect/" + str(index) + "/Expand")
	$AnimationPlayer.play("FadeToYellow_FromWhite")

func grab_label():
	index += 1
	lastLabel = get_node("TextureRect/" + str(index - 1) + "/Shrink")
	nextLabel = get_node("TextureRect/" + str(index) + "/Expand")
	if index == 4: # label 3
		$AnimationPlayer.play("FadeToWhite_FromYellow")
	elif index >= 7 and index <= 10:
		var container = get_node("TextureRect/" + str(index-1) + "/VBoxContainer")
		container.visible = true
		$AnimationPlayer.play("FadeInLabel_" + str(index-1))
	elif index == 12: # label 11
		$"TextureRect/11/Selection".visible = true
		$AnimationPlayer.play("FadeInLabel_11")
		$Voice.play()
	elif index == 13: # label 12
		$AnimationPlayer.play("FadeToYellow_FromWhite")
	print(index)

func _process(_delta):
	if index == 13 and lastLabel == null:
		get_tree().change_scene_to_file("res://scenes/chapters/CH2.tscn")
	elif nextLabel.wait_time >= 0.065 and lastLabel == null:
		nextLabel.start()
		grab_label()
	elif Input.get_action_strength("Next") and lastLabel == null:
		nextLabel.start()
		grab_label()

func _on__button_up(): # mini-survey
	lastLabel.start()
	$AnimationPlayer.play_backwards("FadeInLabel_" + str(index-1))

func _on_yes_button_up(): # label 11 - to CH2
	lastLabel.start()
	$AnimationPlayer.play_backwards("FadeInLabel_11")
func _on_no_button_up(): # label 11
	$Glitch.play()
	$AnimationPlayer.play("Blackout")
	$"TextureRect/11/Selection/No".queue_free()
