class_name Cell extends Button

enum CELL_STATE {HIDDEN, FLAGGED, REVEALED, EXPLODED}

@export var bomb : bool = false
@export var state : CELL_STATE = CELL_STATE.HIDDEN

var x_pos : int = 0
var y_pos : int = 0
var neighbor_bombs : int = 0

	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#
#func _on_pressed():
	#disabled = true


func _on_gui_input(event):
	if event.is_action_pressed("left_click"):
		prints("left click ", x_pos, ",", y_pos )
		disabled = true
	elif event.is_action_pressed("right_click"):
		prints("right click ", x_pos, ",", y_pos )
		disabled = true
