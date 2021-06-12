extends Area2D

# Declare member variables here. Examples:
var tile_size : int = 32
var buffer_press: String = ""
var block_size : int = 1

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
	pass
	#position = position.snapped(Vector2.ONE * tile_size)
	#position += Vector2.ONE * tile_size/2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_released(dir):
			print("is_action_released " + dir)
			#buffer was empty
			if buffer_press == "" :
				buffer_press = dir
				print("buffer: " + buffer_press)
			#buffer was full
			else:
				# if moving into sticky block, convert block into WASD Player, but don't move
				var stuck : bool = false
				var sticky
				for t_sticky in self.get_parent().get_parent().get_node("Sticky_Boxes").get_children():
					print("Going to: " + str(position + inputs_wasd[dir + "." + buffer_press] * tile_size))
					if position + inputs_wasd[dir + "." + buffer_press] * tile_size == t_sticky.position:
						stuck = true
						sticky = t_sticky
				if stuck :
					print("STICK!")
					convert_sticky(sticky)
				else:
					move(dir + "." + buffer_press)
				buffer_press = ""
				print("buffer cleared!")


func convert_sticky(sticky):
	# This basically just deletes the sticky box and creates a player instead
	block_size += 1
	var temp_name : String = ("WASD_Player" + str(block_size))
	print("Converting Sticky: " + temp_name)
	var temp_pos : Vector2 = sticky.position
	sticky.queue_free() # delete the Sticky_Box pass through the function
	var scene = load("res://refactorme/WASD_Player.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name(temp_name)
	get_parent().add_child(scene_instance)
	get_parent().get_node(temp_name).position = temp_pos
	print(get_parent().get_node(temp_name))
	for w in get_parent().get_children() :
		print(str(w.get_name()) + ": " + str(w.position))
	 
func move(dir):
	position += inputs_wasd[dir] * tile_size
	print("moved: " + str(position))
