class_name Televisao extends Objeto_Interagivel


@onready var static_sound: AudioStreamPlayer3D = $Static_Sound

@onready var turn_on_sound: AudioStreamPlayer3D = $"Turn On Sound"
@onready var turn_off_sound: AudioStreamPlayer3D = $"Turn OFF Sound"

@onready var tv_screen: MeshInstance3D = $"TV2/TV Screen"

@onready var video_stream_player: VideoStreamPlayer = $SubViewport/VideoStreamPlayer

@onready var flicker_light: OmniLight3D = $TV2/Flicker_Light

var RNG: RandomNumberGenerator = RandomNumberGenerator.new()

var Tick_TV: float = 0.05

@onready var monster_camera_pov: Camera3D = $SubViewport/Monster_Camera_POV

@onready var timer: Timer = $"../Monster_Switch_Timer"

var is_Screen_Obfuscated: bool = true


const Initial_Time : float = 1080

var Total_Play_Time: float = 0

@onready var hour_time: Label3D = $Hour_Time


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
	
	
func Set_New_Monster_Position(My_Monster:Monstro):
	
	
	
	monster_camera_pov.global_position = My_Monster.Camera_3d_that_Sees_me.global_position
	
	#monster_camera_pov.position.z += 3
	
	monster_camera_pov.global_rotation = My_Monster.Camera_3d_that_Sees_me.rotation
	
	
	monster_camera_pov.fov = My_Monster.Camera_3d_that_Sees_me.fov
	
func Interact():
	
	if static_sound.stream_paused:
	
		static_sound.stream_paused = false
		
		turn_on_sound.play()
		
		video_stream_player.paused = false
		
		tv_screen.get_surface_override_material(0).set("emission", Color(1.0, 1.0, 1.0, 1.0))
		
	else:
	
		static_sound.stream_paused = true
		turn_off_sound.play()
		
		video_stream_player.paused = true
		
		tv_screen.get_surface_override_material(0).set("emission", Color(0.0, 0.0, 0.0, 1.0))
		
		flicker_light.omni_range = 0
	
