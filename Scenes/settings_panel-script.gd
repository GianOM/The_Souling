extends Panel

@onready var performance_checkbox: CheckBox = $"VBoxContainer/HBoxContainer/Performance Checkbox"
@onready var quality_check_box: CheckBox = $"VBoxContainer/HBoxContainer/Quality CheckBox"

func _Show_My_Settings_Panel():
	show()
	
func _on_Close_Button_Clicked():
	hide()




func _on_Master_Volume_Changed(New_Volume_Value: float):
	#map a linear range [0, 100] to [-20 dB, +20 dB].
	AudioServer.set_bus_volume_db(0, New_Volume_Value*0.4 - 20)
	#print(AudioServer.get_bus_volume_db(0))




func _on_Graphics_PERFORMANCE_Settings_Clicked():
	
	quality_check_box.button_pressed = false
	
	ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_3d", 0)
	ProjectSettings.set_setting("rendering/lights_and_shadows/positional_shadow/atlas_size", 4096)
	
	#print(ProjectSettings.get_setting("rendering/anti_aliasing/quality/msaa_3d"))
	#print(ProjectSettings.get_setting("rendering/lights_and_shadows/positional_shadow/atlas_size"))
	
func _on_Graphics_QUALITY_Settings_Clicked():
	
	performance_checkbox.button_pressed = false
	
	ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_3d",2)
	ProjectSettings.set_setting("rendering/lights_and_shadows/positional_shadow/atlas_size", 16384)
	
	
	
	
	#print(ProjectSettings.get_setting("rendering/anti_aliasing/quality/msaa_3d"))
	#print(ProjectSettings.get_setting("rendering/lights_and_shadows/positional_shadow/atlas_size"))
	
