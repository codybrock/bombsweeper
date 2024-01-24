extends Node2D

const MAP = preload("res://map.tscn")

@onready var grid : Array


func _init():
	var map = MAP.instantiate()
	add_child(map)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
