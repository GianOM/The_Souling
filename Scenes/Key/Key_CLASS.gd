class_name Chave extends Objeto_Interagivel


@onready var interactable_zone: Zona_Interagivel = $InteractableZone

@export var Doors_to_Open: Array[Porta]

@onready var pick_up_key_sound: AudioStreamPlayer3D = $"Pick Up Key Sound"

@onready var basic_key: Node3D = $"Basic Key"

var can_I_Run_Interact: bool = true


##Assim que um Player entrar na minha zona interagivel, vou desbloquear todas as Portas do Meu Array
func Interact():
	
	if can_I_Run_Interact:
		
		#Avoid spamming
		can_I_Run_Interact = false
		
		
		
		basic_key.hide()
		
		
		
		EncounterManager.Start_First_Encounter()
		
		for Porta_N in Doors_to_Open:
		
			Porta_N.is_Door_Locked = false
			
		pick_up_key_sound.play()
		pick_up_key_sound.finished.connect(queue_free)
			
