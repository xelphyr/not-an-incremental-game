extends Node

@export var level : int = 0
@export var max_level : int = 10
@export var id : String 


func set_level(v:int) -> void:
	level = clampi(v, 0, max_level)
	_rebind()

func _rebind() -> void:
	for child in get_children():
		if child is UpgradeEffect:
			child.bind_and_apply("%s|%d" % [id, child.kind])
			
