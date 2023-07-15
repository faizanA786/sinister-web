extends Label

var textSize
var totalSize
var stop

func _ready():
	textSize = get_visible_characters()
	totalSize = get_total_character_count()

func _physics_process(_delta):
	totalSize = get_total_character_count()

func _on_expand_timeout():
	if Input.get_action_raw_strength("Skip_Text") and not textSize >= totalSize:
		textSize += 2
		$Delete.play()
	else:
		textSize += 1
		$Type.set_pitch_scale(randf_range(1.12, 1.22))
		$Type.play()
		stop = randi_range(0, 16)
		if stop == 16:
			$Expand.stop()
			$Random.start()
		elif textSize >= totalSize:
			$Expand.stop()
			$Death.start()
	set_visible_characters(textSize)

func _on_shrink_timeout():
	$Delete.play()
	textSize -= 3
	set_visible_characters(textSize)
	if textSize <= 0:
		queue_free()

func _on_death_timeout():
	$Shrink.start()

func _on_random_timeout():
	stop = null
	$Expand.start()
