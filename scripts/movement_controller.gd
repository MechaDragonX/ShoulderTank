extends Node

@export var player: CharacterBody3D

var velocity: Vector3
var acceleration: float
var move_speed: float = 8
var turn_speed: float = 10

func _ready():
    pass

func _input(event):
    if Input.is_action_just_released("backward") && (Input.is_action_just_released("sprint") || Input.is_action_just_released("quick_turn_secondary")):
        player.rotate_y(PI)

func _physics_process(delta):
    var rotation: float = 0

    if Input.is_action_pressed("movement"):
        if Input.is_action_pressed("forward"):
            player.translate(Vector3(0, 0, 1 * move_speed) * delta)
        if Input.is_action_pressed("backward") && !(Input.is_action_just_released("sprint") || Input.is_action_just_released("quick_turn_secondary")):
            player.translate(Vector3(0, 0, -1 * move_speed) * delta)
        if Input.is_action_pressed("turn_left"):
            rotation += 0.1
        if Input.is_action_pressed("turn_right"):
            rotation -= 0.1

    player.rotate_y(rotation * turn_speed * delta)
    player.move_and_slide()
