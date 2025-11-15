extends StaticBody2D
class_name Platform

@export var id : int
@export var connections : Dictionary[int, CollisionShape2D]
@export var default_enabled : bool = false

func _ready() -> void:
	SignalBus.platform_unlocked.connect(_on_platform_unlocked)
	if default_enabled:
		_enable_platform()
	else:
		_disable_platform()
	

func _on_platform_unlocked(unlocked_id : int):
	if unlocked_id == id:
		_enable_platform()
	if unlocked_id in connections:
		connections[unlocked_id].set_deferred("disabled", true)
	
func _disable_platform() -> void:
	visible = false

func _enable_platform() -> void:
	visible = true
