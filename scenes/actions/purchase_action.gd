@abstract
extends Action
class_name PurchaseAction

@export var cost : Dictionary[StringName, float]

func on_trigger() -> void:
	purchase()

@abstract
func purchase() -> void

func attempt_buy() -> bool:
	var purchase_possible := true
	for stat in cost:
		purchase_possible = (purchase_possible and (StatManager.get_value(stat)>cost[stat]))
	if purchase_possible:
		for stat in cost:
			StatManager.get_stat(stat).attempt_purchase(cost[stat])
	return purchase_possible
