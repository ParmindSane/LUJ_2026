extends Resource
class_name ClasesEnemigos

enum Clases {
	Zombi,
	Cambiante,
	Peste,
	Samurai,
	Acero,
	Hada,
	Roble,
	Arcano,
	Culto,
	Fenix,
	Diablo,
	Pegaso,
	Osvaldo,
	Mari,
}

@export var databaseEnemigos: Dictionary[Clases, ClaseEnemigo]
