extends Node3D

@export_category("Monster Settings")
var IDX_Active_Monster: int = 0
var Possible_Active_Monster: Array[Monstro]
@onready var monster_switch_timer: Timer = $Monster_Switch_Timer

@onready var monsters: Node3D = $Monsters

@onready var tv_scene: Televisao = $"TV Scene"

@export_category("Itens Settings")
var IDX_Possible_Item: int = 0
var Possible_Itens : Array[Recipe_Item]

@onready var pick_up_itens: Node3D = $"Pick Up Itens"

@onready var monster_controller: Node = $Monster_Controller



func _ready() -> void:
	
	for i in range(monsters.get_child_count()):
		Possible_Active_Monster.append(monsters.get_child(i))
		
	Possible_Active_Monster.shuffle()
	
	for i in range(pick_up_itens.get_child_count()):
		Possible_Itens.append(pick_up_itens.get_child(i))
	
	_set_up_Itens()
	
	GlobalEvents.Reset_Itens_Positions.connect(_set_up_Itens)
	
	GlobalEvents.Allow_Monsters_to_Kill_Player.connect(Start_Monster_Hunter)
	
	
	
func Start_Monster_Hunter():
	
	monster_switch_timer.start()
	
	
	#Fazemos isso para que a TV possa entrar no modo de revelar o monstro
	tv_scene.is_Screen_Obfuscated = false
	
	print("Monster Timer Started")
	
	
func _Switch_Active_Monster():
	
	##Troca o Tempo que demora pro monstro teleportar
	monster_switch_timer.wait_time = 40.0
	
	monster_switch_timer.start()
	
	if Possible_Active_Monster[IDX_Active_Monster].is_Monster_Active:
		
		Possible_Active_Monster[IDX_Active_Monster].is_Monster_Active = false
		Possible_Active_Monster[IDX_Active_Monster].Debug_Mesh.scale = Vector3.ZERO
	
	if (IDX_Active_Monster + 1) < Possible_Active_Monster.size():
		
		IDX_Active_Monster += 1
		
	else:
		
		IDX_Active_Monster = 0
		
		
	Possible_Active_Monster[IDX_Active_Monster].is_Monster_Active = true
	
	Possible_Active_Monster[IDX_Active_Monster].Make_Visible()
	
	tv_scene.Set_New_Monster_Position(Possible_Active_Monster[IDX_Active_Monster])
	
	monster_controller.Monster_Interact_Events(Possible_Active_Monster[IDX_Active_Monster].global_position)
	monster_controller.Monster_Sound_Events(Possible_Active_Monster[IDX_Active_Monster].global_position)
	
func _set_up_Itens():
	
	for i in range(Possible_Itens.size()):
		Possible_Itens[i].Deactivate_Recipe_Item()
	
	##Como a receita tem 6 itens, iteramos pelos 6 primeiros do Array
	for i in range(6):
		
		@warning_ignore("int_as_enum_without_cast")
		Possible_Itens[IDX_Possible_Item].My_Item_ID = i
		
		if (IDX_Possible_Item + 1) < Possible_Itens.size():
			IDX_Possible_Item += 1
		else:
			IDX_Possible_Item = 0
			
			
			
			
	Possible_Itens.shuffle()
		
		
