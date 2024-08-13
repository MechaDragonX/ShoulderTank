extends Node

@onready var x_node = $CameraX
@onready var y_node = $CameraX/CameraY
@onready var camera = $CameraX/CameraY/Camera3D

# X and Y specifically refers to horizontal and vertical values relative player view
# As opposed to the actual axes in game
# Basically just yaw and pitch, but I find this easier to read

# Final x and y rotation values
var x: float = 0
var y: float = 0

# Degree to which input is manipulated to create final values
# Mouse
var x_sensitivity_mouse: float = 0.07
var y_sensitivity_mouse: float = 0.07
# Controller
var x_sensitivity_con: float = 2
var y_sensitivity_con: float = 2

# Acceleration when lerping between values
# var x_acceleration: float = 15
# var x_accerlation: float = 15

# Minimum and maximum rotation values to lock camera
var x_max: float = 30
var x_min: float = -30
var y_max: float = 30
var y_min: float = -30

# Called when the node enters the scene tree for the first time.
func _ready():
    # lock and hide mouse within game
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    # Check for controller stick movement every frame, as opposed to with input events
    # since that happened to fix sttutering
    if Input.is_action_pressed("camera_up") || Input.is_action_pressed("camera_down"):
        # If so, change the x and y rotation by the sensitivity value
        # Negate the raw value to make sure moving right moves it right
        y += -Input.get_joy_axis(0, 3) * y_sensitivity_con
    if Input.is_action_pressed("camera_left") || Input.is_action_pressed("camera_right"):
        x += -Input.get_joy_axis(0, 2) * x_sensitivity_con

func _input(event):
    # Check to see if the mouse was moved
    if event is InputEventMouseMotion:
        # If so, change the x and y rotation by the sensitivity value
        # Negate the raw value to make sure moving right moves it right
        x += -event.relative.x * x_sensitivity_mouse
        y += -event.relative.y * y_sensitivity_mouse
    # Check if the keys/buttons for reseting the camera are pressed
    if Input.is_action_pressed("reset_camera"):
        # Reset x and y values
        x = 0
        y = 0

func _physics_process(delta):
    # Prevent the x and y values from going beyond min and max vars
    x = clamp(x, x_min, x_max)
    y = clamp(y, y_min, y_max)

    # x_node.rotation_degrees.y = lerp(x_node.rotation_degrees.y, x, x_acceleration * delta)
    # y_node.rotation_degrees.x = lerp(y_node.rotation_degrees.x, y, x_accerlation * delta)

    # Set changed x and y yvalues to the rotation
    x_node.rotation_degrees.y = x
    y_node.rotation_degrees.x = y
