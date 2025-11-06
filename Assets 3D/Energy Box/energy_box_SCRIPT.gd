class_name Energy_Box extends Objeto_Interagivel

@onready var skeleton_3d: Skeleton3D = $"Energy Box/Armature_001/Skeleton3D"

var is_lid_open: bool = false

var is_Box_Working: bool = true

@onready var power_down_sound: AudioStreamPlayer3D = $"Power Down Sound"



#TODO: Sound ON and Textures

func _ready() -> void:
	
	Energia.Event_Blackout_Energy.connect(_on_Energy_Down)
	Energia.Restore_Energy.connect(_on_Energy_Restored)
	
func _on_Energy_Down():
	is_Box_Working = false
	power_down_sound.play()
	
func _on_Energy_Restored():
	is_Box_Working = true

func Interact():
	
	if not is_lid_open:
		
		is_lid_open = true
		
		var New_Rotation: Quaternion = Quaternion(0,0,0,0.707)
		
		skeleton_3d.set_bone_pose_rotation(1,New_Rotation)
		
		Interact_Text = "Turn ON/Off Switch"
		
		return
		
	if is_Box_Working:
		
		Energia.Event_Blackout_Energy.emit()
		
		
		
	else:
		
		Energia.Restore_Energy.emit()
		
		
