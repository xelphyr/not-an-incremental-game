extends UpgradeEffect
class_name CurveUpgradeEffect

#0 represents the value at min_level, 1 represents the value at max_level
@export var upgrade_curve: Curve

func compute(level: int) -> float:
	if upgrade_curve == null: return _neutral()
	var coeff = (level - level_min)/(level_max*1.0)
	return upgrade_curve.sample_baked(coeff)
