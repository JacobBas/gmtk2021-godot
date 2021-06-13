extends CanvasLayer

signal scene_changed()

func change_scene(path, delay = 1.5):
#	var animation_player : AnimationPlayer = get_node("AnimationPlayer")
#	print(animation_player)
#	var black = get_node("Control/Black")
	yield(get_tree().create_timer(delay), "timeout")
#	print(animation_player)
#	animation_player.play("fade")
#	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
#	animation_player.play_backwards("fade")

func change_scene_quickly(path) :
	change_scene(path, 0.2)
