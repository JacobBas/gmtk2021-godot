extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func check_win():
	var win:bool = true
	for sub_goal in get_children():
		if ! sub_goal.check_win():
			win = false
	return win
	
func _process(delta):
	check_win()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
