extends TextureFrame
func _ready():
	pass
func _on_Yes_pressed():
	get_tree().change_scene("res://Pong.tscn")
func _on_No_pressed():
	get_tree().quit()