class_name Recipe_Item extends Objeto_Interagivel

enum Item_ID {Flour, Milk, Salt, Sugar, Butter, Raisings}


@onready var pick_up_item: AudioStreamPlayer3D = $Pick_Up_Item


@onready var interactable_zone: Zona_Interagivel = $InteractableZone


@export var My_Item_ID: Item_ID :set = _on_ID_Set


var is_Item_Active: bool = false

@onready var milk: Node3D = $Milk2

@onready var flour: Node3D = $Flour

@onready var salt: Node3D = $Salt2

@onready var sugar: Node3D = $Sugar2

@onready var butter: Node3D = $Butter2

@onready var raisins: Node3D = $Raisins




@onready var cheat: MeshInstance3D = $Cheat


var Can_I_Run_Interact: bool = true

@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("B_KEY"):
		
		if is_Item_Active and cheat.is_visible_in_tree():
			cheat.hide()
		elif is_Item_Active:
			cheat.show()


func _on_ID_Set(value: Item_ID):
	
	
	show()
	
	interactable_zone.Set_Interactability()
	is_Item_Active = true
	
	My_Item_ID = value
	
	flour.hide()
	milk.hide()
	salt.hide()
	sugar.hide()
	butter.hide()
	raisins.hide()
	
	
	match value:
		#TODO: Trocar a malha e o Interact Text baseado neste numero
		## Flour
		0:
			flour.show()
			Interact_Text = "Pick Flour"
			
		## Milk
		1:
			milk.show()
			Interact_Text = "Pick Milk"
			
		## Salt
		2:
			salt.show()
			Interact_Text = "Pick Salt"
			
		## Sugar
		3:
			sugar.show()
			Interact_Text = "Pick Sugar"
			
		## Butter
		4:
			butter.show()
			Interact_Text = "Pick Butter"
			
		## Raisings
		5:
			raisins.show()
			Interact_Text = "Pick Raisins"
			
		
func Deactivate_Recipe_Item():
	
	is_Item_Active = false
	
	interactable_zone.Reset_Interactability()
	
	flour.hide()
	milk.hide()
	salt.hide()
	sugar.hide()
	butter.hide()
	raisins.hide()
	

func Interact():
	if Can_I_Run_Interact:
		Can_I_Run_Interact = false
		if is_Item_Active:
			
			hide()
			
			GlobalEvents.Add_Recipe_Item_to_Player.emit(My_Item_ID)
			
			is_Item_Active = false
			
			interactable_zone.Reset_Interactability()
			
			pick_up_item.play()
			
		Can_I_Run_Interact = true
	
