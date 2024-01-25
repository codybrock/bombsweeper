extends Node2D

@onready var map: Map = $CanvasLayer/Control/MarginContainer/Map
@onready var win_lose_panel = $CanvasLayer/Control/MarginContainer3/WinLosePanel
@onready var win_lose_label = $CanvasLayer/Control/MarginContainer3/WinLosePanel/MarginContainer/Label

var active = false
var first_click = true


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in map.cells.size():
		for j in map.cells[i].size():
			var cell = map.cells[i][j]
			cell.cell_clicked.connect(_on_cell_clicked)
	active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cell_clicked(x, y):
	if not active:
		return
	#prints("CLICKETY-CLICK (", x, ",", y, ")")
	if first_click:
		first_click = false
		map.generate(x, y)
		map.debug_print()
		
	var cell: Cell = map.cells[y][x]
	if cell.bomb:
		# reveal all bombs, end game
		active = false
		cell.reveal()
		map.show_bombs()
		win_lose_label.text = "You Lose!"
		win_lose_panel.visible = true
	else:
		if cell.neighbor_bombs == 0:
			# reveal cell and all neighbors
			map.reveal_neighbors(cell)
		else:
			cell.reveal()
		if map.check_win():
			active = false
			map.show_bombs()
			win_lose_label.text = "You Win!"
			win_lose_panel.visible = true
			


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		print("UI_CANCEL")
		get_tree().change_scene_to_file("res://menu.tscn")


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
