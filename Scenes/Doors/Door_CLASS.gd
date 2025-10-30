class_name Porta extends Objeto_Interagivel



var Can_I_Interact: bool = true

@export var is_Door_Locked: bool = false

var is_door_Open: bool = false

@export var is_Door_Reversed: bool

@onready var interactable_zone: Zona_Interagivel = $"1 Door Basic/Armature/Skeleton3D/BoneAttachment3D/InteractableZone"

@onready var animation_player: AnimationPlayer = $"1 Door Basic/AnimationPlayer"

@onready var opening_door_sound: AudioStreamPlayer3D = $Opening_Door_Sound
@onready var locked_door_sound: AudioStreamPlayer3D = $Locked_Door_Sound
@onready var fechar_porta_sound: AudioStreamPlayer3D = $Fechar_Porta_Sound

func _ready() -> void:
	animation_player.animation_finished.connect(_allow_player_to_interact)


func Interact():
	
	if Can_I_Interact:
		
		Can_I_Interact = false
		
		if is_door_Open:
			_sequence_on_Opened_Door()
			
			is_door_Open = false
			
			
		else:
			if is_Door_Locked:
				
				_sequence_on_Locked_Door()
				
			else:
				
				_sequence_on_Unlocked_Door()
				
				is_door_Open = true
		
		
func _sequence_on_Locked_Door():
	
	animation_player.play("Door_Handle_Locked")
	
	locked_door_sound.play()
	
	#print("ESTOU TRANCADA, IMBECIL")
	
	
	
func _sequence_on_Unlocked_Door():
	
	
	if is_Door_Reversed:
	
		animation_player.play("Opening_the_Door_Opposite_Side")
		
	else:
		animation_player.play("Opening_the_Door")
	
	opening_door_sound.play()
	
	
	#Evita o Spam apagando a Interactable Box
	#interactable_zone.Reset_Interactability()
	
	#print("I was Open")
	
	
func _sequence_on_Opened_Door():
	
	if is_Door_Reversed:
	
		animation_player.play("Door_Unlock_Opposite_Side")
		
	else:
		animation_player.play("Door_Unlock")
		
		
	fechar_porta_sound.play()
	
	
func _allow_player_to_interact(_anim_name: StringName):
	Can_I_Interact = true
	
	
	
	
