class_name Player
extends Node2D

var nome: String 
var dinheiro: int = 1000
var movimento: int = 0
var posicao: int
var x: int
var y: int
@onready var dinheiroLabel: Label 
@onready var nomeLabel: Label 
@onready var peca: Sprite2D 


func _init(n: String, p: Sprite2D, xs: int, ys: int, offset_x:int, offset_y:int) -> void:
	nome = n
	peca = p
	posicao = 0
	x = xs
	y = ys
	nomeLabel = Label.new()
	dinheiroLabel = Label.new()
	nomeLabel.theme = load("res://art/DefaultTheme.tres")
	dinheiroLabel.theme = load("res://art/DefaultTheme.tres")
	nomeLabel.position = Vector2(x,y+offset_y)
	dinheiroLabel.position = Vector2(x+offset_x, y+offset_y)


func _ready() -> void:
	peca.z_index = 10
	nomeLabel.z_index = 11
	dinheiroLabel.z_index = 12
	add_child(peca)
	add_child(nomeLabel)
	add_child(dinheiroLabel)
	nomeLabel.text = nome
	dinheiroLabel.text = str(dinheiro)

	
func comprar(precoCompra: int) -> bool:
	if dinheiro == precoCompra:
		
		return true
		
	else:
		return false 

func get_posicao() -> int:
	return posicao 

func set_posicao(p: int) -> void:
	posicao = p
