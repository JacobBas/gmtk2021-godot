extends Area2D

# Declare member variables here. Examples:
var tile_size : int = 32
var buffer_press: String = ""

var inputs = {"Arrow_Right": 1,
			"Arrow_Left": 1,
			"Arrow_Up": 1,
			"Arrow_Down": 1,
			"WASD_Right": 1,
			"WASD_Left": 1,
			"WASD_Up": 1,
			"WASD_Down": 1
}

var inputs_wasd = { # These combos are the vector direction for Arrow_Player
	"Arrow_Right.WASD_Right" : Vector2.RIGHT,
	"Arrow_Left.WASD_Right" : Vector2.RIGHT,
	"Arrow_Up.WASD_Right" : Vector2.RIGHT,
	"Arrow_Down.WASD_Right" : Vector2.RIGHT,
	"Arrow_Right.WASD_Left" : Vector2.LEFT,
	"Arrow_Left.WASD_Left" : Vector2.LEFT,
	"Arrow_Up.WASD_Left" : Vector2.LEFT,
	"Arrow_Down.WASD_Left" : Vector2.LEFT,
	"Arrow_Right.WASD_Up" : Vector2.UP,
	"Arrow_Left.WASD_Up" : Vector2.UP,
	"Arrow_Up.WASD_Up" : Vector2.UP,
	"Arrow_Down.WASD_Up" : Vector2.UP,
	"Arrow_Right.WASD_Down" : Vector2.DOWN,
	"Arrow_Left.WASD_Down" : Vector2.DOWN,
	"Arrow_Up.WASD_Down" : Vector2.DOWN,
	"Arrow_Down.WASD_Down" : Vector2.DOWN,
	"WASD_Right.Arrow_Right" : Vector2.RIGHT,
	"WASD_Right.Arrow_Left" : Vector2.RIGHT,
	"WASD_Right.Arrow_Up" : Vector2.RIGHT,
	"WASD_Right.Arrow_Down" : Vector2.RIGHT,
	"WASD_Left.Arrow_Right" : Vector2.LEFT,
	"WASD_Left.Arrow_Left" : Vector2.LEFT,
	"WASD_Left.Arrow_Up" : Vector2.LEFT,
	"WASD_Left.Arrow_Down" : Vector2.LEFT,
	"WASD_Up.Arrow_Right" : Vector2.UP,
	"WASD_Up.Arrow_Left" : Vector2.UP,
	"WASD_Up.Arrow_Up" : Vector2.UP,
	"WASD_Up.Arrow_Down" : Vector2.UP,
	"WASD_Down.Arrow_Right" : Vector2.DOWN,
	"WASD_Down.Arrow_Left" : Vector2.DOWN,
	"WASD_Down.Arrow_Up" : Vector2.DOWN,
	"WASD_Down.Arrow_Down" : Vector2.DOWN,
	"Arrow_Right.Arrow_Right" : Vector2.ZERO,
	"Arrow_Left.Arrow_Right" : Vector2.ZERO,
	"Arrow_Up.Arrow_Right" : Vector2.ZERO,
	"Arrow_Down.Arrow_Right" : Vector2.ZERO,
	"Arrow_Right.Arrow_Left" : Vector2.ZERO,
	"Arrow_Left.Arrow_Left" : Vector2.ZERO,
	"Arrow_Up.Arrow_Left" : Vector2.ZERO,
	"Arrow_Down.Arrow_Left" : Vector2.ZERO,
	"Arrow_Right.Arrow_Up" : Vector2.ZERO,
	"Arrow_Left.Arrow_Up" : Vector2.ZERO,
	"Arrow_Up.Arrow_Up" : Vector2.ZERO,
	"Arrow_Down.Arrow_Up" : Vector2.ZERO,
	"Arrow_Right.Arrow_Down" : Vector2.ZERO,
	"Arrow_Left.Arrow_Down" : Vector2.ZERO,
	"Arrow_Up.Arrow_Down" : Vector2.ZERO,
	"Arrow_Down.Arrow_Down" : Vector2.ZERO,
	"WASD_Right.WASD_Right" : Vector2.ZERO,
	"WASD_Left.WASD_Right" : Vector2.ZERO,
	"WASD_Up.WASD_Right" : Vector2.ZERO,
	"WASD_Down.WASD_Right" : Vector2.ZERO,
	"WASD_Right.WASD_Left" : Vector2.ZERO,
	"WASD_Left.WASD_Left" : Vector2.ZERO,
	"WASD_Up.WASD_Left" : Vector2.ZERO,
	"WASD_Down.WASD_Left" : Vector2.ZERO,
	"WASD_Right.WASD_Up" : Vector2.ZERO,
	"WASD_Left.WASD_Up" : Vector2.ZERO,
	"WASD_Up.WASD_Up" : Vector2.ZERO,
	"WASD_Down.WASD_Up" : Vector2.ZERO,
	"WASD_Right.WASD_Down" : Vector2.ZERO,
	"WASD_Left.WASD_Down" : Vector2.ZERO,
	"WASD_Up.WASD_Down" : Vector2.ZERO,
	"WASD_Down.WASD_Down" : Vector2.ZERO,



}

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	#position += Vector2.ONE * tile_size/2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_released(dir):
			print("is_action_released " + dir)
			if buffer_press == "" :
				buffer_press = dir
				print("buffer: " + buffer_press)
			else:
				move(dir + "." + buffer_press)
				buffer_press = ""
				print("buffer cleared!")
			print("moved: " + str(position))

func move(dir):
	position += inputs_wasd[dir] * tile_size
