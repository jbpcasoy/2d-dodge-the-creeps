extends RigidBody2D

export var min_speed = 150.0
export var max_speed = 250.0

func _ready():
#	For testing mob random
#	randomize()
	$AnimatedSprite.play()

	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[rand_range(0, mob_types.size())]


func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
