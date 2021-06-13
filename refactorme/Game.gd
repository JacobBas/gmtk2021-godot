extends Node

var background = preload("res://refactorme/files/Loop 1 - Jazzy.mp3")
var sound_direct = preload("res://refactorme/sound_direct.tscn")

var level_mapping_jank = { 

	# as more levels are added, uncomment below and make the last level end on end screen
	"Joined_Apart" : "Opposites",
	"Opposites" : "Snakes",
	"Snakes" : "Offset",
	"Offset" : "Spirals",
	"Spirals" : "Sticky_Situation",
	"Sticky_Situation" : "Sticky_Situation2",
	"Sticky_Situation2" : "Joined_Together",
	"Joined_Together" : "Sticky_Situation3",
	"Sticky_Situation3" : "Rotation",
	"Rotation" : "Order_Of_Operations",
	"Order_Of_Operations" : "Flippy",
	"Flippy" : "Whippy",
	"Whippy" : "End_Screen",
}

func _ready():
	#SceneChanger.change_scene("Level_01")
	var sound = sound_direct.instance()
	add_child(sound)
	sound.play_sound(background)
	
	get_tree().change_scene(Global.add_scn_pth(level_mapping_jank.keys()[0]))

func _unhandled_input(event):
	if event.is_action_released("Restart"):
		get_tree().change_scene(Global.add_scn_pth(get_tree().current_scene.name))

	

