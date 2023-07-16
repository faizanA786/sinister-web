extends Control

func _ready():
	$Credits/Label/Expand.start()

func _on_play_button_up():
	$Type.play()
	$Wind.stop()
	$AnimationPlayer.play("FadeTo_CH1")

func to_CH1():
	get_tree().change_scene_to_file("res://scenes/chapters/CH1.tscn")

func _on_death_timeout():
	$AnimationPlayer.play("FadeOutCredits")

func disclaimer():
	$Credits.queue_free()
	$AnimationPlayer.play("FadeInDisclaimer")
	$Disclaimer/Timer.start()
func _on_timer_timeout():
	$AnimationPlayer.play_backwards("FadeInDisclaimer")
	$AnimationPlayer.queue("FadeInMenu")
func delete_disclaimer():
	$Disclaimer.queue_free()
	$CRTEffect.visible = true
	$Wind.play()


func _on_wind_finished():
	$Wind.play()
