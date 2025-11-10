extends Propriedade
class_name  OrgaoBolsa

var aluguel_atual: int = 0
@export var aluguel1: int
@export var aluguel2: int
@export var aluguel3: int
@export var aluguel4: int

func aprimorar(cont: int, b:int=0):
	print("Voce aprimorou essa orgaobolsa!")
	if cont == 1:
		aluguel_atual = aluguel1
		
	if cont == 2:
		aluguel_atual = aluguel2
	
	if cont == 3:
		aluguel_atual = aluguel3
	
	if cont == 4:
		aluguel_atual = aluguel4


func resetar():
	aluguel_atual = 0
	comprada = false
	proprietario = ""
