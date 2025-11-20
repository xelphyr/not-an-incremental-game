

class_name Stat
extends Resource

signal mult_modified()
signal val_modified(val: float)



#Each stat has 2 main fields: mult and value
#mult is the multiplier for the stat's own value gain
#value is the value of the stat and also the boost it provides to different stats.
#if you want only a percentage boost then boost through a diff stat
#eg: Fire -> FireAirBoost (base_value = 0.2) -> Air

@export var base_value : float = 1.0
@export var dependency_stats : Array[StringName]
var _mods : Array[StatModifier]
var _dyn_mods : Array[Stat]
var _dirty : bool = true
var _cached_mult : float = 0.0
var value : float

func _init() -> void:
	value = base_value
	call_deferred("_setup")
		
		
func _setup() -> void:
	for statname in dependency_stats:
		var stat = StatManager.get_stat(statname)
		_dyn_mods.append(stat)
		stat.val_modified.connect(_dyn_mod_modified)

func set_modifier(source: String, kind: int, val: float) -> void:
	var idx := _mods.find_custom(func(m): return m.source == source)
	if idx == -1:
		var new_mod = StatModifier.new()
		new_mod.source = source 
		new_mod.kind = kind 
		new_mod.value = val
		_mods.append(new_mod)
	else:
		_mods[idx].value = value 
	_dirty = true
	mult_modified.emit()

func remove_modifier(src: String) -> void:
	_mods = _mods.filter(func(mm): return mm.source != src)
	_dirty = true
	mult_modified.emit()
	
func _dyn_mod_modified(val : float) -> void:
	_dirty = true

func get_final_mult() -> float:
	if _dirty:
		_cached_mult = _recompute_mult()
		_dirty = false
	return _cached_mult

func get_final() -> float:
	return value

func add_amount(amount: float) -> void:
	value += amount*get_final_mult()
	val_modified.emit(value)

func attempt_purchase(amount: float) -> bool:
	if value < amount:
		return false
	value -= amount
	val_modified.emit(value)
	return true
	
func _recompute_mult() -> float:
	var add := 0.0
	var mul := 1.0
	var power := 1.0
	for m in _mods:
		match m.kind:
			StatModifier.Kind.ADD: add += m.value
			StatModifier.Kind.MUL: mul *= m.value
			StatModifier.Kind.POW: power *= m.value
	for dm in _dyn_mods:
		mul *= dm.get_final()
	return pow((base_value + add) * mul, power)


	
