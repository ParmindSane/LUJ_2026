extends Node

func map(n: float, a1: float, a2: float, b1: float, b2: float) -> float:
	return b1 + (n - a1) * (b2 - b1) / (a2 - a1)
	

func salir():
	get_tree().quit()
