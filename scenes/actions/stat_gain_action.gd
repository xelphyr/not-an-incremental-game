extends Action
class_name StatGainAction

@export var influencing_stat_name : StringName
@export var base_amount : float

var influencing_stat : Stat

func _ready() -> void:
	influencing_stat = StatManager.get_stat(influencing_stat_name)

func on_trigger() -> void:
	influencing_stat.add_amount(base_amount)
