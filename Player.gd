extends Area2D

signal hit

export var speed = 400.0
var screen_size = Vector2.ZERO

func _ready():
	screen_size = self.get_viewport_rect().size
	self.hide()
	$AnimatedSprite.animation = "up"
	$AnimatedSprite.flip_v = false

func _process(delta):
#	Equivalent to Vector2(0, 0)
	var direction:Vector2 = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1

	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1

	if direction.length() > 0:
		direction = direction.normalized()
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	self.position += direction * speed * delta

	self.position.x = clamp(self.position.x, 0, self.screen_size.x)
	self.position.y = clamp(self.position.y, 0, self.screen_size.y)

	if direction.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = direction.x == -1
	elif direction.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = direction.y == 1

func start(new_position):
	self.position = new_position
	show()
	$CollisionShape2D.disabled = false

func _on_Player_body_entered(body):
	self.hide()
#	For s
	$CollisionShape2D.set_deferred("disabled", true)
	self.emit_signal("hit")
