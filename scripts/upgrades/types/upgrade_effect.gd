@abstract
extends Node
class_name UpgradeEffect

enum Kind {ADD, MUL, POW}

@export var target_stat: StringName
@export var kind: Kind = Kind.MUL
@export var level_min : int = 1
@export var level_max: int = 999
@export var enabled: bool = true

var _source : String

func bind_and_apply(source_key:String, level:int) -> void:
	_source = source_key
	
var _last_level := 0

func _apply(level: int) -> void:
	_last_level = level 
	var stat := StatManager.get_stat(target_stat)
	if not enabled or stat == null or level < level_min or level > level_max:
		if stat: stat.set_modifier(_source, kind, compute(level))
		return
	stat.set_modifier(_source, kind, compute(level))

func _neutral() -> float:
	match kind:
		Kind.ADD: return 0.0
		Kind.MUL: return 1.0
		Kind.POW: return 1.0
	return 0.0

@abstract
func compute(level: int) -> float
