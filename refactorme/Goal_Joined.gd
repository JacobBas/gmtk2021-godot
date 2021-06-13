extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var final_clock : int = 20
var clock : int = final_clock

var triggered_level_win : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	clock -= 1
	if clock == 0:
		check_win()
		#print("checking win")
		clock = final_clock

func check_win() :
	var win : bool = true
	var goal_tiles = get_used_cells()
	#print(goal_tiles)
	if ! goal_tiles.size() * 2 == get_parent().get_node("Joined_Player").get_child_count():
		win = false
		#print("size check failed")
	for pos in get_parent().get_node("Joined_Player").get_children():
		var checks_out = false
		var joined_pos : Vector2 = Vector2((pos.position.x + get_parent().get_node("Joined_Player").position[0]-16)/32, (pos.position.y + get_parent().get_node("Joined_Player").position[1]-16)/32)
		print(joined_pos)
		if (joined_pos) in goal_tiles:
			checks_out = true
		if ! checks_out :
			win = false
	if win :
		#print("Win")
		trigger_level_win()

func trigger_level_win():
	if ! triggered_level_win:
		print("TRIGGERED")
		var audio_file = "res://refactorme/files/egregious.mp3"
		if File.new().file_exists(audio_file):
			var speech_player = get_parent().get_node("AudioStreamPlayer")
			print("file exists")
			var sfx = load(audio_file) 
			sfx.set_loop(false)
			speech_player.stream = sfx
			speech_player.pitch_scale = 0.9
			speech_player.play()
		triggered_level_win = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
