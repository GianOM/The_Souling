class_name Inpectable_Object extends Objeto_Interagivel

@onready var Inspect_Object_Root: Inpectable_Object = $"."



@onready var Object_to_Inspect_Root: Node3D = $Inspect_Object

@onready var inspectable_object_camera: Camera3D = $Inspectable_Object_Camera

var is_Player_Inspecting: bool = false


func _input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("Escape Key") and is_Player_Inspecting:
		is_Player_Inspecting = false
		GlobalEvents.Activate_Player.emit()
		
		Object_to_Inspect_Root.rotation_degrees = Vector3.ZERO
		
		
	if event is InputEventMouse and is_Player_Inspecting:
		if event.get_button_mask() == 1:
			
			var space = get_tree().root.get_node("MainMenu/Starter_Ambience").get_world_3d().direct_space_state
			
			var Start_Point: Vector3 = get_viewport().get_camera_3d().project_ray_origin(event.global_position)
			var End_Point: Vector3 = get_viewport().get_camera_3d().project_position(event.global_position, 8)
			
			var Ray_Query_Params: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
			
			Ray_Query_Params.from = Start_Point
			Ray_Query_Params.to = End_Point
			
			
			Ray_Query_Params.collide_with_areas = true
			Ray_Query_Params.collide_with_bodies = false
			
			Ray_Query_Params.set_collision_mask(512)

			
			var Result = space.intersect_ray(Ray_Query_Params)
			
			if Result.size() > 0:
				
				#var Temp = Result.collider.get_parent().get_parent()
				#print("ACHEI")
				#print(Result.collider)
				
				#var OB = Result.collider.get_tree()
				
				#if Result.collider == target_click:
					#print("ACHEI")
					
				is_Player_Inspecting = false
				GlobalEvents.Activate_Player.emit()
	
				Object_to_Inspect_Root.rotation_degrees = Vector3.ZERO
		
		
func Interact():
	
	#GlobalEvents.PLUS_One_Soul_Cake_Added.emit()
	#GlobalEvents.MINUS_One_Soul_Cake_Added.emit()
	GlobalEvents.Deactivate_Player.emit()
	_Start_Inpection_Routine()
	
	
	
	
func _process(delta: float) -> void:
	
	if is_Player_Inspecting:
		
		if Input.is_action_pressed("Forward_Key"):

			var rot: Basis = Basis(-Inspect_Object_Root.transform.basis.x, 1.5*delta)
			
			Object_to_Inspect_Root.global_transform.basis = rot * Object_to_Inspect_Root.global_transform.basis
			
		elif Input.is_action_pressed("Back_Key"):
			var rot: Basis = Basis(-Inspect_Object_Root.transform.basis.x, -1.5*delta)
			
			Object_to_Inspect_Root.global_transform.basis = rot * Object_to_Inspect_Root.global_transform.basis
			
		if Input.is_action_pressed("Left_Key"):
			
			#Create an orientation around the global Y axis, and sets the speed of movement to -1.5*delta
			var rot: Basis = Basis(Vector3(0,1,0), -1.5*delta)
			Object_to_Inspect_Root.global_transform.basis = rot * Object_to_Inspect_Root.global_transform.basis
			
		elif Input.is_action_pressed("Right_Key"):
			
			
			var rot: Basis = Basis(Vector3(0,1,0), 1.5*delta)
			Object_to_Inspect_Root.global_transform.basis = rot * Object_to_Inspect_Root.global_transform.basis
			
func _Start_Inpection_Routine():
	is_Player_Inspecting = true
	inspectable_object_camera.make_current()
	
