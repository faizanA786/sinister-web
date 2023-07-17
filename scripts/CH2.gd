extends Control

enum{CITY,HOUSE}
var location = CITY

func _ready():
	$AnimationPlayer.play("Load_CH2")

func tick():
	$Tick.play()
	$Player.velocity = Vector2.ZERO
	$Player.target = null
	
func stab():
	$Stab.play()

func _on_wind_finished():
	if location == CITY:
		$Wind.set_pitch_scale(randf_range(0.7, 1.2))
		$Wind.play()

func _on_to_road_b_body_entered(body):
	if body == $Player:
		$City/RoadA.queue_free()
		$City/ToRoadB.queue_free()
		$City/RoadB.position = Vector2(0,0)
		$City/ToRoadC.position = Vector2(0,0)
		$Player.position = Vector2(240, 192)
		$Car.play()
		$AnimationPlayer.play("Load_CH2")
		$VBoxContainer/Chat5.visible = true

func _on_to_road_c_body_entered(body):
	if body == $Player:
		$City/RoadB.free()
		$City/ToRoadC.queue_free()
		$City/RoadC.position = Vector2(0,0)
		$City/ToRoadD.position = Vector2(0,0)
		$Player.position = Vector2(312,48)
		$Car.play()
		$AnimationPlayer.play("Load_CH2")

func _on_to_road_d_body_entered(body):
	if body == $Player:
		$Player.position = Vector2(176,40)
		$City/RoadD/Timer.start()
		$City/RoadC.queue_free()
		$City/ToRoadD.queue_free()
		$City/RoadD.position = Vector2(0,0)
		$City/ToForest.position = Vector2(0,0)
		$Car.play()
		$AnimationPlayer.play("Load_CH2")

func _on_to_forest_body_entered(body):
	if body == $Player:
		$Player.position = Vector2(312, 168)
		$Car.play()
		$City/ToForest.queue_free()
		$City/RoadD.queue_free()
		$City.queue_free()
		$Forest/ForestA.position = Vector2(0,0)
		$Forest/ToForestB.position = Vector2(0,0)
		body.soundState = body.GRAVEL
		$AnimationPlayer.play("Load_CH2")

func _on_to_forest_b_body_entered(body):
	if body == $Player:
		$Tree.play()
		$Forest/ForestA.queue_free()
		$Forest/ToForestB.queue_free()
		$Forest/ForestB.position = Vector2(0,0)
		$Forest/ToForestC.position = Vector2(0,0)
		$Player.position = Vector2(240, 200)
		$AnimationPlayer.play("Load_CH2")

func _on_to_forest_c_body_entered(body):
	if body == $Player:
		$Tree.play()
		$Forest/ForestB.queue_free()
		$Forest/ToForestC.queue_free()
		$Forest/ForestC.position = Vector2(0,0)
		$Forest/ToHouse.position = Vector2(0,0)
		$Player.position = Vector2(320, 120)
		$AnimationPlayer.play("Load_CH2")

func _on_to_house_body_entered(body):
	if body == $Player:
		$Tree.play()
		$Forest/ForestC.queue_free()
		$Forest/ToHouse.queue_free()
		$Forest/House.position = Vector2(0,0)
		$Forest/EnterHouse.position = Vector2(0,0)
		$Player.position = Vector2(264, 176)
		$AnimationPlayer.play("Load_CH2")

func _on_enter_house_body_entered(body):
	if body == $Player:
		location = HOUSE
		$Wind.stop()
		$House/Whisper.play()
		$Door.set_pitch_scale(0.85)
		$Door.play()
		body.soundState = body.WOOD
		$AnimationPlayer.play("Load_CH2")
		$Forest.queue_free()
		$House/KitchenDoor.position = Vector2(0,0)
		$Player.position = Vector2(237, 156)

func _on_kitchen_door_body_entered(body):
	if body == $Player:
		$House/KitchenDoor.queue_free()
		$Door.set_pitch_scale(1.1)
		$Door.play()
		$AnimationPlayer.play("Load_CH2")
		$House/Kitchen.visible = true
		$Player.position = Vector2(313,194)
		$House/Kitchen.position = Vector2(0, 0)
		$House/Kitchen/Dishes.play()

func _on_living_room_door_body_entered(body):
	if body == $Player:
		$House/LivingRoomDoor.queue_free()
		$Door.play()
		$AnimationPlayer.play("Load_CH2")
		$House/LivingRoom.visible = true
		$Player.position = Vector2(239,195)
		$House/LivingRoom.position = Vector2(0, 0)
		$House/Timer.wait_time = 2.2
		$House/Heartbeat.volume_db = 3
		$House/LivingRoom/Timer.start()
		$House/LivingRoom/TV.play()
	
func _on_bedroom_door_body_entered(body):
	if body == $Player:
		$House/Bedroom.visible = true
		$House/BedroomDoor.queue_free()
		$AnimationPlayer.play("Load_CH2")
		$House/Heartbeat.volume_db = 4
		$House/Timer.wait_time = 1.8
		$Door.play()
		$House/Bedroom/Timer.start()
		$House/Bedroom.killed = false
		$Player.position = Vector2(271, 192)
		$House/Bedroom.position = Vector2(0, 0)
		$Player.bloody = true

func _on_whisper_finished():
	$House/Whisper.play()
