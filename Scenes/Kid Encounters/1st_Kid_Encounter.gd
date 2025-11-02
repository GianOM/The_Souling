class_name Encontro_Crianca_1 extends Objeto_Interagivel

@onready var dialogue_main: Control = $DialogueMain

@onready var animation_player: AnimationPlayer = $"Baby Hands/AnimationPlayer"

@onready var visible_on_screen_notifier_3d: VisibleOnScreenNotifier3D = $VisibleOnScreenNotifier3D

@onready var baby_hands: Node3D = $"Baby Hands"

var Has_Recieved_Cookie: bool = false

@onready var Zone: Zona_Interagivel = $Area3D



var Kid_1_Dialogues: Array[Dictionary] = [
	
	{"Speaker" : "Kid", "My_Text": "Soul, souls, for a soul-cake"},
	
	{"Speaker" : "Kid", "My_Text": "Pray you good sir, a soul-cake!"},
	
	{"Speaker" : "Player", "My_Text": "Can you tell me what is going on? Where am..."},
	
	{"Speaker" : "Kid", "My_Text": "The departed demand offerings, so that their spirits may be appeased..."},
	
	{"Speaker" : "Player", "My_Text": "What?"},
	
	{"Speaker" : "Kid", "My_Text": "And your soul may be spared"},
	
	{"Speaker" : "Player", "My_Text": "What offerings?"},
	
	{"Speaker" : "Kid", "My_Text": "For each soul, a soul-cake"},
	
	{"Speaker" : "Player", "My_Text": "Soul-cake?"},
	
	{"Speaker" : "Kid", "My_Text": "Kitchen...", "End_of_Dialog": true},
	
	#IDX = 4
	{"Speaker" : "Player", "My_Text": "[i]You reach your Pocket[/i]"},
	
	#[i] deixa em italico
	{"Speaker" : "Player", "My_Text": "[i]You gave the kid a candy[/i]"},
	
	{"Speaker" : "Kid", "My_Text": "Thanks, here, someone asked me to give you this", "End_of_Dialog": true},
	
	
	
	
	{"Speaker" : "Player", "My_Text": "Hein?", "has_options": true, "options_1": "Nao, Caio, nao vou baixar o Marvel Rivalas", "options_1_ID":2,
																					"options_2": "Ta bom Caio, Irei Baixar o Marvel Rivals", "options_2_ID":3},
	{"Speaker" : "Caio_Ultra_Happy", "My_Text": "Affs", "End_of_Dialog": true},
	{"Speaker" : "Caio_Sad", "My_Text": "LET'S GOOOOO", "End_of_Dialog": true},
	
]

#end of dialogue
#
#with soul-cake in hand:
#MC: "Here is your soul-cake, am I spared now?"
#???: "Soon, more will come"
#???: "Be sure to make offerings, and appease their souls"



func _ready() -> void:
	
	EncounterManager.First_Kid_Encounter.connect(Activate_Encounter)
	
	GlobalEvents.PLUS_One_Soul_Cake_Added.connect(Player_Made_Soul_Cake)
	
	dialogue_main.Finished_Dialogue.connect(queue_free)
	
	#dialogue_main.Dialogue_Advanced.connect()
	
func Activate_Encounter():
	
	show()
	process_mode = Node.PROCESS_MODE_INHERIT
	
	dialogue_main.Dialogues = Kid_1_Dialogues
	
#So ativamos a zona de interacao quando o Player faz um Soul Cake
func Interact():
	#BUG: Interagir mto rapido break it
	
	if not Has_Recieved_Cookie:
		Has_Recieved_Cookie = true
		
		Zone.process_mode = Node.PROCESS_MODE_DISABLED
		
		GlobalEvents.Reset_Itens_Positions.emit()
		
		GlobalEvents.MINUS_One_Soul_Cake_Added.emit()
		
		GlobalEvents.Allow_Monsters_to_Kill_Player.emit()
		GlobalEvents.Unlock_All_Doors.emit()
	
func _on_Dialogue_Advanced():
	
	if dialogue_main.Dialogue_Index == 4:
		GlobalEvents.MINUS_One_Soul_Cake_Added.emit()
		
		
func Player_Made_Soul_Cake():
	
	baby_hands.show()
	
	Zone.process_mode = Node.PROCESS_MODE_INHERIT
	
		
		
func _Hands_Visible():
	#print("AAAAAAAAAAAAAAAA")
	pass
	
	
func _Hands_Invisible():
	
	if Has_Recieved_Cookie:
		
		Has_Recieved_Cookie = false
		
		baby_hands.hide()
	
		
	
	
	
