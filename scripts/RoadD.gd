extends Node2D

@onready var player = get_parent().get_parent().get_node("Player")
@onready var label = get_parent().get_parent().get_node("VBoxContainer/Chat6")

func _process(delta):
	$NPC.look_at(player.position)

func _on_timer_timeout():
	label.visible = true
	$Label/Expand.start()
