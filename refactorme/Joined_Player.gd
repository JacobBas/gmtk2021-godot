extends Area2D

# Declare member variables here. Examples:
var tile_size : int = 32
var last_press: String = ""

var inputs_trans = {
	"Arrow_Right": ["WASD_Right", Vector2.RIGHT],
	"Arrow_Left": ["WASD_Left", Vector2.LEFT],
	"Arrow_Up": ["WASD_Up", Vector2.UP],
	"Arrow_Down": ["WASD_Down", Vector2.DOWN],
	"WASD_Right": ["Arrow_Right", Vector2.RIGHT],
	"WASD_Left": ["Arrow_Left", Vector2.LEFT],
	"WASD_Up": ["Arrow_Up", Vector2.UP],
	"WASD_Down": ["Arrow_Down", Vector2.DOWN]
	}
	
var inputs_rotate = {
	"Arrow_Up": ["WASD_Down", -90],
	"Arrow_Down": ["WASD_Up", 90],
	"WASD_Up": ["Arrow_Down", 90],
	"WASD_Down": ["Arrow_Up", -90]
}
	
var inputs_reflect = {
	"Arrow_Right": ["WASD_Left", -1],
	"Arrow_Left": ["WASD_Right", -1],
	"WASD_Right": ["Arrow_Left", -1],
	"WASD_Left": ["Arrow_Right", -1]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_parent_pos(node):
	return Vector2((node.position[0] - 16)/32, (node.position[1] - 16)/32)

func get_children_pos(node):
	var parent_pos = get_parent_pos(node)
	var children_pos : Array = []
	for child in node.get_children():
		var pos : Vector2 = Vector2((child.position[0])/32, (child.position[1])/32)
		pos = pos + parent_pos
		children_pos.append(pos)
	return children_pos

func get_walls_node():
	return self.get_parent().get_node("Walls")

func _unhandled_input(event):
	# getting the position of the walls
	var walls = get_walls_node().get_used_cells()
	# creating a duplicate of the node to test collisions
	var dup_node = self.duplicate()
	# setting the valid move variable
	var valid_move = true
	
	print(str(self.rotation_degrees) + str(dup_node.rotation_degrees))
	print(str(self.scale) + str(dup_node.scale))
	print(str(self.position) + str(dup_node.position))
	
	# checking the rotational movements
	for dir in inputs_rotate.keys():
		if event.is_action_released(dir):
			if inputs_rotate[dir][0] == last_press:
				# clearing the buffer
				last_press = ""
				# checking to see if there are collisions
				dup_node.rotation_degrees += inputs_rotate[dir][1]
				for pos in get_children_pos(dup_node):
					print(pos)
					if pos in walls:
						valid_move = false
					
				# if there is no collision then we make the move
				if valid_move:
					self.rotation_degrees += inputs_rotate[dir][1]
					
				# returning out of the function
				return null

	# checking the reflectional movements
	for dir in inputs_reflect.keys():
		if event.is_action_released(dir):
			if inputs_reflect[dir][0] == last_press:
				# clearing the buffer
				last_press = ""
				# setting the current rotation paramenter
				var rot = int(abs(int(rotation_degrees)))
				# finding if we should do a horizonal or vertical reflection
				if rot % 180 == 90:
					# checking to see if thie is a valid move
					dup_node.scale.y = scale.y * inputs_reflect[dir][1]
					for pos in get_children_pos(dup_node):
						if pos in walls:
							valid_move = false
							
					# if a valid move then we make the reflection
					if valid_move:
						self.scale.y = self.scale.y * inputs_reflect[dir][1]
						
				else:
					# checking to see if thie is a valid move
					dup_node.scale.x = scale.x * inputs_reflect[dir][1]
					for pos in get_children_pos(dup_node):
						if pos in walls:
							valid_move = false
							
					# if a valid move then we make the reflection
					if valid_move:
						self.scale.x = self.scale.x * inputs_reflect[dir][1]
						
				# returning null out of the function
				return null
			
	# checking the translational movements
	for dir in inputs_trans.keys():
		if event.is_action_released(dir):
			if inputs_trans[dir][0] == last_press:
				# clearing the buffer
				last_press = ""
				# checking to see if thie is a valid move
				dup_node.position += inputs_trans[dir][1] * tile_size
				for pos in get_children_pos(dup_node):
					if pos in walls:
						valid_move = false
				
				# if a valid move then we make the reflection
				if valid_move:
					self.position += inputs_trans[dir][1] * tile_size
					
				# returning null out of the function
				return null
			
			else:
				# setting the buffer to the most recent move
				last_press = dir
	

