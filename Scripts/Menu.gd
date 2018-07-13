extends Button
func _ready():
	pass
# start the game
func _on_start_pressed():
	get_tree().change_scene("res://Scenes/Pong.tscn")