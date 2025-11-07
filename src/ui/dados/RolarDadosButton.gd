extends BoxContainer

@onready var button: Button = $Button

# 1. Defina o seu SINAL CUSTOMIZADO
# Este é o sinal que o GameManager vai ouvir.
signal botao_rolar_dados_pressionado

# _ready é chamado quando este nó entra na cena
func _ready():
	# 2. Conecte o sinal "pressed" (nativo do Botão)
	# a uma função DENTRO DESTE PRÓPRIO SCRIPT.
	button.connect("pressed", _on_self_pressed)
	# Alternativa mais curta: connect("pressed", _on_self_pressed)

# 3. Esta função é chamada quando o botão é pressionado
func _on_self_pressed():
	# 4. EMITA o seu sinal customizado!
	# O "Chefe" (GameManager) estará ouvindo por este sinal.
	emit_signal("botao_rolar_dados_pressionado")
	
	# (Opcional) Você pode desabilitar o botão aqui
	# para evitar cliques duplos.
	button.disabled = true
