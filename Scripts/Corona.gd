
extends Area2D


var x = -1
var y = 0

var velocidade = 100 + 100*(main.dificuldade/3)

#Posição x limite que os minions corona irão
var pos_x_corona = rand_range(700,900)

var vida = 2

var intervalo_disparo = rand_range(3,5)/main.dificuldade

func dispara(delta):
	randomize()
	intervalo_disparo-=delta
	if intervalo_disparo<=0:
		#som do tiro
		get_node("Sample").play("tiro_corona")
		
		var tiro = load("res://Scenes/Inimigos/Corona/TiroCorona.tscn")
		
		tiro = tiro.instance()
		
		var pos_tiro = get_node("PosTiro").get_global_pos()
		
		tiro.set_global_pos(pos_tiro)
		
		get_parent().add_child(tiro)
		
		intervalo_disparo = rand_range(3,5)/main.dificuldade
		
	

func _ready():
	add_to_group(main.INIMIGOS)
	randomize()
	
	
	set_process(true)
	
func movimenta(delta):	
		
	var pos_atual = get_global_pos()
	
	if pos_atual.x<=pos_x_corona and y==0:
		x = 0
		y = -1
		
		#A camera para
		get_parent().get_node("Camera").velocidade = 0
		
			
	
	var altura = get_node("Sprite").get_item_rect().size.height/2
	
	var yvel = velocidade*delta
	
	if pos_atual.y + y*yvel<=altura+5 or pos_atual.y +altura+yvel*y>=605:
		y = -y
	
	set_global_pos(get_global_pos()+Vector2(x,y)*yvel)
	

func _process(delta):
	movimenta(delta)
	
	if x==0:
		dispara(delta)

func aplica_dano(dano):
	vida-=dano
	
	get_node("AnimationPlayer").play("hit")
	
	if vida<=0:
		#Remove esse corona do grupo, portanto o tiro não vai passar
		#dentro do bloco relacionado ao grupo Inimigos		
		remove_from_group(main.INIMIGOS)
		set_process(false)
		get_node("AnimationPlayer").play("morte")
		#Shake na câmera ao atingir inimigo
		get_parent().get_node("Camera").shake()
		
		#Som de explosão
		get_node("Sample").play("explosion_corona")

	
	
	
	


