extends Resource
class_name ClasesEnemigos

enum Clases {
	Acero,
	Arcano,
	Cambiante,
	Culto,
	Diablo,
	Fenix,
	Hada,
	Pegaso,
	Peste,
	Roble,
	Samurai,
	Zombi,
	Osvaldo,
	Mari
}

@export var databaseEnemigos: Dictionary[Clases, ClaseEnemigo]
