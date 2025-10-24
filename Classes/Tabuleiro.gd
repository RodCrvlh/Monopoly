extends Node
class_name Tabuleiro 

var terrenos: Array[Terreno] 
var servicos: Array[Servico]
var ferrovias: Array[Ferrovia]
var especiais: Array[Especial] 
@export var espacos: Array[Espaco]
@onready var tabuleiro: Sprite2D = $Tabuleiro7


func _init() -> void:
	terrenos.resize(22)
	ferrovias.resize(4)
	servicos.resize(2)
	especiais.resize(12)
	espacos.resize(40)
	
	terrenos[0] = Terreno.new("Avenida Sumaré", 1, 60, 300, 20, 100, 300, 900, 1600, 2500, 500, 2500)
	terrenos[1] = Terreno.new("Praça da Sé", 3, 60, 300, 40, 200, 600, 1800, 3200, 4500, 500, 2500)
	terrenos[2] = Terreno.new("Rua 25 de Março", 6, 100, 60, 500, 300, 900, 2700, 4000, 5500, 500, 2500)
	terrenos[3] = Terreno.new("Avenida São João", 8, 100, 60, 500, 300, 900, 2700, 4000, 5500, 500, 2500)
	terrenos[4] = Terreno.new("Avenida Paulista", 9, 120, 600, 80, 400, 1000, 3000, 4500, 6000, 500, 2500)
	terrenos[5] = Terreno.new("Avenida Viera Souto", 11, 140, 700, 100, 500, 1500, 4500, 6250, 7500, 1000, 5000)
	terrenos[6] = Terreno.new("Niterói", 13, 140, 700, 100, 500, 1500, 4500, 6250, 7500, 1000, 5000)
	terrenos[7] = Terreno.new("Avenida Atlantica", 14, 160, 800, 120, 600, 1800, 5000, 7000, 9000, 1000, 5000)
	terrenos[8] = Terreno.new("Avenida Presidente Juscelino Kubitsheck", 16, 180, 900, 140, 700, 2000, 5500, 7500, 9500, 1000, 5000)
	terrenos[9] = Terreno.new("Avenida Engenheiro Luis Carlos", 18, 180, 900, 140, 700, 2000, 5500, 7500, 9500, 1000, 5000)
	terrenos[10] = Terreno.new("Avenida Brigadeiro Faria Lima", 19, 200, 1000, 160, 800, 2200, 6000, 8000, 10000, 1000, 50000)
	terrenos[11] = Terreno.new("Ipanema", 21, 220, 1100, 180, 900, 2500, 7000, 8750, 10500,1500, 7500)
	terrenos[12] = Terreno.new("Leblon", 23, 220, 1100, 180, 900, 2500, 7000, 8750, 10500,1500, 7500)
	terrenos[13] = Terreno.new("Copacabana", 24, 240, 1200, 200, 1000, 3000, 7500, 9250, 11000, 1500, 7500)
	terrenos[14] = Terreno.new("Avenida Cidade Jardim", 26, 260, 1500, 240, 1200, 3600, 8500, 10250, 12000, 1500, 7500)
	terrenos[15] = Terreno.new("Pacaembu", 27, 260, 1500, 240, 1200, 3600, 8500, 10250, 12000, 1500, 7500)
	terrenos[16] = Terreno.new("Jerusalem", 29, 280, 1300,240,1200, 3600, 8500, 10250, 12000, 1500, 7500)
	terrenos[17] = Terreno.new("Barra da Tijuca", 31, 300, 1500, 260, 1300, 3900, 9000,11000,12750, 2000, 10000)
	terrenos[18] = Terreno.new("Jardim Botânico", 31, 300, 1500, 260, 1300, 3900, 9000,11000,12750, 2000, 10000)
	terrenos[19] = Terreno.new("", 34, 320, 1500, 280, 1500, 4500, 100000, 12000, 14000, 2000, 10000)
	terrenos[20] = Terreno.new("Avenida Morumbi", 37, 350, 1750, 350, 1750, 5000, 11000, 13000, 15000, 2000, 10000 )
	terrenos[21] = Terreno.new("Rua Oscar Freire", 39, 400, 2000, 500, 2000, 6000, 14000, 17000, 20000, 2000, 10000)
	ferrovias[0] = Ferrovia.new("Estação de Metro Maracanã", 5, 200, 1000, 250, 500, 1000, 2000)
	ferrovias[1] = Ferrovia.new("EstacaoMetroCarioca",15, 200, 1000, 250, 500, 1000, 2000)
	ferrovias[2] = Ferrovia.new("Estacao de Metro Copacaba", 25, 200, 1000,  250, 500, 1000, 2000)
	ferrovias[3] = Ferrovia.new("Estacao de Metro Republica",35, 200, 1000,  250, 500, 1000, 2000)
	servicos[0] = Servico.new("Companhia Elétrica", 12, 150, 750)
	servicos[1] = Servico.new("Companhia de agua", 28, 150, 750)
	especiais[0] = Especial.new("Ponto de Partida", 0)
	especiais[1] = Especial.new("Cofre", 2)
	especiais[2] = Especial.new("Imposto de Renda", 4)
	especiais[3] = Especial.new("Sorte", 7)
	especiais[4] = Especial.new("Cadeia", 10)
	especiais[5] = Especial.new("Cadeia", 17)
	especiais[6] = Especial.new("VaParaCadeia", 30)
	especiais[7] = Especial.new("Sorte", 22)
	especiais[8] = Especial.new("VaParaCadeia", 30)
	especiais[9] = Especial.new("Cadeia", 33)
	especiais[10] = Especial.new("Sorte", 36)
	especiais[11] = Especial.new("TaxaDeRiqueza", 38)
	
func encontrarPrecoCompra(posicao: int, tipo: Tipo.Espaco) -> int:

	if tipo == Tipo.Espaco.TERRENO:
		for terreno in terrenos:
			if terreno.posicao == posicao:
				return terreno.precoCompra
				
	elif tipo == Tipo.Espaco.FERROVIA:
		for ferrovia in ferrovias:
			print(ferrovia.posicao)
			if ferrovia.posicao == posicao:
				return ferrovia.precoCompra
				
	if tipo == Tipo.Espaco.SERVICO:
		for servico in servicos:
			if servico.posicao == posicao:
				return servico.precoCompra
	return 0
