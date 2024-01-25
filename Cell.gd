class_name Cell extends Button

signal cell_clicked(x, y)

const flag_icon = preload("res://icon-flag.svg")
const explode_icon = preload("res://icon-explosion.svg")
const bomb_icon = preload("res://icon-bomb.svg")

enum CELL_STATE {HIDDEN, FLAGGED, REVEALED, EXPLODED}

var x : int = 0
var y : int = 0
@onready var state : CELL_STATE = CELL_STATE.HIDDEN
@onready var bomb : bool = false
@onready var neighbor_bombs : int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gui_input(event):
	if event.is_action_pressed("left_click"):
		prints("left click ", x, ",", y )
		if state == CELL_STATE.HIDDEN:
			cell_clicked.emit(x, y)
	elif event.is_action_pressed("right_click"):
		prints("right click ", x, ",", y )
		if state == CELL_STATE.HIDDEN:
			state = CELL_STATE.FLAGGED
			icon = flag_icon
		elif state == CELL_STATE.FLAGGED:
			state = CELL_STATE.HIDDEN
			icon = null


func reveal():
	disabled = true
	if bomb:
		state = CELL_STATE.EXPLODED
		text = ""
		icon = explode_icon
	#elif neighbor_bombs > 0:
		#text = str(neighbor_bombs)
	else:
		state = CELL_STATE.REVEALED
		text = str(neighbor_bombs)
