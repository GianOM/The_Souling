extends Node3D

@onready var door_bell_sound: AudioStreamPlayer3D = $"DoorBell Sound"


func _ready() -> void:
	GlobalEvents.Play_Door_Bell_Sound.connect(_play_DoorBell)
	
	
func _play_DoorBell():
	door_bell_sound.play()
