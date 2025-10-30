class_name Zona_Interagivel extends Node3D

@export var Parent_Interactable_Object: Node

signal Player_Looked_At_Me

signal Player_Left

func Player_Aimed_at_Me():
	
	Player_Looked_At_Me.emit()
	
	if Parent_Interactable_Object is Objeto_Interagivel:
			
			GlobalEvents.Player_Entered_Interactable_Range.emit(Parent_Interactable_Object)
		
	
	
	
func Set_Interactability():
	
	process_mode = Node.PROCESS_MODE_INHERIT
	
	
	
	
func Reset_Interactability():
	
	Player_Left.emit()
	
	if Parent_Interactable_Object is Objeto_Interagivel:
			
			GlobalEvents.Player_Left_Interactable_Range.emit()
			
			#Player_Reference.Current_Interactable_Object = null
			
			
	process_mode = Node.PROCESS_MODE_DISABLED
			
			
	
	
	
	
