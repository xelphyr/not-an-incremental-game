extends UpgradeEffect
class_name ExprUpgradeEffect

#0 represents the value at min_level, 1 represents the value at max_level
@export var expr : String = "L"
var _e := Expression.new()
var _ok := false

func _ready() -> void:
	_compile()

func _compile():
	var vars := ["L"]
	_ok = _e.parse(expr, vars) == OK 
	if not _ok:
		push_error("Expr parse failed: %s" % expr)

func compute(level: int) -> float:
	if not _ok : _compile()
	if not _ok: return _neutral()
	var args: Array = [level]
	var r = _e.execute(args, null, false)
	return float(r)
