extends Area2D

# Declare member variables here. Examples:
var tile_size : int = 32
var last_press: String = ""
var walls : Array

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

func _unhandled_input(event):
	walls = self.get_parent().get_node("Walls").get_used_cells()
	for item in walls:
		if position == item:
			print(item)
			
	# checking the rotational movements
	for dir in inputs_rotate.keys():
		if event.is_action_released(dir):
			print(dir)
			print(last_press)
			if inputs_rotate[dir][0] == last_press:
				last_press = ""
				rotation_degrees += inputs_rotate[dir][1]
				return null

	# checking the reflectional movements
	for dir in inputs_reflect.keys():
		if event.is_action_released(dir):
			print(dir)
			print(last_press)
			if inputs_reflect[dir][0] == last_press:
				last_press = ""
				var rot = int(abs(int(rotation_degrees)))
				if rot % 180 == 90:
					scale.y = scale.y * inputs_reflect[dir][1]
				else:
					scale.x = scale.x * inputs_reflect[dir][1]
				return null
			
	# checking the translational movements
	for dir in inputs_trans.keys():
		if event.is_action_released(dir):
			print(dir)
			print(last_press)
			if inputs_trans[dir][0] == last_press:
				last_press = ""
				position += inputs_trans[dir][1] * tile_size
				return null
			else:
				last_press = dir
	

