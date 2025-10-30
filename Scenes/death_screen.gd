extends Control


@onready var main_menu: Control = $".."

const STARTER_AMBIENCE_SCENE = preload("uid://cd0evft6nks72")


func _ready() -> void:
	
	GlobalEvents.Show_Retry_Screen.connect(_SHOW_DEATH_SCREEN)
	
	GlobalEvents.Player_is_Kill.connect(_load_Correct_Stats)


func _load_Correct_Stats():
	
	$"Stats Container/SoulsCakes Delivered Line/Total_SoulCakes_Number".text = str(GlobalEvents.Number_of_Soul_Cakes)
	$"Stats Container/Time_of_Death/Death Clock".text = str(GlobalEvents.Hour_of_Death) + " : " + "%02d" % GlobalEvents.Minute_of_Death
	
func _SHOW_DEATH_SCREEN():
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Retry_Button_Clicked():
	
	print("Starting Retry Routine")
	
	GlobalEvents.Number_of_Soul_Cakes = 0
	
	var Temp_Node: Node3D = main_menu.get_node("Starter_Ambience")
	
	Temp_Node.queue_free()
	
	await Temp_Node.tree_exited
	
	var Temp_New_Starter_Ambience: Node3D = STARTER_AMBIENCE_SCENE.instantiate()
	
	main_menu.add_child(Temp_New_Starter_Ambience)
	
	
	
	Temp_New_Starter_Ambience.get_node("Main_Ambient_Song").Start_Game()
	GlobalEvents.Activate_Player.emit()
	
	
	GlobalEvents.Activate_Player.emit()
	
	
	hide()
	
	print("Finished Retry Routine")
	
func _on_Quit_Button_Clicked():
	
	get_tree().quit()
