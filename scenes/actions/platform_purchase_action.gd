extends PurchaseAction
class_name PlatformPurchaseAction

@export var platform_id : int

func purchase() -> void:
	if attempt_buy():
		SignalBus.platform_unlocked.emit(platform_id)
		print("Purchase successful!")
