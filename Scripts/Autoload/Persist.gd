extends Node

var bHasDoneTutorial = false

var HiScore = 2500
var bHasNewHighScore = false

func AttemptNewHighScore(score):
	if score > HiScore:
		HiScore = score
		bHasNewHighScore = true
	
