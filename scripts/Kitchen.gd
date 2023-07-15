extends Node2D

var kill = false
var killed = false
@onready var animationPlayer = get_parent().get_parent().get_node("AnimationPlayer")
@onready var door = get_parent().get_parent().get_node("Door")
@onready var player = get_parent().get_parent().get_node("Player")
@onready var frame = get_parent().get_parent().get_node("Frame/TextureRect")
@onready var livingRoomDoor = get_parent().get_node("LivingRoomDoor")
@onready var timer = get_parent().get_node("Timer")
@onready var heartbeat = get_parent().get_node("Heartbeat")

func _process(delta):
	if kill == true:
		if Input.is_action_just_pressed("Kill"):
			killed = true
			$Scream.play()
			$Dishes.stop()
			animationPlayer.play("Kill")
			$Return.visible = true
			$Return.monitoring = true
			$Blood.visible = true
			$NPC_A.queue_free()
			animationPlayer.clear_queue()
			frame.modulate = Color(1, 0, 0)
			player.modulate = Color(1, 0, 0)
			heartbeat.play()
			timer.start()

func _on_npc_a_body_entered(body):
	kill = true
	$Key.visible = true
	animationPlayer.queue("FadeToRed_FromWhite")
func _on_npc_a_body_exited(body):
	kill = false
	$Key.visible = false
	if killed != true:
		animationPlayer.queue("FadeToWhite_FromRed")

func _on_return_body_entered(body):
	door.play()
	player.position = Vector2(159, 162)
	animationPlayer.play("Load_CH2")
	livingRoomDoor.visible = true
	livingRoomDoor.monitoring = true
	frame.modulate = Color(1, 1, 1)
	self.queue_free()

func _on_dishes_finished():
	$Dishes.play()
