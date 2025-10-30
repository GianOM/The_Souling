class_name Forno extends Objeto_Interagivel


@onready var stove_ready_sound: AudioStreamPlayer3D = $"Stove Ready Sound"



@onready var flour: Node3D = $Itens/Flour
@onready var milk: Node3D = $Itens/Milk2
@onready var salt: Node3D = $Itens/Salt2
@onready var sugar: Node3D = $Itens/Sugar2
@onready var butter: Node3D = $Itens/Butter2
@onready var raisins: Node3D = $Itens/Raisins



var Stove_has_Flour: bool = false
var Stove_has_Milk: bool = false
var Stove_has_Salt: bool = false
var Stove_has_Sugar: bool = false
var Stove_has_Butter: bool = false
var Stove_has_Raisins: bool = false


const SOUL_CAKE = preload("uid://ix4kjhbknyq")
@onready var soul_cake_pos: Marker3D = $Soul_Cake_Pos

@onready var area_3d: Zona_Interagivel = $Area3D

var can_I_Run_Interact: bool = true


func Interact():
	if can_I_Run_Interact:
		
		can_I_Run_Interact = false
		
		if Interact_Text == "Make Soul Cake":
			stove_ready_sound.play()
			
			
			var New_Soul_Cake: Soul_Cake = SOUL_CAKE.instantiate()
			soul_cake_pos.add_child(New_Soul_Cake)
			
			GlobalEvents.Number_of_Soul_Cakes += 1
			
			flour.hide()
			Stove_has_Flour = false
			
			milk.hide()
			Stove_has_Milk = false
			
			salt.hide()
			Stove_has_Salt = false
			
			sugar.hide()
			Stove_has_Sugar = false
			
			butter.hide()
			Stove_has_Butter = false
			
			raisins.hide()
			Stove_has_Raisins = false
			
			Interact_Text = "Drop Item"
			
			#Assim que o cookie aparece, escondemos a zona de interacao do
			#fogao para evitar fonclitos
			area_3d.Reset_Interactability()
			
			can_I_Run_Interact = true
			return
			
		
		
		if Player_Reference:
				
			match Player_Reference.List_of_Itens_Held_by_Player.pop_back():
				## Flour
				0:
					flour.show()
					Stove_has_Flour = true
					
				## Milk
				1:
					milk.show()
					Stove_has_Milk = true
					
				## Salt
				2:
					salt.show()
					Stove_has_Salt = true
					
				## Sugar
				3:
					sugar.show()
					Stove_has_Sugar = true
					
				## Butter
				4:
					butter.show()
					Stove_has_Butter = true
					
				## Raisings
				5:
					raisins.show()
					Stove_has_Raisins = true
					pass
					
				null:
					print("CABECUDO")
					pass
				
		
		
		if Stove_has_Flour and Stove_has_Milk and Stove_has_Salt and Stove_has_Sugar and Stove_has_Butter and Stove_has_Raisins:
			Interact_Text = "Make Soul Cake"
			
			
		can_I_Run_Interact = true
		
		
func _on_cookie_picked_Up(_node: Node):
	#Assim que pegarmos o cookie e ele for deletado, ativamos 
	#a zona de interacao do fogao outra vez
	area_3d.Set_Interactability()
	
	GlobalEvents.Play_Door_Bell_Sound.emit()
	
