extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	if event.is_action_released("Start_Game"):
		var ky : String = get_tree().current_scene.name
		SceneChanger.change_scene_quickly(Global.add_scn_pth(Game.level_mapping_jank[ky]))
