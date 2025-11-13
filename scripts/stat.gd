class_name Stat
extends Resource

signal modified

@export var base_value = 1.0
var _mods : Array[StatModifier]
var _dirty := true
var _cached : = 0.0

func set_modifier(source: String, kind: int, value: float) -> void:
	var idx := _mods.find_custom(func(m): return m.source == source)
	if idx == -1:
		var new_mod = StatModifier.new()
		new_mod.source = source 
		new_mod.kind = kind 
		new_mod.value = value
		_mods.append(new_mod)
	else:
		_mods[idx].value = value 
	_dirty = true
	modified.emit()

func remove_modifier(src: String) -> void:
	_mods = _mods.filter(func(mm): return mm.source != src)
	_dirty = true
	emit_signal("changed")

func get_final() -> float:
	if _dirty:
		_cached = _recompute()
		_dirty = false
	return _cached
	
func _recompute() -> float:
	var add := 0.0
	var mul := 1.0
	var power := 1.0
	for m in _mods:
		match m.kind:
			StatModifier.Kind.ADD: add += m.value
			StatModifier.Kind.MUL: mul *= m.value
			StatModifier.Kind.POW: power *= m.value
	return pow((base_value + add) * mul, power)
