extends Area2D



var velocidade = 100 + 100*(main.dificuldade/3)

var x = -1
var y = 0


var intervalo_spawn = 0
var intervalo_disparo = 0
var tempo_max = rand_range(4,4.5)/main.dificuldade

var vida = 60*main.dificuldade



func _ready(): 


	set_pos(Vector2(1300,350))
	
	set_process(true)
	
	get_parent().get_node("Camera").velocidade = 100
	

func movimentacao(delta):
	var movi = Vector2(x,y)*velocidade*delta
	
	var pos_x = get_pos().x
	
	if(movi.x+pos_x<900 and y==0):
		y = 1
		x = 0
		velocidade = 30 + 30*(main.dificuldade/3)
		get_parent().get_node("Camera").velocidade = 0
		
	if((get_pos().y + movi.y <= 200) or (get_pos().y+movi.y>=400)):
		y = -y
		movi = Vector2(x,y)*velocidade*delta

		
	set_pos(get_pos()+movi)
	
	
func dispara_corona(delta):
	var num_ini = get_tree().get_nodes_in_group(main.INIMIGOS).size()	
	intervalo_disparo+=delta
	
	if intervalo_disparo>=tempo_max and num_ini<4:
		var pos = get_node("PosTiro").get_global_pos()
		
		var corona = load("res://Scenes/Inimigos/Tuberculose/Tuberculose.tscn")
		
		corona = corona.instance()
		
		corona.pos_x_tuberculose = rand_range(700,800)
		
		corona.set_global_pos(pos)
		
		corona.add_to_group(main.INIMIGOS)
		
		get_parent().add_child(corona)
		
		intervalo_disparo = 0
		tempo_max = rand_range(4,4.5)/main.dificuldade
											
func _process(delta):
	if intervalo_spawn>=2:
		movimentacao(delta)
		
		#Começa a disparar 
		
		if x==0:
			dispara_corona(delta)
				
	else:
		intervalo_spawn+=delta
		
		
		
func leva_dano(dano):
	vida-=dano
	var anima = get_node("AnimationPlayer")
	
	if vida==0:
		var inimigos = get_tree().get_nodes_in_group(main.INIMIGOS)
		
		for i in inimigos:
			i.aplica_dano(3)
		
		set_process(0)
		
		remove_from_group(main.CHEFE)
		
		anima.play("morte")
		
		get_parent().passa_de_fase()
	else:
		anima.play("hit")
		
func som_morte():
	get_node("Sons").play("TuberculoseChefeMorte")
	
	
	
	