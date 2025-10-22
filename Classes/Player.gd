class_name Player
extends Node2D

var nome: String = "Rodrigo"
var dinheiro: int = 1000
var movimento: int = 0
var posicao: int = 0
@onready var peca: Sprite2D = $Peca
@onready var dinheiroLabel: Label = $Dinheiro 
@onready var nomeLabel: Label = $Nome

func _ready() -> void:
	dinheiroLabel.text =  str(dinheiro)
	nomeLabel.text = nome


func comprar(precoCompra: int) -> bool:
	if dinheiro == precoCompra:
		
		return true
		
	else:
		return false 

func get_posicao() -> int:
	return posicao 

func set_posicao(p: int) -> void:
	posicao = p
