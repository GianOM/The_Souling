extends VBoxContainer


@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Escape Key"):
		if is_visible_in_tree():
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			hide()
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			show()
			
			
			
func _on_Continue_Button_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hide()
	
func _on_Quit_Button_Pressed():
	get_tree().quit()
