extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StatManager.get_stat(&"souls").val_modified.connect(update_display)
	text = "Souls: 0"

func update_display(amount: float) -> void:
	text = ("Souls: %f" % amount)
