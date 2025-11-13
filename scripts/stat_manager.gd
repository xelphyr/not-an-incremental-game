extends Node

var _stats = {
	&"souls": preload("res://resources/souls.tres")
}

func get_stat(stat: StringName) -> Stat: 
	var out = _stats.get(stat)
	if out == null:
		print("Error: stat %s does not exist" % stat)
	return out

func get_value(stat : StringName) -> float: return _stats[stat].get_final()
