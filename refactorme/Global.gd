extends Node2D

# global variables for the game
var move_counter : int = 0
onready var wasd_node = get_node("WASD_Players")
onready var arrow_node = get_node("Arrow_Players")
var area_ind : Area2D = Area2D.new()


func get_all_nodes(node):
	for N in node.get_children():
		if N.get_child_count() > 0:
			#print("["+N.get_name()+"]")
			get_all_nodes(N)
		else:
			# Do something
			print("- "+N.get_name())


func join_separate(pivot_pos):
	if not self.has_node("Joined_Player"):
		# relative positions from the pivot point
		var rel_positions = []
		# adding the wasd_node children to the array
		for child in wasd_node.get_children():
			rel_positions.append(child.position - pivot_pos)
		
		# adding the arrow_node children to the array
		for child in arrow_node.get_children():
			rel_positions.append(child.position - pivot_pos)
			
		# removing the wasd and arrow players from the screen
		wasd_node.queue_free()
		arrow_node.queue_free()

		# creating the new Joined_Player object	
		var scene = load("res://refactorme/Joined_Player.tscn")
		var scene_instance = scene.instance()
		
		# setting the Joined_Player attributes
		scene_instance.set_name("Joined_Player")
		scene_instance.position = pivot_pos

		# pulling out the initialized child values
		var scene_children = scene_instance.get_children().duplicate()

		# looping through all of the required postions
		for i in range(0, rel_positions.size()):
			if not (rel_positions[i] == Vector2(0,0)):
				# looping the initialized children
				for child in scene_children:
					# duplicating the child object
					var scene_child = child.duplicate()
					# setting the child object attributes 
					scene_child.set_name(str(child.get_name()) + str(i))
					scene_child.position = rel_positions[i]
					# adding the child to the Joine_Player scene
					scene_instance.add_child(scene_child)

		# adding in a rotation indicator
		var texture = load("res://refactorme/files/rotate-yellow.png")
		var sprite = Sprite.new()
		sprite.set_texture(texture)
		sprite.scale = sprite.scale * .2
		
		# adding the sprite to the scene
		scene_instance.add_child(sprite)

		# adding the joined player node to the screen
		self.add_child(scene_instance)


# running a background process
func _process(delta):
	# checking is wasd_node is none null
	if self.has_node("WASD_Players") and self.has_node("Arrow_Players"):
		# looping through the wasd_children
		for wasd_child in wasd_node.get_children():
			# loping through the arrow_children
			for arrow_child in arrow_node.get_children():
				# checking to see if there are any overlapping points
				if wasd_child.position == arrow_child.position:
					join_separate(wasd_child.position)

func unique_pos(arr : Array):
	var uni : Array
	if arr.size() > 0:
		for i in range(arr.size()) :
			var is_dupl = false
			for j in range(uni.size()) :
				if uni[j].position == arr[i].position :
					is_dupl = true
			if ! is_dupl :
				uni.append(arr[i])
	return uni

func add_scn_pth(scn):
	return "res://refactorme/levels/"+scn+".tscn"
