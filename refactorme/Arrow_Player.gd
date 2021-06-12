extends Sprite

# Declare member variables here. Examples:
var tile_size : int = 32

var inputs = {"Arrow_Right": Vector2.RIGHT,
			"Arrow_Left": Vector2.LEFT,
			"Arrow_Up": Vector2.UP,
			"Arrow_Down": Vector2.DOWN}

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
