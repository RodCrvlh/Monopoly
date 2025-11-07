class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/VBoxContainer/Start_Button
@onready var options_button: Button = $MarginContainer/VBoxContainer/Options_Button
@onready var exit_button: Button = $MarginContainer/VBoxContainer/Exit_Button
@onready var options_menu: OptionsMenu = $Options_Menu as OptionsMenu
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer
@onready var title_label: Label = $Title_Label as Label

func _ready() -> void:
	options_menu.visible = false
	handle_connecting_signals()


func on_start_pressed() -> void:
	DadosJogo.n_jogadores = options_menu.n_jogadores
	DadosJogo.n_bots = options_menu.n_bots
	get_tree().change_scene_to_file("res://src/Jogo.tscn")


func on_options_pressed() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true 
	title_label.visible = false
	

func on_exit_pressed() -> void:
	get_tree().quit()

func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
	title_label.visible = true

func handle_connecting_signals() -> void: 
	start_button.button_down.connect(on_start_pressed)
	options_button.button_down.connect(on_options_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
