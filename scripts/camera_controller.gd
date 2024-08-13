extends Node

@onready var x_node = $CameraX
@onready var y_node = $CameraX/CameraY
@onready var camera = $CameraX/CameraY/Camera3D

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
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var right_x: float = 0.0
    var right_y: float = 0.0

    if Input.get_connected_joypads().size() > 0:
        right_x = Input.get_joy_axis(0, 2)
        right_y = Input.get_joy_axis(0, 3)

        x += -right_x * x_sensitivity_con
        y += -right_y * y_sensitivity_con

func _input(event):
    if event is InputEventMouseMotion:
        x += -event.relative.x * x_sensitivity_mouse
        y += -event.relative.y * y_sensitivity_mouse
    elif Input.is_action_pressed("reset_camera"):
        x = 0
        y = 0

func _physics_process(delta):
    x = clamp(x, x_min, x_max)
    y = clamp(y, y_min, y_max)

    # x_node.rotation_degrees.y = lerp(x_node.rotation_degrees.y, x, x_acceleration * delta)
    # y_node.rotation_degrees.x = lerp(y_node.rotation_degrees.x, y, x_accerlation * delta)
    
    x_node.rotation_degrees.y = x
    y_node.rotation_degrees.x = y
