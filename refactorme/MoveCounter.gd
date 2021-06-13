extends RichTextLabel

# pulling in the global variables
onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = str(global.move_counter)

# for updating the counter
func progress_counter(text_value):
	self.set_text(text_value)
