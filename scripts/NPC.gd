extends CharacterBody2D

const SPEED = 30  
var target = null
enum{GRAVEL,WOOD}
var soundState

func _physics_process(delta):
	if target:
		look_at(target)
		velocity = position.direction_to(target) * SPEED
		if position.distance_to(target) < 20:
			$Footstep.stop()
			velocity = Vector2.ZERO
			target = null
	move_and_slide()


func _on_footstep_timeout():
	if target:
		if soundState == GRAVEL:
			$FootstepGravel.set_pitch_scale(randf_range(0.76, 0.98))
			$FootstepGravel.play()
		elif soundState == WOOD:
			$FootstepWood.set_pitch_scale(randf_range(0.76, 0.98))
			$FootstepWood.play()
		$Footstep.start()
