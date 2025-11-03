extends Node

@onready var home: Node3D = $".."

var List_of_Possible_Interactable_Spooks: Array[Objeto_Interagivel]

@onready var List_of_Doors: Node3D = $"../Doors"
@onready var List_of_Lights_and_Switches: Node3D = $"../Lights and Switches"

@onready var tv_scene: Televisao = $"../TV Scene"

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
	
func Monster_Interact_Events(Origin_of_Interaction: Vector3):
	
	var Temp_Distance: float
	
	for i in range(List_of_Possible_Interactable_Spooks.size()):
		
		Temp_Distance = List_of_Possible_Interactable_Spooks[i].global_position.distance_to(Origin_of_Interaction)
		
		if Temp_Distance <= 8.0:
			print("Distancia do bagulho %f" % Temp_Distance)
			List_of_Possible_Interactable_Spooks[i].Interact()
			monster_interaction_mesh_debug.global_position = List_of_Possible_Interactable_Spooks[i].global_position + Vector3(0,1.56,0)
			List_of_Possible_Interactable_Spooks.shuffle()
			
			return
	
func Monster_Sound_Events(Origin_of_Sound:Vector3):
	
	spooky_sound.global_position = Origin_of_Sound
	monster_sound_mesh_debug.global_position = Origin_of_Sound
	spooky_sound.play()
	
	
	
	
	
