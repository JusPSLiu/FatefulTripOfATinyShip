extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const EXP_DECAY = 12.0;

@onready var camera = $Camera3D

var CamRotation : Vector2 = Vector2(0.0,0.0)
var sensitivity = 0.01

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if (event is InputEventMouseMotion):
		CamRotation += event.relative * sensitivity
		CamRotation.y = clamp(CamRotation.y, -1.5, 1.5)
		
		transform.basis = Basis()
		camera.transform.basis = Basis()
		
		# rot player on x
		rotate_object_local(Vector3(0,1,0),-CamRotation.x)
		# rot cam on y
		camera.rotate_object_local(Vector3(1,0,0),-CamRotation.y)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = expDecay(velocity.x, direction.x * SPEED, EXP_DECAY, delta)
		velocity.z = expDecay(velocity.z, direction.z * SPEED, EXP_DECAY, delta)
	else:
		velocity.x = expDecay(velocity.x, 0, EXP_DECAY, delta)
		velocity.z = expDecay(velocity.z, 0, EXP_DECAY, delta)

	move_and_slide()

# i saw a yt video by freya holmer abt this being a better exponential lerp
func expDecay(a, b, decay, dt):
	return b+(a-b)*exp(-decay*dt)
