class_name Soul_Cake extends Objeto_Interagivel

@onready var interactable_zone: Zona_Interagivel = $InteractableZone


func Interact():
	#Tiramos a interatividade para evitar que o player pegue o Soul Cake 2x
	interactable_zone.Reset_Interactability()
	
	GlobalEvents.PLUS_One_Soul_Cake_Added.emit()
	
	queue_free()
	
	
