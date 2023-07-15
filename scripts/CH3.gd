extends Control

var index = 0
var lastLabel = null
var nextLabel

func _ready():
	$Stab.play()
	$AnimationPlayer.play("Kill")
	nextLabel = get_node("TextureRect/" + str(index) + "/Expand")

func grab_label():
	index += 1
	lastLabel = get_node("TextureRect/" + str(index - 1) + "/Shrink")
	nextLabel = get_node("TextureRect/" + str(index) + "/Expand")
	if index >= 5 and index <= 7:
		if index == 6:
			$Glass.play()
		var container = get_node("TextureRect/" + str(index-1) + "/VBoxContainer")
		container.visible = true
		$AnimationPlayer.play("FadeInLabel_" + str(index-1))
	elif index == 9:
		$"TextureRect/8/HBoxContainer".visible = true
		$AnimationPlayer.play("FadeInLabel_8")
		$Knock.play()
	print(index)

func _process(_delta):
	if nextLabel.wait_time >= 0.065 and lastLabel == null:
		nextLabel.start()
		grab_label()
	elif Input.get_action_strength("Next") and lastLabel == null:
		nextLabel.start()
		grab_label()


func _on__button_up():
	lastLabel.start()
	$AnimationPlayer.play_backwards("FadeInLabel_" + str(index-1))

func _on_no_button_up():
	var noButton = $"TextureRect/8/HBoxContainer/No"
	if noButton.text == "> Yes <":
		_on_yes_button_up()
	noButton.text = "> Yes <"

func _on_yes_button_up():
	print("next CH")
