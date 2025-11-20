extends Label

@export var look_stat : StringName = &"growth"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StatManager.get_stat(look_stat).val_modified.connect(update_display)
	text = "%s: 0" % look_stat

func update_display(amount: float) -> void:
	text = ("%s: %f" % [look_stat, amount])
	print(text)
