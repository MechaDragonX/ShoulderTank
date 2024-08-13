extends Node

@export var player: CharacterBody3D
@export var mesh_root: Node3D
@export var camera_root: Node3D

# Is the player rotation at 0°?
var forwards: bool = true
var velocity: Vector3
var acceleration: float
var speed: float = 8

func _ready():
    pass

func _input(event):
    if Input.is_action_just_released("backward") && (Input.is_action_just_released("sprint") || Input.is_action_just_released("quick_turn_secondary")):
        player.rotate_y(PI)
        forwards = !forwards

func _physics_process(delta):
    var direction: Vector3 = Vector3.ZERO
    var rotation: float = 0
    
    if Input.is_action_pressed("movement"):
        if Input.is_action_pressed("forward"):
            if forwards:
                direction.z += 1
            else:
                direction.z -= 1
        if Input.is_action_pressed("backward") && !(Input.is_action_just_released("sprint") || Input.is_action_just_released("quick_turn_secondary")):
            if forwards:
                direction.z -= 1
            else:
                direction.z += 1
        if Input.is_action_pressed("turn_left"):
            rotation += 0.1
        if Input.is_action_pressed("turn_right"):
            rotation -= 0.1

    velocity.z = direction.z * speed
    player.velocity = velocity
    player.rotate_y(rotation)
    player.move_and_slide()
