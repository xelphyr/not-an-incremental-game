extends Area2D



func _process(_delta: float) -> void:
	var player_within = false
	for i in get_overlapping_bodies():
		if i.is_in_group(&"Player"):
			player_within = true
			
	if player_within:
		$ButtonPromptLabel.visible = true
		if Input.is_action_just_pressed("action"):
			print("Pressed!")
			for child in get_children():
				if child is Action:
					child.call("on_trigger")
	else:
		$ButtonPromptLabel.visible = false
