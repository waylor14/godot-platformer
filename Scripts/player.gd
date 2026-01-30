extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0


func _physics_process(delta: float) -> void:
	
	#Get left/right input direction.
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	
	if direction > 0: #Controls character turning right/left based on direction
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Check for jump input and apply jump velocity
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animation_state()
	
func update_animation_state(): #Controls which animation is active based on movement
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("falling")
			
	else: # <-- This automatically means we ARE on the floor.
		if abs(velocity.x) > 5:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
			
