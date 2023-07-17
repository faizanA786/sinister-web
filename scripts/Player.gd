extends CharacterBody2D

const SPEED = 40
var target = null
var lookAt = 0
enum{GRAVEL,WOOD,STONE}
var soundState = STONE
var bloody = false
@onready var bloodText = load("res://assets/sprites/Blood1.png")

func _input(event):
	if event.is_action_pressed("Next"):
		target = get_global_mouse_position()
		$Point.position = target
		$Point.visible = true
		look_at(target)
		if soundState == GRAVEL:
			$FootstepGravel.play()
		elif soundState == WOOD:
			$FootstepWood.play()
		elif soundState == STONE:
			$FootstepRock.play()
		$Footstep.start()

func _physics_process(delta):
	if target:
		look_at(target)
		velocity = position.direction_to(target) * SPEED
		if position.distance_to(target) < 10:
			velocity = Vector2.ZERO
			target = null
	else:
		lookAt = get_global_mouse_position()
		$Point.visible = false
		look_at(lookAt)
		$Footstep.stop()
	move_and_slide()


func _on_footstep_timeout():
	if target:
		if soundState == GRAVEL:
			$FootstepGravel.set_pitch_scale(randf_range(0.76, 0.98))
			$FootstepGravel.play()
		elif soundState == WOOD:
			$FootstepWood.set_pitch_scale(randf_range(0.76, 0.98))
			$FootstepWood.play()
		elif soundState == STONE:
			$FootstepRock.set_pitch_scale(randf_range(0.88, 1.05))
			$FootstepRock.play()
		$Footstep.start()
	if bloody == true:
		blood()

func blood():
	var blood = Sprite2D.new()
	blood.top_level = true
	blood.texture = bloodText
	blood.scale = Vector2(0.2, 0.2)
	blood.position = position 
	add_child(blood)
