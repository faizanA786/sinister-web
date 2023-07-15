extends Node2D

@onready var animationPlayer = get_parent().get_parent().get_node("AnimationPlayer")
@onready var door = get_parent().get_parent().get_node("Door")
@onready var player = get_parent().get_parent().get_node("Player")
@onready var frame = get_parent().get_parent().get_node("Frame/TextureRect")
var kill = false
var killed = true

func _process(delta):
	if kill == true:
		if Input.is_action_just_pressed("Kill"):
			get_tree().change_scene_to_file("res://scenes/chapters/CH3.tscn")
	if killed != true:
		$NPC.target = player.position
		$Label.position = Vector2($NPC.position.x - 70, $NPC.position.y - 20)

func _on_timer_timeout():
	$Label/Expand.start()

func _on_npc_c_body_entered(body):
	kill = true
	animationPlayer.queue("FadeToRed_FromWhite")
func _on_npc_c_body_exited(body):
	kill = false
	if killed != true:
		animationPlayer.queue("FadeToWhite_FromRed")
