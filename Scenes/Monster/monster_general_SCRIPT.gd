class_name Monstro extends Node3D

@export var My_Camera_Global_Rotation: Vector3

var is_Monster_Active: bool = false

@onready var Debug_Mesh: MeshInstance3D = $Debug_Mesh

@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("B_KEY"):
		
		if Debug_Mesh.is_visible_in_tree():
			Debug_Mesh.hide()
		else:
			Debug_Mesh.show()



@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if is_Monster_Active:
		Debug_Mesh.get_surface_override_material(0).albedo_color = Color.RED
		
		Debug_Mesh.scale.y = 1
		
		#Debug_Mesh.get_surface_override_material(0).stencil_color= Color.RED
	else:
		Debug_Mesh.get_surface_override_material(0).albedo_color = Color.BLUE
		
		Debug_Mesh.scale.y = 0.2
		#Debug_Mesh.get_surface_override_material(0).stencil_color = Color.BLUE
#func _ready() -> void:
	#GlobalEvents.Move_Monster_to_Location.connect(_change_Monster_Location)

func _on_kill_area_body_entered(body: Node3D) -> void:
	
	
	if body is Jogador and is_Monster_Active:
		
		GlobalEvents.Player_is_Kill.emit()
		print("Player is Ded")
		
		
#func _change_Monster_Location(New_Global_Pos: Vector3):
	#global_position = New_Global_Pos
	
	
