extends Node2D


var speed: float = 400.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
	
	position += direction * speed * delta

	if direction != Vector2(0,0) && !$Steps.playing:
#		$Following.play()
		$Steps.play()
	
	if direction == Vector2(0,0) && $Steps.playing:
#		$Following.stop()
		$Steps.stop()
