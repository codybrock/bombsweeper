extends Node2D

@onready var map: Map = $Map

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
		print("BOMB! YOU LOSE!")
		active = false
		cell.reveal()
		map.show_bombs()
	elif cell.neighbor_bombs == 0:
		# reveal cell and all neighbors
		map.reveal_neighbors(cell)
	else:
		cell.reveal()


