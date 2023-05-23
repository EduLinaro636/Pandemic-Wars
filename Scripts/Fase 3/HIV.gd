
extends Area2D


var x = -1
var atira = 0

var velocidade = 100 + 100*(main.dificuldade/3)
var rot = 0.5

#Posição x limite que os minions corona irão
var pos_x_hiv = rand_range(800,900)

var vida = 3

var intervalo_disparo = rand_range(3,4)/main.dificuldade

func dispara(delta):
	randomize()
	intervalo_disparo-=delta
	if intervalo_disparo<=0:
		#som do tiro
		get_node("Sample").play("tiro_hiv")
		
		
		var tiro = load("res://Scenes/Inimigos/HIV/TiroHIV.tscn")
		
		tiro = tiro.instance()
		
		var pos_tiro = get_node("PosTiro").get_global_pos()
		
		tiro.set_global_pos(pos_tiro)
		
		get_parent().add_child(tiro)
		
		intervalo_disparo = rand_range(3,4)/main.dificuldade
		
	

func _ready():
	add_to_group(main.INIMIGOS)
	randomize()
	set_process(true)
	
	
	
func movimenta(delta):	

	#rotaciona o vírus
	rotate(delta*rot)
		
	var pos_atual = get_global_pos()
	
	if pos_atual.x<=pos_x_hiv:
		atira = 1
					
	
	var altura = get_node("Sprite").get_item_rect().size.height/2
	
	var yvel = velocidade*delta
	
	if pos_atual.x <=-20:
		queue_free()
	
	set_global_pos(get_global_pos()+Vector2(x,0)*yvel)
	

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
		get_node("Sample").play("explosion_hiv")

	
	
	
	


