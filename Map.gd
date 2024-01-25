class_name Map extends GridContainer

const CELL = preload("res://cell.tscn")

@onready var cells : Array


# Called when the node enters the scene tree for the first time.
func _ready():
	columns = Global.width
	for i in Global.height:
		cells.append([])
		for j in Global.width:
			var cell = CELL.instantiate()
			cell.x = j
			cell.y = i
			#cell.text = str(cell.x, ",", cell.y)
			cells[i].append(cell)
			add_child(cell)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func generate(first_x, first_y):
	prints("first: ", first_x, ",", first_y)
	# TODO: make first click 0 instead of just not bomb. use get_cell_neighbors
	#prints("GENERATE: first x =", first_x, "| first y =", first_y)
	var no_zone = get_cell_neighbors(cells[first_y][first_x])
	no_zone.append(cells[first_y][first_x])
	# Place mines
	for i in Global.bombs:
		prints("bomb #", i+1, ":")
		while true:
			var x = randi_range(0, Global.width-1)
			var y = randi_range(0, Global.height-1)
			prints("  randomly selected (", x, ",", y, ")")
			prints("    no zone:", no_zone)
			# if random cell is the first click or a neighbor, try again
			var bad_spot = false
			for c in no_zone:
				prints("        match?", c.x, ",", c.y)
				if x == c.x and y == c.y:
					print("          yes")
					bad_spot = true
					break
				print("          no")
			if bad_spot:
				print("        matches bad spot, don't add bomb, try again")
				continue
			#print("BOMB!")
			print("        no match, add bomb")
			cells[y][x].bomb = true
			break
			#else:
				#print("either first cell or already a bomb")
	# Check neighbors
	#print("\n\nCHECKING BOMB NEIGHBORS")
	var neighbor_vectors = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
	for i in cells.size():
		for j in cells[i].size():
			var cell = cells[j][i]
			if cell.bomb:
				for c in get_cell_neighbors(cell):
					c.neighbor_bombs += 1


func get_cell_neighbors(cell: Cell):
	var neighbor_vectors = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
	var list = []
	for vec in neighbor_vectors:
		var dx = cell.x + vec[0]
		var dy = cell.y + vec[1]
		# check on map
		if 0 <= dx and dx < cells[0].size() and 0 <= dy and dy < cells.size():
			list.append(cells[dy][dx] as Cell)
	return list


func reveal_neighbors(cell: Cell):
	# reveal central cell
	cell.reveal()
	# reveal all applicable neighbors
	for c in get_cell_neighbors(cell):
		if c.state == Cell.CELL_STATE.HIDDEN:
			# check for cascading zeroes
			if c.neighbor_bombs == 0:
				print("neighbor is also 0")
				reveal_neighbors(c)
			# else just reveal
			else:
				c.reveal()


func show_bombs():
	for i in cells.size():
		for j in cells[i].size():
			var cell: Cell = cells[j][i]
			if cell.bomb and cell.state == Cell.CELL_STATE.HIDDEN:
				cell.icon = Cell.bomb_icon


func check_win():
	for i in cells.size():
		for j in cells[i].size():
			var cell: Cell = cells[j][i]
			if not cell.bomb and cell.state == Cell.CELL_STATE.HIDDEN:
				return false
	return true


func debug_print():
	for i in cells.size():
		var row = ""
		for j in cells[i].size():
			var cell: Cell = cells[i][j]
			if cell.bomb:
				row = str(row, "x")
			elif cell.neighbor_bombs == 0:
				row = str(row, "-")
			else:
				row = str(row, cell.neighbor_bombs)
		print(row)
