extends Sprite

# Declare member variables here. Examples:
var tile_size : int = 32
var last_press: String = ""

var inputs = {"Arrow_Right": Vector2.RIGHT,
			"Arrow_Left": Vector2.LEFT,
			"Arrow_Up": Vector2.UP,
			"Arrow_Down": Vector2.DOWN,
			"WASD_Right": Vector2.RIGHT,
			"WASD_Left": Vector2.LEFT,
			"WASD_Up": Vector2.UP,
			"WASD_Down": Vector2.DOWN}

var inputs_mapping = {"Arrow_Right": "WASD_Right",
			"Arrow_Left": "WASD_Left",
			"Arrow_Up": "WASD_Up",
			"Arrow_Down": "WASD_Down",
			"WASD_Right": "Arrow_Right",
			"WASD_Left": "Arrow_Left",
			"WASD_Up": "Arrow_Up",
			"WASD_Down": "Arrow_Down"}

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	#position += Vector2.ONE * tile_size/2


func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_released(dir):
			print(dir)
			print(last_press)
			if inputs_mapping[dir] == last_press:
				last_press = ""
				move(dir)
				print("moved: " + str(position))
			else:
				last_press = dir

func move(dir):
	position += inputs[dir] * tile_size
