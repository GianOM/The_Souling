class_name Monstro extends Node3D

@export var Camera_3d_that_Sees_me: Camera3D

var is_Monster_Active: bool = false

#Começa desabilitado pois o Player esta no tutorial e o Tutorial nao pode matar
var Can_Monster_Kill_Player: bool = false

@onready var Debug_Mesh: MeshInstance3D = $Debug_Mesh

@onready var the_father: Node3D = $"The Father"

@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("B_KEY"):
			if is_Monster_Active:
				
				Debug_Mesh.scale = Vector3(1,1,1)
				the_father.show()
				
			else:
				
				Debug_Mesh.scale = Vector3(0.05,0.1,0.05)
				
				the_father.hide()
	
	
func _ready() -> void:
	
	GlobalEvents.Allow_Monsters_to_Kill_Player.connect(_set_monsters_to_Kill_Mode)
	
	
func Make_Visible():
	
	Debug_Mesh.scale = Vector3(1,1,1)
	
	the_father.show()
	
func _set_monsters_to_Kill_Mode():
	
	Can_Monster_Kill_Player = true
	
	
func _on_kill_area_body_entered(body: Node3D) -> void:
	
	
	if body is Jogador and is_Monster_Active and Can_Monster_Kill_Player:
	#if body is Jogador and is_Monster_Active:
		
		GlobalEvents.Player_is_Kill.emit()
		print("Player is Ded")
		
		
#func _change_Monster_Location(New_Global_Pos: Vector3):
	#global_position = New_Global_Pos
	
	
