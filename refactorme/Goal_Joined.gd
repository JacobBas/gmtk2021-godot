extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var audio_file = preload("res://refactorme/files/goal.mp3")
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
	if get_parent().has_node("Joined_Player"):
		print("here")
		var win : bool = true
		var goal_tiles = get_used_cells()
		#print(goal_tiles)

		if ! goal_tiles.size() == Global.unique_pos(get_parent().get_node("Joined_Player").get_children()).size():
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
