extends Area2D

signal action_pressed

func _process(_delta: float) -> void:
	var player_within = false
	for i in get_overlapping_bodies():
		if i.is_in_group(&"Player"):
			player_within = true
			
	if player_within:
		$ButtonPromptLabel.visible = true
		if Input.is_action_just_pressed("action"):
			print("Pressed!")
			action_pressed.emit()
	else:
		$ButtonPromptLabel.visible = false
