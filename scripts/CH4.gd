extends Control


func _ready():
	$AnimationPlayer.play("Load_CH2")
	$Player.soundState = $Player.STONE

func tick():
	$Tick.play()
	$Player.velocity = Vector2.ZERO
	$Player.target = null


func _process(delta):
	pass
