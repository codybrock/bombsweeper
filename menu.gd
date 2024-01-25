extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_button_pressed():
	get_tree().quit()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		print("UI_CANCEL")
		get_tree().quit()


func _on_play_button_pressed():
	# validate
	var h = int($MarginContainer/VBoxContainer/Height/GridHeightLineEdit.text)
	var w = int($MarginContainer/VBoxContainer/Width/GridWidthLineEdit.text)
	var b = int($MarginContainer/VBoxContainer/Bombs/NumBombsLineEdit.text)
	
	if h * w < b:
		print("too many bombs, homie. stuff's dangerous")
		return
	
	Global.height = h
	Global.width = w
	Global.bombs = b
	
	get_tree().change_scene_to_file("res://bombsweeper.tscn")
