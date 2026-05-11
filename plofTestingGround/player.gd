extends CharacterBody2D

@warning_ignore("unused_signal")
signal shooting
@onready var cross_hair = $"../CrossHair"
@onready var level = $".."
@export var shooting_rate : float = 0.1
