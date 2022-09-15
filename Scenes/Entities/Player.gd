extends KinematicBody2D

export (int) var walking_speed = 100
export (int) var running_speed = 300
var flaslight_on: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	
#	Toggle flashlight
	if Input.is_action_just_pressed('toggle_flashlight'):
		if flaslight_on:
			flaslight_on = false
		elif !flaslight_on:
			flaslight_on = true
	$'%Flashlight'.enabled = flaslight_on
	
#	movement
	var direction: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed('up'):
		direction.y -= 1
	if Input.is_action_pressed('down'):
		direction.y += 1
	if Input.is_action_pressed('left'):
		direction.x -= 1
		$Sprite.scale = Vector2(-1,-1)
	if Input.is_action_pressed('right'):
		direction.x += 1
		$Sprite.scale = Vector2(1,1)
	
	if Input.is_action_pressed('run'):
		position += direction * running_speed * delta
	else:
		position += direction * walking_speed * delta
		
#	sound

	if direction != Vector2(0,0) && !$WalkingSound.playing && !Input.is_action_pressed('run'):
		print('walk')
		$RunningSound.stop()
		$WalkingSound.play()
	
	elif direction != Vector2(0,0) && Input.is_action_pressed('run') && !$RunningSound.playing:
		print('run')
		$WalkingSound.stop()
		$RunningSound.play()
	
	if direction == Vector2(0,0) && ($WalkingSound.playing || $RunningSound.playing):
#		$Following.stop()
		$WalkingSound.stop()
		$RunningSound.stop()
