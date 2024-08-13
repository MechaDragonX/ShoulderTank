extends Node

@export var player: CharacterBody3D
@export var mesh_root: Node3D
@export var rotation_speed: float = 8

var velocity: Vector3
var acceleration: float
var speed: float = 8

func _ready():
    pass

func _input(event):
    if Input.is_action_just_released("backward") && (Input.is_action_just_released("sprint") || Input.is_action_just_released("quick_turn_secondary")):
        #mesh_root.rotate(Vector3(0, 1, 0), 1)
        pass

func _physics_process(delta):
    var direction: Vector3 = Vector3.ZERO
    var rotation: float = 0
    
    if Input.is_action_pressed("movement"):
        if Input.is_action_pressed("forward"):
            direction.z += 1
        if Input.is_action_pressed("backward"):
            direction.z -= 1
        if Input.is_action_pressed("turn_left"):
            rotation += 0.1
        if Input.is_action_pressed("turn_right"):
            rotation -= 0.1

    velocity.z = direction.z * speed
    player.velocity = velocity
    player.rotate_y(rotation)
    player.move_and_slide()

#func _on_set_movement_state(_movement_state: MovementState):
    #speed = _movement_state.movement_speed
    #acceleration = _movement_state.acceleration
#
#func _on_set_movement_direction(_movement_direction: Vector3):
    #direction = _movement_direction
