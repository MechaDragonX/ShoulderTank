extends Node

@export var player: CharacterBody3D

# Speed for forward/backward movement and turning left/right
var move_speed: float = 8
var turn_speed: float = 10

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
        player.rotate_y(PI)

func _physics_process(delta):
    # Local rotation variable
    var rotation: float = 0

    # If any of the movement keys/Dpad/stick (include turning) are pressed
    if Input.is_action_pressed("movement"):
        # Move forward/back relative to direction faced
        # Base values are modified by the speed,
        # and then modified by the delta to prevent movement being tied to framerate
        if Input.is_action_pressed("forward"):
            player.translate(Vector3(0, 0, 1 * move_speed) * delta)
        # Make sure quick turn inputs aren't pressed to prevent moving during it
        if Input.is_action_pressed("backward") && !(Input.is_action_just_released("sprint") || Input.is_action_just_released("quick_turn_secondary")):
            player.translate(Vector3(0, 0, -1 * move_speed) * delta)
        # Turn left and right 
        if Input.is_action_pressed("turn_left"):
            rotation += 0.1
        if Input.is_action_pressed("turn_right"):
            rotation -= 0.1

    # Rotate player based base value, and turn speed and delta for same reasons as movement
    player.rotate_y(rotation * turn_speed * delta)

    # Apply movement
    player.move_and_slide()
