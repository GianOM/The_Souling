extends Node3D

@onready var teleport_area_1: Area3D = $Teleport_Area_1

@onready var teleport_area_2: Area3D = $Teleport_Area_2



func _on_teleport_area_1_body_entered(body: Node3D) -> void:
	
	if body is Jogador:
		
		var Local_Offset: Vector3 = teleport_area_2.global_position - teleport_area_1.global_position
		
		var Local_Rotation_Degrees: Vector3 = teleport_area_1.rotation_degrees - teleport_area_2.rotation_degrees
		
		body.global_position += Local_Offset
		body.rotation_degrees -= Local_Rotation_Degrees
		#body.handle_Camera_Movement()
		
		#body.mouse_axis = Vector2.ZERO
		
func _on_teleport_area_2_body_entered(body: Node3D) -> void:
	if body is Jogador:
		#body.global_position.y += 50
		print("Player Arrived")
