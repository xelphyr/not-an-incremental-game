class_name StatModifier
extends Resource

enum Kind { ADD, MUL, POW }

@export var kind: Kind
@export var value: float
@export var source: String 
