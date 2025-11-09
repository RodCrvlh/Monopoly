class_name OptionsMenu
extends Control

@onready var exit_button: Button = $MarginContainer/VBoxContainer/Exit_Button
@onready var label_jogadores: Label = $MarginContainer/VBoxContainer/BoxJogadores/LabelJogadores
@onready var mais_jogador: Button = $MarginContainer/VBoxContainer/BoxJogadores/maisJogador
@onready var menos_jogador: Button = $MarginContainer/VBoxContainer/BoxJogadores/menosJogador
@onready var label_bots: Label = $MarginContainer/VBoxContainer/BoxBots/LabelBots
@onready var mais_bot: Button = $MarginContainer/VBoxContainer/BoxBots/maisBot
@onready var menos_bot: Button = $MarginContainer/VBoxContainer/BoxBots/menosBot

var n_jogadores: int = 2
var n_bots: int = 0

signal exit_options_menu


func _ready() -> void:
	exit_button.button_down.connect(on_exit_pressed)
	set_process(false)
	
func on_exit_pressed() -> void:
	exit_options_menu.emit()
	set_process(false)

func _on_mais_jogador_pressed() -> void:
	if n_jogadores + n_bots < 8:
		n_jogadores += 1
		label_jogadores.text = "Numero de Jogadores: "+str(n_jogadores)
		

func _on_menos_jogador_pressed() -> void:
	if n_jogadores > 1:
		n_jogadores -= 1
		label_jogadores.text = "Numero de Jogadores: "+str(n_jogadores)


func _on_mais_bot_pressed() -> void:
	if n_jogadores + n_bots < 8:
		n_bots += 1
		label_bots.text = "Numero de Bots:"+str(n_bots)


func _on_menos_bot_pressed() -> void:
	if n_bots > 0:
		n_bots -= 1
		label_bots.text = "Numero de Bots:"+str(n_bots)
