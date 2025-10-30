extends Control

@onready var buttons_menu: VBoxContainer = $"Buttons Menu"

@onready var starter_ambience: Node3D = $Starter_Ambience


func _on_Start_Game_Clicked():
	#label_test.show()
	
	buttons_menu.hide()
	
	$How_to_Play_Button.hide()
	$"Settings Panel".hide()
	
	starter_ambience.main_ambient_song.Start_Game()
	GlobalEvents.Activate_Player.emit()
	
func _on_quit_Game_Clicked():
	get_tree().quit()
	pass
	
	
	
func _on_Quality_Mode_Selected():
	RenderingServer.viewport_set_msaa_3d(get_viewport(),RenderingServer.ViewportMSAA.VIEWPORT_MSAA_8X)
