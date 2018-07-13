extends AudioStreamPlayer2D

# begin playing theme song
func _ready():
	playing = true
	pass

# when theme song ends, restart it
func _on_theme_finished():
	playing = true
	pass 
