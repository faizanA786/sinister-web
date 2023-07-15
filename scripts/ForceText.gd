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
	textSize += 1
	set_visible_characters(textSize)
	$Type.set_pitch_scale(randf_range(1.15, 1.22))
	$Type.play()
	stop = randi_range(0, 16)
	if stop == 16:
		$Expand.stop()
		$Random.start()
	elif textSize >= totalSize:
		$Expand.stop()
		$Death.start()

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
