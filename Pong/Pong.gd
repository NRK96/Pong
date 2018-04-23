extends Node2D
# Member variables
var screen_size
var pad_size
var left_color = 0
var right_color = 0
var left_score = 0
var right_score = 0
var direction = Vector2(1.0, 0.0)
# Constant for pad speed (in pixels/second)
const INITIAL_BALL_SPEED = 80
# Speed of the ball (also in pixels/second)
var ball_speed = INITIAL_BALL_SPEED
# Constant for pads speed
const PAD_SPEED = 150
func _ready():
	randomize()
	if(randi()%2 == 1):
		direction = -direction
	randomize()
	var y = Vector2(0,(randf()*45)/100)
	if(randi()%2 == 1):
		y = -y
	direction += y
	screen_size = get_viewport_rect().size
	pad_size = get_node("Base").get_texture().get_size()
	set_process(true)
func reset_match(ball_pos):
	ball_pos = screen_size*0.5
	ball_speed = INITIAL_BALL_SPEED
	direction.x = -direction.x
	direction.y = 0;
	return ball_pos
func _process(delta):
	var ball_pos = get_node("Ball").get_pos()
	var left_rect = Rect2(get_node("Left").get_pos() - pad_size*0.5, pad_size)
	var right_rect = Rect2(get_node("Right").get_pos() - pad_size*0.5, pad_size)
	# Integrate new ball position
	ball_pos += direction*ball_speed*delta
	# Flip ball when touching roof/floor
	if((ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
		direction.y = -direction.y
	# Flip, change direction and speed when touching pads
	if((right_rect.has_point(ball_pos) and direction.x > 0)):
		right_color += 1
		get_node("Right").set_frame(right_color%4)
		direction.x = -direction.x
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.2
	if((left_rect.has_point(ball_pos) and direction.x < 0)):
		left_color += 1
		get_node("Left").set_frame(left_color%4)
		direction.x = -direction.x
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.2
	if(ball_pos.x < 0):
		right_score += 1
		get_node("Right_Score").set_frame(right_score)
		ball_pos = reset_match(ball_pos)
	if(ball_pos.x > screen_size.x):
		left_score += 1
		get_node("Left_Score").set_frame(left_score)
		ball_pos = reset_match(ball_pos)
	if(left_score == 11 or right_score == 11):
		get_tree().change_scene("res://End.tscn")
	get_node("Ball").set_pos(ball_pos)
	# Move left pad
	var left_pos = get_node("Left").get_pos()
	if(left_pos.y > 0 and Input.is_action_pressed("left_move_up")):
		left_pos.y += -PAD_SPEED*delta
	if(left_pos.y < screen_size.y and Input.is_action_pressed("left_move_down")):
		left_pos.y += PAD_SPEED*delta
	get_node("Left").set_pos(left_pos)
	# Move right pad
	var right_pos = get_node("Right").get_pos()
	if(right_pos.y > 0 and Input.is_action_pressed("right_move_up")):
		right_pos.y += -PAD_SPEED*delta
	if(right_pos.y < screen_size.y and Input.is_action_pressed("right_move_down")):
		right_pos.y += PAD_SPEED*delta
	get_node("Right").set_pos(right_pos)