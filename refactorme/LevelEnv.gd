extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var walls


func get_all_nodes(node):
	for N in node.get_children():
		if N.get_child_count() > 0:
			#print("["+N.get_name()+"]")
			get_all_nodes(N)
		else:
			# Do something
			print("- "+N.get_name())

<<<<<<< HEAD
=======


# Called when the node enters the scene tree for the first time.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
>>>>>>> 41e32c4782141e576a030522d983c6ccfc9e5c17
