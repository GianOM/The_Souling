extends Control

@onready var dialogue_text: RichTextLabel = $Dialogue_Background/Dialogue_Margin/Dialogue_Text
@onready var dialogue_background: ColorRect = $Dialogue_Background
@onready var options_screen: Control = $"Options Screen"

@onready var options_1_button: Button = $"Options Screen/Options 1 Button"
@onready var options_2_button: Button = $"Options Screen/Options 2 Button"

var Dialogue_Index: int = 0


@warning_ignore("unused_signal")
signal Dialogue_Advanced


signal Finished_Dialogue


#Quem carrega os Dialogos, é o Player especifico
var Dialogues: Array[Dictionary] = []


var Choices_Dialogue_Sequence: bool = false
var End_of_Dialogue_Sequence: bool = false





func _ready() -> void:
	
	GlobalEvents.Show_Dialogue_Event.connect(_Start_Dialogue_Scene)
	
	
	
func _Start_Dialogue_Scene():
	
	GlobalEvents.Deactivate_Player.emit()
	
	show()
	
	_show_next_dialog()
	
func _input(_event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("Next_Dialogue_Key") and is_visible_in_tree():
		
		_show_next_dialog()
		
func _show_next_dialog():
	
	if not Choices_Dialogue_Sequence:
		if not End_of_Dialogue_Sequence:
			
			if Dialogues[Dialogue_Index].has("My_Text"):
				
				dialogue_text.text = Dialogues[Dialogue_Index].My_Text
				
				if Dialogues[Dialogue_Index].has("has_options"):
					#Marcamos uma flag para Indicar que o proximo dialogo a ser mostrado e um dialogo de opcoes
					Choices_Dialogue_Sequence = true
					
					_load_options_from_Dialogue()
					
				else:
					#Para o caso do dialogo ter a flag "End_of_Dialog", nao avançamos o index
					if Dialogues[Dialogue_Index].has("End_of_Dialog"):
						
						End_of_Dialogue_Sequence = true
						
					
					else:
						
						Dialogue_Advanced.emit()
						
						Dialogue_Index += 1 
						
				
		else:
			##Quando Terminar o Dialogo
			hide()
			
			dialogue_background.hide()
			
			GlobalEvents.Activate_Player.emit()
			
			Finished_Dialogue.emit()
			
			
			
	else:
		
		options_screen.show()
		dialogue_background.hide()
		
		
func _load_options_from_Dialogue():
	
	options_1_button.text = Dialogues[Dialogue_Index].options_1
	options_1_button.pressed.connect(_on_Options_Button_Clicked.bind(Dialogues[Dialogue_Index].options_1_ID))
	
	
	
	options_2_button.text = Dialogues[Dialogue_Index].options_2
	options_2_button.pressed.connect(_on_Options_Button_Clicked.bind(Dialogues[Dialogue_Index].options_2_ID))
	
	
func _on_Options_Button_Clicked(Next_Dialogue_Index: int):
	
	Dialogue_Index = Next_Dialogue_Index
	
	options_screen.hide()
	dialogue_background.show()
	
	Choices_Dialogue_Sequence = false
	
	_show_next_dialog()
	
