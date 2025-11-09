extends Propriedade
class_name Terreno

enum Cor { 
	MARROM,
	AZULCLARO,
	ROSA,
	LARANJA,
	VERMELHO,
	AMARELO,
	VERDE,
	AZULESCURO
}

@export var cor: Cor
@export var nCasas: int
@export var hipotecada: bool
@export var aluguel0: int
@export var aluguel1: int
@export var aluguel2: int
@export var aluguel3: int
@export var aluguel4: int
@export var aluguelHotel: int
@export var valorCasa: int
@export var valorHotel: int
