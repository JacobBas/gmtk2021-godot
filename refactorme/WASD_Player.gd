extends Sprite

# Declare member variables here. Examples:
var tile_size : int = 32

var inputs = {"WASD_Right": Vector2.RIGHT,
			"WASD_Left": Vector2.LEFT,
			"WASD_Up": Vector2.UP,
			"WASD_Down": Vector2.DOWN}

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
			move(dir)
			print("moved: " + str(position))

func move(dir):
	position += inputs[dir] * tile_size
