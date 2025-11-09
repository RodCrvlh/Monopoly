extends Propriedade
class_name Disciplina

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
@export var n_casas: int
@export var hipotecada: bool
@export var aluguel_atual:int = aluguel 
@export var aluguel: int
@export var aluguel1: int
@export var aluguel2: int
@export var aluguel3: int
@export var aluguel4: int
@export var aluguel_hotel: int
@export var valor_casa: int
@export var valor_hotel: int
var monopolio: bool = false

func construir_casa():
	if n_casas == 0:
		aluguel_atual = aluguel1
		n_casas += 1
		
	elif n_casas == 1:
		aluguel_atual = aluguel2
		n_casas += 1

	elif n_casas == 2:
		aluguel_atual = aluguel3
		n_casas += 1
		
	elif n_casas == 3:
		aluguel_atual = aluguel4
		n_casas += 1
		
	elif n_casas == 4:
		construir_hotel()
		n_casas += 1


func construir_hotel():
		aluguel_atual = aluguel_hotel


func aprimorar(a:int=0, b:int=0):
	print("Voce aprimorou essa disciplina!")
	monopolio = true
	aluguel_atual *= 2
