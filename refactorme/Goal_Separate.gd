extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var audio_file = preload("res://refactorme/files/egregious.mp3")
var sound_direct = preload("res://refactorme/sound_direct.tscn")

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
	# checking to see if these two scenes are on the screen
	if get_parent().has_node("WASD_Players") and get_parent().has_node("Arrow_Players"):
		var win : bool = true
		var goal_tiles = get_used_cells()
		#print(goal_tiles)
		var wasd_tiles = get_parent().get_node("WASD_Players").get_children()
		var arrow_tiles = get_parent().get_node("Arrow_Players").get_children()
		if ! goal_tiles.size() == wasd_tiles.size() + arrow_tiles.size() :
			win = false
			#print("size check failed")
		for wasd_tile in wasd_tiles:
			var checks_out = false
			var wasd_pos : Vector2 = Vector2((wasd_tile.position[0]-16)/32, (wasd_tile.position[1]-16)/32)
			#print(wasd_pos)
			if wasd_pos in goal_tiles :
				checks_out = true
				#print("wasd in goal passed")
			if ! checks_out :
				win = false
		for arrow_tile in arrow_tiles:
			var checks_out = false
			var arrow_pos : Vector2 = Vector2((arrow_tile.position[0]-16)/32, (arrow_tile.position[1]-16)/32)
			#print(arrow_pos)
			if arrow_pos in goal_tiles :
				checks_out = true
				#print("arrow in goal passed")
			if ! checks_out :
				win = false
		if win :
			#print("Win")
			trigger_level_win()

func trigger_level_win():
	if ! triggered_level_win:
		print("TRIGGERED")
		var sound = sound_direct.instance()
		add_child(sound)
		sound.play_sound(audio_file)
		triggered_level_win = true
		var ky : String = get_tree().current_scene.name
		print(ky)
		SceneChanger.change_scene(Global.add_scn_pth(Game.level_mapping_jank[ky]))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
