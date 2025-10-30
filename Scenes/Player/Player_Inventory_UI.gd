extends Control

@onready var inventory_image: TextureRect = $Inventory_Image
@onready var inventory_text: Label = $"Inventory_Image/Inventory Text"


const ICON_SOULS_CAKE = preload("uid://d3gl7hq5bxbra")

var Visibility_Tween: Tween

#var Total_Number_of_Soul_Cakes: int = 0

func _ready() -> void:
	GlobalEvents.PLUS_One_Soul_Cake_Added.connect(_on_Soul_Cake_Added)
	GlobalEvents.MINUS_One_Soul_Cake_Added.connect(_on_Soul_Cake_Subtracted)
	#Visibility_Tween = get_tree().create_tween()


func _on_Soul_Cake_Added():
	inventory_image.texture = ICON_SOULS_CAKE
	inventory_text.text = "+1 Soul Cake"
	
	Visibility_Tween = get_tree().create_tween()
	
	Visibility_Tween.tween_property(inventory_image, "modulate",Color(1.0, 1.0, 1.0, 1.0),0.5)
	Visibility_Tween.tween_property(inventory_image, "modulate",Color(1.0, 1.0, 1.0, 0.0),3)
	
	#Total_Number_of_Soul_Cakes += 1
	#cookie_score.text = "Number of Cookies Made: " + str(Total_Number_of_Soul_Cakes)
	
func _on_Soul_Cake_Subtracted():
	
	inventory_image.texture = ICON_SOULS_CAKE
	inventory_text.text = "-1 Soul Cake"
	
	Visibility_Tween = get_tree().create_tween()
	
	Visibility_Tween.tween_property(inventory_image, "modulate",Color(1.0, 1.0, 1.0, 1.0),0.5)
	Visibility_Tween.tween_property(inventory_image, "modulate",Color(1.0, 1.0, 1.0, 0.0),3)
	
	
