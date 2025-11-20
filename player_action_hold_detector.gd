extends Area2D

@export var hold_time : float = 5
@export var oneshot : bool = true
@onready var timer : Timer = $Timer

func _ready() -> void:
	$Timer.one_shot = oneshot

func _process(_delta: float) -> void:
	var player_within = false
	for i in get_overlapping_bodies():
		if i.is_in_group(&"Player"):
			player_within = true
			
	if player_within:
		$ButtonPromptLabel.visible = true
		_handle_input_hold()

	else:
		$ButtonPromptLabel.visible = false

func _handle_input_hold() -> void:
	if Input.is_action_just_pressed("action"):
		print("starthold")
		timer.start(hold_time) 
	if Input.is_action_just_released("action"):
		print("ended prematurely")
		timer.stop()

func _on_timer_timeout() -> void:
	print("ended!")
	for child in get_children():
		if child is Action:
			child.call("on_trigger")
