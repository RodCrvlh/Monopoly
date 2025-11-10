extends Propriedade
class_name Freelance

@export var aluguel_atual: int = 0

func calcular_aluguel(resultado_dados: int, cont: int):
	if cont == 1:
		aluguel_atual =  4 * resultado_dados * 10000
	
	if cont == 2:
		aluguel_atual =  10 * resultado_dados*10000

func aprimorar(resultado_dados: int, cont: int):
	print("Voce aprimorou esse freelance!")
	calcular_aluguel(resultado_dados, cont)  


func resetar():
	aluguel_atual = 0
	comprada = false
	proprietario = ""
