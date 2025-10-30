extends Node


var List_of_Possible_Interactable_Spooks: Array[Objeto_Interagivel]

@onready var List_of_Doors: Node3D = $"../Doors"
@onready var List_of_Lights_and_Switches: Node3D = $"../Lights and Switches"

@onready var tv_scene: Televisao = $"../TV Scene"

@onready var monster_event_timer: Timer = $Monster_Event_Timer

@onready var monster_interaction_mesh_debug: MeshInstance3D = $"Monster Interaction Mesh Debug"
@onready var monster_sound_mesh_debug: MeshInstance3D = $"Monster Sound Mesh Debug"

@onready var spooky_sound: AudioStreamPlayer3D = $Spooky_Sound

@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("B_KEY"):
		
		if monster_interaction_mesh_debug.is_visible_in_tree():
			monster_interaction_mesh_debug.hide()
			monster_sound_mesh_debug.hide()
		else:
			monster_interaction_mesh_debug.show()
			monster_sound_mesh_debug.show()
		




func _ready() -> void:
	
	#Inserimos aqui todos os objectos que o Monstro pode interagir
	for i in List_of_Doors.get_child_count():
		if List_of_Doors.get_child(i) is Objeto_Interagivel:
			List_of_Possible_Interactable_Spooks.append(List_of_Doors.get_child(i))
			
	for i in List_of_Lights_and_Switches.get_child_count():
		if List_of_Lights_and_Switches.get_child(i) is Objeto_Interagivel:
			List_of_Possible_Interactable_Spooks.append(List_of_Lights_and_Switches.get_child(i))
			
			
	List_of_Possible_Interactable_Spooks.append(tv_scene)
	
	List_of_Possible_Interactable_Spooks.shuffle()
	
	
	monster_event_timer.start()
			
			
			
	
func _on_Monster_Event_Timer_Timeout():
	
	print("Monster interacted")
	
	List_of_Possible_Interactable_Spooks[0].Interact()
	
	monster_interaction_mesh_debug.global_position = List_of_Possible_Interactable_Spooks[0].global_position + Vector3(0,1.56,0)
	
	spooky_sound.global_position = List_of_Possible_Interactable_Spooks[-1].global_position
	
	spooky_sound.play()
	
	monster_sound_mesh_debug.global_position = List_of_Possible_Interactable_Spooks[-1].global_position
	
	List_of_Possible_Interactable_Spooks.shuffle()
	
