class_name Map extends GridContainer

const CELL = preload("res://cell.tscn")

@export var width : int = 20
@export var height : int = 20
@export var bombs : int = 20

@onready var cells : Array


# Called when the node enters the scene tree for the first time.
func _ready():
	columns = width
	for i in height:
		cells.append([])
		for j in width:
			var cell = CELL.instantiate()
			cell.x_pos = i
			cell.y_pos = j
			cells[i].append(cell)
			add_child(cell)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func generate_map(first_x, first_y):
	# Place mines
	for i in bombs:
		while true:
			var x = randi_range(0, width)
			var y = randi_range(0, height)
			if !(x == first_x and y == first_y) and cells[x][y].bomb == false:
				cells[x][y].bomb == true
				break
	# Check neighbors
	var neighbor_vectors = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
	for i in cells:
		for j in cells[i]:
			var cell = cells[i][j]
			if cell.bomb:
				for vec in neighbor_vectors:
					var dx = vec[0]
					var dy = vec[1]
					var n_cell = cells[i + dx][j + dy]
					n_cell.neighbor_bombs += 1


