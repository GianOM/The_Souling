class_name Jogador extends CharacterBody3D


@onready var camera_3d: Camera3D = $Camera3D

@onready var player_ui: Control = $"Player UI"
@onready var interactable_keyboard_hint: TextureRect = $"Player UI/Interactable_Keyboard_Hint"
@onready var interact_text: Label = $"Player UI/Interactable_Keyboard_Hint/Interact Text"
var Current_Interactable_Object: Objeto_Interagivel
var is_Interaction_available: bool = false

const PLAYER_SPEED: float = 3
const PLAYER_CAMERA_SPEED: float = 0.001

@onready var player_footsteps: AudioStreamPlayer3D = $"Player Footsteps"
@export var Player_Foot_Steps_Tick: float
var Player_Distance: float = 120


var rot : Vector3
var mouse_axis: Vector2 = Vector2.ZERO


var is_Player_Active: bool = false

@onready var interactable_ray_cast: RayCast3D = $"Camera3D/Interactable RayCast"

var List_of_Itens_Held_by_Player: Array[Recipe_Item.Item_ID]


@onready var video_stream_player: VideoStreamPlayer = $Jumpscare/VideoStreamPlayer

@onready var fps_text: Label = $"Player UI/FPS Text"

func _input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("Interact_Key") and is_Interaction_available and Current_Interactable_Object:
		
		Current_Interactable_Object.Player_Reference = self
		
		Current_Interactable_Object.Interact()
		
	
	if event is InputEventMouseMotion and is_Player_Active:
		# event.relative is the delta since the last mouse motion event
		mouse_axis = event.relative * PLAYER_CAMERA_SPEED
		
		
		handle_Camera_Movement()
		
		
	if Input.is_action_just_pressed("B_KEY"):
		print_rich("[color=green]Position: %s[/color]" % str(camera_3d.global_position - Vector3(0,1.56,0)))
		print_rich("[color=red]Position: %s[/color]" % str(camera_3d.global_rotation))
	

func _ready() -> void:
	
	GlobalEvents.Player_Entered_Interactable_Range.connect(_Show_Interaction_Button)
	GlobalEvents.Player_Left_Interactable_Range.connect(_Hide_Interation_Button)
	
	GlobalEvents.Add_Recipe_Item_to_Player.connect(_add_item_to_Player)
	
	
	GlobalEvents.Activate_Player.connect(Activate_Player)
	GlobalEvents.Deactivate_Player.connect(Deactivate_Player)
	
	GlobalEvents.Player_is_Kill.connect(Kill_the_Player)
	
	
	
func Activate_Player():
	
	camera_3d.make_current()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	is_Player_Active = true
	
	player_ui.show()
	
	
func Deactivate_Player():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	is_Player_Active = false
	
	player_ui.hide()
	
	
func Kill_the_Player():
	
	video_stream_player.play()
	
	
	if not video_stream_player.finished.is_connected(Finished_Kill_Cam):
		video_stream_player.finished.connect(Finished_Kill_Cam)
	
	Deactivate_Player()
	
	
	
func Finished_Kill_Cam():
	GlobalEvents.Show_Retry_Screen.emit()
	
	
	
	
func _process(delta: float) -> void:
	#print(camera_3d.global_position)
	handle_Player_Movement(delta)
	
	
	fps_text.text = str(int(Engine.get_frames_per_second()))
	
	if interactable_ray_cast.is_colliding():
		
		var Collider_Result = interactable_ray_cast.get_collider()
		
		if Collider_Result is Zona_Interagivel:
			Collider_Result.Player_Aimed_at_Me()
			
	else:
		
		_Hide_Interation_Button()
		
		
	if Player_Distance <= 0:
		
		player_footsteps.play()
		
		Player_Distance = Player_Foot_Steps_Tick / delta
		
		
	
	
	
	
func handle_Player_Movement(Delta_Time: float):
	
	if is_Player_Active:
		var Input_Direction = Input.get_vector("Left_Key","Right_Key","Forward_Key","Back_Key")
		
		var movement_direction = (transform.basis * Vector3(Input_Direction.x ,0,Input_Direction.y) ).normalized()
		
		if not is_on_floor():
			velocity.y -= 9.8 * Delta_Time
			#print("Im not on floor")
		
		velocity.x = movement_direction.x * PLAYER_SPEED
		velocity.z = movement_direction.z * PLAYER_SPEED
		
		move_and_slide()
		
		
		Player_Distance -= movement_direction.length()
		
	
	
func handle_Camera_Movement():
	
	camera_3d.rotation.x -= mouse_axis.y
	camera_3d.rotation.x = clamp(camera_3d.rotation.x, -1.4, 1.5)
	
	rotation.y -= mouse_axis.x
	
func _Show_Interaction_Button(My_Object: Objeto_Interagivel):
	
	is_Interaction_available = true
	interactable_keyboard_hint.show()
	
	Current_Interactable_Object = My_Object
	
	interact_text.text = My_Object.Interact_Text
	
	
func _Hide_Interation_Button():
	
	is_Interaction_available = false
	interactable_keyboard_hint.hide()
	
	Current_Interactable_Object = null
	
	
func _add_item_to_Player(Item_Added: Recipe_Item.Item_ID):
	
	List_of_Itens_Held_by_Player.append(Item_Added)
	
	match Item_Added:
	#TODO: Trocar a malha e o Interact Text baseado neste numero
	
		## Flour
		0:
			
			print("Flour added to Player")
			
		## Milk
		1:
			
			print("Milk added to Player")
			
		## Salt
		2:
			
			print("Salt added to Player")
			
		## Sugar
		3:
			
			print("Sugar added to Player")
			
		## Butter
		4:
			
			print("Butter added to Player")
			
		## Raisings
		5:
			
			print("Raisings added to Player")
	
	
	
	
