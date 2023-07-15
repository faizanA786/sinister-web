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
	$Type.set_pitch_scale(randf_range(1.12, 1.22))
	$Type.play()
	if textSize >= totalSize:
		$Expand.stop()
		$Death.start()
	set_visible_characters(textSize)

func _on_shrink_timeout():
	textSize -= 1
	if textSize < 0:
		$Shrink.stop()
	else:
		set_visible_characters(textSize)

func _on_death_timeout():
	$Shrink.start()
