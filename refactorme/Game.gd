extends Node

var background = preload("res://refactorme/files/Loop 1 - Jazzy.mp3")
var sound_direct = preload("res://refactorme/sound_direct.tscn")

var level_mapping_jank = { 
	# as more levels are added, uncomment below and make the last level end on end screen
	"Level_00" : "Level_01",
	"Level_01" : "Level_02",
	"Level_02" : "Level_03",
	"Level_03" : "Level_04",
	"Level_04" : "End_Screen"
#	"Level_04" : "Level_05",
#	"Level_05" : "Level_06",
#	"Level_06" : "Level_07",
#	"Level_07" : "Level_08",
#	"Level_08" : "Level_09",
#	"Level_09" : "Level_10",
#	"Level_10" : "Level_11",
#	"Level_11" : "Level_12",
#	"Level_12" : "Level_13",
#	"Level_13" : "Level_14",
#	"Level_14" : "Level_15",
#	"Level_15" : "Level_16"
}

func _ready():
	#SceneChanger.change_scene("Level_01")
	var sound = sound_direct.instance()
	add_child(sound)
	sound.play_sound(background)
	
	get_tree().change_scene(Global.add_scn_pth(level_mapping_jank.keys()[0]))
	

