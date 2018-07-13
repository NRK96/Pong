extends Node
func _ready():
	pass
# play another game
func _on_Yes_pressed():
	get_tree().change_scene("res://Scenes/Pong.tscn")
# quit
func _on_No_pressed():
	get_tree().quit()
