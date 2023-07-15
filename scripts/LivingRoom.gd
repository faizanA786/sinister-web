extends Node2D

@onready var animationPlayer = get_parent().get_parent().get_node("AnimationPlayer")
@onready var door = get_parent().get_parent().get_node("Door")
@onready var player = get_parent().get_parent().get_node("Player")
@onready var frame = get_parent().get_parent().get_node("Frame/TextureRect")
@onready var bedRoomDoor = get_parent().get_node("BedroomDoor")
var index = 0
var kill = false
var killed = false

func _process(delta):
	if kill == true:
		if Input.is_action_just_pressed("Kill"):
			killed = true
			animationPlayer.play("Kill")
			$Scream.play()
			$Return.visible = true
			$Return.monitoring = true
			$Blood.visible = true
			$NPC_B.queue_free()
			frame.modulate = Color(1, 0, 0)
	if killed != true:
		$NPC_B/NPC.look_at(player.position)

func _on_timer_timeout():
	if killed != true:
		if index == 0:
			$NPC_B/Label/Expand.start()
			index += 1
			$Timer.start()
		elif index == 1:
			$NPC_B/Label2/Expand.start()
			$Timer.stop()

func _on_tv_finished():
	$TV.play()

func _on_npc_b_body_entered(body):
	kill = true
	animationPlayer.queue("FadeToRed_FromWhite")
func _on_npc_b_body_exited(body):
	kill = false
	if killed != true:
		animationPlayer.queue("FadeToWhite_FromRed")

func _on_return_body_entered(body):
	door.play()
	player.position = Vector2(294, 64)
	animationPlayer.play("Load_CH2")
	bedRoomDoor.visible = true
	bedRoomDoor.monitoring = true
	frame.modulate = Color(1, 1, 1)
	self.queue_free()
