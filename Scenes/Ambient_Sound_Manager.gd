extends AudioStreamPlayer

const INTRO_ROTTEN_CROPS = preload("uid://dv0nl3eq43u4o")
const CALM_AMBIENT_SOUND = preload("uid://bkf4v876lrgu")




func Start_Game():
	stream = CALM_AMBIENT_SOUND
	play(0.0)
