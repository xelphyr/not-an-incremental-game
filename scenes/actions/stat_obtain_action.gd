extends Node

@export var inflencing_stat_name : StringName
@export var base_amount : float

var influencing_stat : Stat

func _ready() -> void:
	influencing_stat = StatManager.get_stat(inflencing_stat_name)

func _on_trigger() -> void:
	
