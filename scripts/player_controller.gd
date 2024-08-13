extends CharacterBody3D

# Speed for forward/backward movement and turning left/right
var move_speed: float = 8
var turn_speed: float = 10

var final_velocity: Vector3
var final_rotation: float

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _input(event):
    # Quick Turn:
    #   Turn 180° and face behind you
    #   ↓ + Sprint / Secondary, in essence
    #   D + Shift / Q
    #   ↓ + Bottom Face / Left Face (✕, A, B / ▢, X, Y)
    # "just_released" is used because this isn't held like the moving and turning
    if Input.is_action_just_released("backward") && (Input.is_action_just_released("sprint") || Input.is_action_just_released("quick_turn_secondary")):
        # Rotate player 180°
        rotate_y(PI)

func _physics_process(delta):
    final_velocity = Vector3.ZERO
    final_rotation = 0.0

    # If any of the movement keys/Dpad/stick (include turning) are pressed
    if Input.is_action_pressed("movement"):
        # Move forward/back relative to direction faced
        # Base values are modified by the speed,
        # and then modified by the delta to prevent movement being tied to framerate
        if Input.is_action_pressed("forward"):
            final_velocity = Vector3(0, 0, 1 * move_speed) * delta
        # Make sure quick turn inputs aren't pressed to prevent moving during it
        if Input.is_action_pressed("backward") && !(Input.is_action_just_released("sprint") || Input.is_action_just_released("quick_turn_secondary")):
            final_velocity = Vector3(0, 0, -1 * move_speed) * delta
        # Turn left and right 
        if Input.is_action_pressed("turn_left"):
            final_rotation += 0.1
        if Input.is_action_pressed("turn_right"):
            final_rotation -= 0.1
    
    # Apply translation
    translate(final_velocity)
    # Rotate player based base value, and turn speed and delta for same reasons as movement
    rotate_y(final_rotation * turn_speed * delta)


    # Apply movement
    move_and_slide()
