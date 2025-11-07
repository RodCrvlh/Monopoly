extends Node

@onready var dado_sprite: Sprite2D = $Dado
@onready var animation_player: AnimationPlayer = $Dado/AnimationPlayer
@onready var timer: Timer = $Dado/Timer
var resultado: int

func _ready():
	timer.connect("timer_timeout", on_timer_timeout)

func animacao_rolar(res):
	animation_player.play("rolar")
	resultado = res 
	timer.start()
	await(timer.timeout)
	animation_player.play(str(resultado))

func on_timer_timeout():
	animation_player.play(str(resultado))
