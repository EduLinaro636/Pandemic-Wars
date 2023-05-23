
extends Area2D


var atira = 0

var velocidade = 100*main.dificuldade


#Posição x limite que os minions corona irão
var pos_x_colera = rand_range(800,900)

var vida = 3

var intervalo_disparo = rand_range(5,5.5)/main.dificuldade

#variáveis do tiro
var pos_tiro = Vector2(-1,0)
var pos_jogador


func dispara(delta):
	if get_tree().get_nodes_in_group(main.INIMIGOS).size()<20:
	
	
		randomize()
		intervalo_disparo-=delta
		if intervalo_disparo<=0:
			#som do tiro
			get_node("Sample").play("tiro_colera")
			
			var tiro = load("res://Scenes/Inimigos/Cólera/Cólera.tscn")
			
			tiro = tiro.instance()
			
			var pos_tiro = get_node("PosTiro").get_global_pos()
			
			tiro.set_global_pos(pos_tiro)
			
			get_parent().add_child(tiro)
			
			intervalo_disparo = rand_range(5,5.5)/main.dificuldade
	
func _ready():
	add_to_group(main.INIMIGOS)
	randomize()
	set_process(true)
	
	if  get_tree().get_nodes_in_group("jogador").size()>0:
			pos_jogador = get_parent().get_node("Nave").get_global_pos()
			
			look_at(pos_jogador)
			
			
			if abs(pos_jogador.x - get_global_pos().x)>400:
				pos_tiro.x = (pos_jogador.x - get_global_pos().x)/1000
				pos_tiro.y = (pos_jogador.y - get_global_pos().y)/1000
			else:
				pos_tiro.x = (pos_jogador.x - get_global_pos().x)/600
				pos_tiro.y = (pos_jogador.y - get_global_pos().y)/600
		
	
	
	
func movimenta(delta):	
		
	var pos_atual = get_global_pos()
	
	if pos_atual.x<=pos_x_colera:
		atira = 1
					
	
	var altura = get_node("Sprite").get_item_rect().size.height/2
	
	var yvel = velocidade*delta
	
	if pos_atual.x <=-20 or pos_atual.y<=-20 or pos_atual.y>=620 or (pos_atual.x>=1040 and atira==1):
		queue_free()
	
	set_global_pos(get_global_pos()+pos_tiro*yvel)
	

func _process(delta):
	movimenta(delta)
	
	if atira:
		dispara(delta)

func aplica_dano(dano):
	vida-=dano
	
	get_node("AnimationPlayer").play("hit")
	
	if vida<=0:
		#Remove essa espanhola do grupo, portanto o tiro não vai passar
		#dentro do bloco relacionado ao grupo Inimigos		
		remove_from_group(main.INIMIGOS)
		set_process(false)
		get_node("AnimationPlayer").play("morte")
		#Shake na câmera ao atingir inimigo
		get_parent().get_node("Camera").shake()
		
		#Som de explosão
		get_node("Sample").play("explosion_colera")

	

	
