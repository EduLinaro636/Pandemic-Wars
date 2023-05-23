
extends Node


var leva = 0

var chefe = 0

var intervalo = 0

#Variáveis responsáveis pelo intervalo de spawn
var tempo_spawn = rand_range(2,4)
var verifica_tempo = 0

func spawna():
	randomize()
	
	var num_spawn = int(rand_range(3,5))
	
	var posicoes = []
	
	for i in range(num_spawn):
		posicoes.append(Vector2(1200,rand_range(100,500)))
		
		
	var corona = load("res://Scenes/Inimigos/Corona/Corona.tscn")
	
	var instancias = []
	
	for j in range(num_spawn):
		var c = corona.instance()
		c.set_global_pos(posicoes[j])
		instancias.append(c)
		
	for k in range(num_spawn):
		get_parent().add_child(instancias[k])
		
	leva+=1
	

func _ready():
	set_process(true)
	

func control_spawn(delta):
	var num_ini = get_tree().get_nodes_in_group(main.INIMIGOS).size()
	if num_ini==0:
			get_parent().get_node("Camera").velocidade = 100
			verifica_tempo+=delta
			if verifica_tempo>=tempo_spawn:
				spawna()
				tempo_spawn = rand_range(5,10)
				verifica_tempo = 0
	
	
func _process(delta):
	
	if leva>=8:
		
		var num_inimigos = get_tree().get_nodes_in_group("inimigos").size()
		
		if num_inimigos==0:
			var chefe = load("res://Scenes/Inimigos/Corona/CoronaChefe.tscn")
		
			chefe = chefe.instance()
		
			chefe.add_to_group(main.CHEFE)
		
			get_parent().add_child(chefe)
			
			queue_free()
		
	else:
		control_spawn(delta)
		
