extends UpgradeEffect
class_name LinUpgradeEffect

#0 represents the value at min_level, 1 represents the value at max_level
@export var base_value: float = 0.0
@export var per_level: float = 0.0

func compute(level: int) -> float:
	return (base_value + per_level*level)
