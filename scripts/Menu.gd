extends Control

func _on_play_button_up():
	$Type.play()
	$AnimationPlayer.play("FadeTo_CH1")

func to_CH1():
	get_tree().change_scene_to_file("res://scenes/chapters/CH1.tscn")
