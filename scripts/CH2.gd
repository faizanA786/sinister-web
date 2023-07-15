extends Control

enum{SPAWN,HOUSE}
var location = SPAWN

func _ready():
	$AnimationPlayer.play("Load_CH2")

func tick():
	$Tick.play()
	$Player.velocity = Vector2.ZERO
	$Player.target = null
	
func stab():
	$Stab.play()

func _process(_delta):
	pass

func _on_wind_finished():
	if location == SPAWN:
		$Spawn/Wind.set_pitch_scale(randf_range(0.7, 1.2))
		$Spawn/Wind.play()

func kitchen_collisions():
	$House/Kitchen/StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	$House/Kitchen/StaticBody2D/CollisionShape2D2.set_deferred("disabled", false)
	$House/Kitchen/StaticBody2D/CollisionShape2D3.set_deferred("disabled", false)
	$House/Kitchen/StaticBody2D/CollisionShape2D4.set_deferred("disabled", false)
func livingroom_collisions():
	$House/LivingRoom/StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	$House/LivingRoom/StaticBody2D/CollisionShape2D2.set_deferred("disabled", false)
	$House/LivingRoom/StaticBody2D/CollisionShape2D3.set_deferred("disabled", false)
	$House/LivingRoom/StaticBody2D/CollisionShape2D4.set_deferred("disabled", false)
	$House/LivingRoom/StaticBody2D/CollisionShape2D5.set_deferred("disabled", false)
	$House/LivingRoom/StaticBody2D/CollisionShape2D6.set_deferred("disabled", false)
	$House/LivingRoom/StaticBody2D/CollisionShape2D7.set_deferred("disabled", false)
func bedroom_collisions():
	$House/Bedroom/StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	$House/Bedroom/StaticBody2D/CollisionShape2D2.set_deferred("disabled", false)
	$House/Bedroom/StaticBody2D/CollisionShape2D3.set_deferred("disabled", false)
	$House/Bedroom/StaticBody2D/CollisionShape2D4.set_deferred("disabled", false)

func _on_enter_house_body_entered(body):
	location = HOUSE
	$Spawn/Wind.stop()
	$House/Whisper.play()
	$Door.set_pitch_scale(0.85)
	$Door.play()
	$Spawn.queue_free()
	$House/KitchenDoor.monitoring = true
	$House.visible = true
	body.target = null
	body.velocity = Vector2.ZERO
	body.soundState = body.WOOD
	$AnimationPlayer.play("Load_CH2")
	$Spawn.queue_free()
	$Player.position = Vector2(237, 156)

func _on_kitchen_door_body_entered(body):
	$House/KitchenDoor.queue_free()
	kitchen_collisions()
	$Door.set_pitch_scale(1.1)
	$Door.play()
	$AnimationPlayer.play("Load_CH2")
	$House/Kitchen/NPC_A.monitoring = true
	$House/Kitchen.visible = true
	$Player.position = Vector2(313,194)
	$House/Kitchen/Dishes.play()

func _on_living_room_door_body_entered(body):
	$House/LivingRoomDoor.queue_free()
	livingroom_collisions()
	$Door.play()
	$AnimationPlayer.play("Load_CH2")
	$House/LivingRoom/NPC_B.monitoring = true
	$House/LivingRoom.visible = true
	$Player.position = Vector2(239,195)
	$House/Timer.wait_time = 2.2
	$House/Heartbeat.volume_db = 3
	$House/LivingRoom/Timer.start()
	$House/LivingRoom/TV.play()
	
func _on_bedroom_door_body_entered(body):
	bedroom_collisions()
	$House/Bedroom.visible = true
	$House/BedroomDoor.queue_free()
	$AnimationPlayer.play("Load_CH2")
	$House/Heartbeat.volume_db = 4
	$House/Timer.wait_time = 1.8
	$Door.play()
	$House/Bedroom/Timer.start()
	$House/Bedroom.killed = false
	$House/Bedroom/NPC/NPC_C.monitoring = true
	$Player.position = Vector2(271, 192)
	$Player.bloody = true

func _on_timer_timeout():
	$House/Heartbeat.play()

func _on_whisper_finished():
	$House/Whisper.play()
