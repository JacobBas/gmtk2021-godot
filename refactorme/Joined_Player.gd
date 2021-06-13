extends Area2D

# pulling in the global variables
onready var global = get_node("/root/Global")

# Declare member variables here. Examples:
var tile_size : int = 32
var last_press: String = ""
var final_buffer_length : int = 300 #milliseconds
var buffer_countdown : int = final_buffer_length

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
	
func rotate_clockwise(pos_vector):
	return Vector2(int(round(pos_vector[1]/32)), int(round(-pos_vector[0]/32)))
	
func rotate_counter(pos_vector):
	return Vector2(int(round(-pos_vector[1]/32)), int(round(pos_vector[0]/32)))
	
var inputs_rotate = {
	"Arrow_Up": ["WASD_Down", "rotate_clockwise"],
	"Arrow_Down": ["WASD_Up", "rotate_counter"],
	"WASD_Up": ["Arrow_Down", "rotate_counter"],
	"WASD_Down": ["Arrow_Up", "rotate_clockwise"]
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

func _process(delta):
	# Clear the buffer_press after final_buffer_length milliseconds have elapsed
	if ! last_press == "":
		buffer_countdown -= delta * 1000
		if buffer_countdown < 0:
			last_press = ""
			buffer_countdown = final_buffer_length
	else :
		buffer_countdown = final_buffer_length

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
	
	# checking the rotational movements
	for dir in inputs_rotate.keys():
		if event.is_action_released(dir):
			if inputs_rotate[dir][0] == last_press:
				# clearing the buffer
				last_press = ""
				# checking to see if there are collisions
				# checking to see if thie is a valid move
				for pos in dup_node.get_children():
					pos.position = call(inputs_rotate[dir][1], pos.position)
					if (pos.position + get_parent_pos(dup_node)) in walls:
						valid_move = false

				# if there is no collision then we make the move
				if valid_move:
					# adding 1 to the global move counter
					global.move_counter += 1
					var move_counter = get_parent().get_node("MoveCounter")
					# clearing the pre-existing text
					move_counter.clear()
					# adding in the new text
					move_counter.add_text(str(global.move_counter))
					for pos in self.get_children():
						pos.position = call(inputs_rotate[dir][1], pos.position) * 32
					
				# returning out of the function
				return null

	# checking the reflectional movements
	for dir in inputs_reflect.keys():
		if event.is_action_released(dir):
			if inputs_reflect[dir][0] == last_press:
				# clearing the buffer
				last_press = ""
				# checking to see if thie is a valid move
				for pos in dup_node.get_children():
					pos.position = Vector2(pos.position[0] * (-1), pos.position[1])/32
					if (pos.position + get_parent_pos(dup_node)) in walls:
						valid_move = false
						
				# if a valid move then we make the reflection
				if valid_move:
					# adding 1 to the global move counter
					global.move_counter += 1
					var move_counter = get_parent().get_node("MoveCounter")
					# clearing the pre-existing text
					move_counter.clear()
					# adding in the new text
					move_counter.add_text(str(global.move_counter))
					for pos in self.get_children():
						pos.position = Vector2(pos.position[0] * (-1), pos.position[1])
						
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
					# adding 1 to the global move counter
					global.move_counter += 1
					var move_counter = get_parent().get_node("MoveCounter")
					# clearing the pre-existing text
					move_counter.clear()
					# adding in the new text
					move_counter.add_text(str(global.move_counter))
					self.position += inputs_trans[dir][1] * tile_size
					
				# returning null out of the function
				return null
			
			else:
				# setting the buffer to the most recent move
				last_press = dir
	

