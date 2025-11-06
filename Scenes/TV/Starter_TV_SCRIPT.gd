class_name Televisao extends Objeto_Interagivel


@onready var static_sound: AudioStreamPlayer3D = $Static_Sound

@onready var turn_on_sound: AudioStreamPlayer3D = $"Turn On Sound"
@onready var turn_off_sound: AudioStreamPlayer3D = $"Turn OFF Sound"

var is_House_Energy_Working: bool = true

@onready var tv_screen: MeshInstance3D = $"TV2/TV Screen"

@onready var video_stream_player: VideoStreamPlayer = $SubViewport/VideoStreamPlayer

var RNG: RandomNumberGenerator = RandomNumberGenerator.new()

var Tick_TV: float = 0.05

@onready var monster_camera_pov: Camera3D = $SubViewport/Monster_Camera_POV

@onready var timer: Timer = $"../Monster_Switch_Timer"

var is_Screen_Obfuscated: bool = true

const Initial_Time : float = 1080

var Total_Play_Time: float = 0

@onready var hour_time: Label3D = $Hour_Time

func _ready() -> void:
	
	Energia.Event_Blackout_Energy.connect(_on_Power_Outage)
	Energia.Restore_Energy.connect(_on_Energy_Restored)
	
	Energia.Total_Number_of_Lights += 1
	Energia.Number_of_Lights_ON += 1
	
func _on_Power_Outage():
	
	Turn_Off_TV()
	
	is_House_Energy_Working = false
	
func _on_Energy_Restored():
	
	#Turn_On_TV()
	
	is_House_Energy_Working = true
	
	
	
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	
	Total_Play_Time += delta
	
	##6 horas ficticias equivalem a 1 Hora na vida real
	##Logo, 5 segundo na vida Real, equivale 5 minuto no jogo
	##Por isso, dividimos o 'Total_Play_Time' por 5
	@warning_ignore("narrowing_conversion")
	var Current_Time_Hours: int = (Initial_Time + int(Total_Play_Time / 5)) / 60
	
	GlobalEvents.Hour_of_Death = Current_Time_Hours
	
	
	@warning_ignore("narrowing_conversion")
	var Current_Time_Seconds: int = (Initial_Time + int(Total_Play_Time / 5)) - Current_Time_Hours * 60 
	
	GlobalEvents.Minute_of_Death = Current_Time_Seconds
	
	
	##Used for Debugging
	#var Current_Time_Hours: int = (Initial_Time + int(Total_Play_Time * 10)) / 60
	#var Current_Time_Seconds: int = (Initial_Time + int(Total_Play_Time * 10)) - Current_Time_Hours * 60 
	
	hour_time.text = str(Current_Time_Hours) + " : " + "%02d" % Current_Time_Seconds
	
	#Assim que bater 23:59 matamos o Player
	if Current_Time_Hours == 24:
		GlobalEvents.Player_is_Kill.emit()
	
	
	if timer.time_left <= 7 and not is_Screen_Obfuscated:
		print(timer.time_left)
		_Start_Screen_Obfuscation()
	


func _Start_Screen_Obfuscation():
	
	is_Screen_Obfuscated = true
	
	#print("ESTOU OBFUSCANDO")
	
	var Temp_Tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	
	Temp_Tween.tween_property(video_stream_player,"modulate", Color(1.0, 1.0, 1.0, 1.0), 6.2)
	
	Temp_Tween.tween_interval(1)
	
	Temp_Tween.tween_property(video_stream_player,"modulate", Color(1.0, 1.0, 1.0, 0.02), 3.1)
	
	Temp_Tween.tween_callback(_deobfuscate_Screen)
	
func _deobfuscate_Screen():
	
	is_Screen_Obfuscated = false
	
	
func _reveal_Screen():
	
	var Temp_Tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	Temp_Tween.tween_property(video_stream_player,"modulate", Color(1.0, 1.0, 1.0, 0.02), 3.1)
	is_Screen_Obfuscated = false
	
	
func Set_New_Monster_Position(My_Monster:Monstro):
	
	monster_camera_pov.global_position = My_Monster.Camera_3d_that_Sees_me.global_position
	
	
	monster_camera_pov.global_rotation = My_Monster.Camera_3d_that_Sees_me.rotation
	
	
	monster_camera_pov.fov = My_Monster.Camera_3d_that_Sees_me.fov
	
func Interact():
	
	if is_House_Energy_Working:
	
		if static_sound.stream_paused:
			
			Turn_On_TV()
			
		else:
			
			Turn_Off_TV()
			
	else:
		
		turn_off_sound.play()
		
		
	
func Turn_On_TV():
	
	
	turn_on_sound.play()
	
	
	static_sound.stream_paused = false
	
	video_stream_player.paused = false
	
	tv_screen.get_surface_override_material(0).set("emission", Color(1.0, 1.0, 1.0, 1.0))
	tv_screen.get_surface_override_material(0).set("albedo_color", Color(1.0, 1.0, 1.0, 1.0))
	
	Energia.Number_of_Lights_ON += 1
	
	Energia.Light_Was_Interacted.emit()
	
func Turn_Off_TV():
	
	static_sound.stream_paused = true
	
	turn_off_sound.play()
	
	video_stream_player.paused = true
	
	tv_screen.get_surface_override_material(0).set("emission", Color(0.0, 0.0, 0.0, 1.0))
	tv_screen.get_surface_override_material(0).set("albedo_color", Color(0.0, 0.0, 0.0, 1.0))
	
	Energia.Number_of_Lights_ON -= 1
	
	Energia.Light_Was_Interacted.emit()
	
