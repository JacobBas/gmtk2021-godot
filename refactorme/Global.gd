extends Node2D

# global variables for the game
var move_counter : int = 0


func get_all_nodes(node):
	for N in node.get_children():
		if N.get_child_count() > 0:
			#print("["+N.get_name()+"]")
			get_all_nodes(N)
		else:
			# Do something
			print("- "+N.get_name())

func add_scn_pth(scn):
	return "res://refactorme/levels/"+scn+".tscn"
