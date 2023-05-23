
extends Node


#Variáveis para o prosseguimento da nave (após o fim do boss)
var x = 0
var y = 0
var tempo = 5

#variável da dificuldade
var dificuldade = 2


const INIMIGOS = "inimigos"
const CHEFE = "chefe"
const NIVEIS = ["Covid-19","Gripe Espanhola","AIDS",
"Cólera","Tuberculose","Peste Negra"]

var fase = 1

var fase_em_andamento = 0

func passa_de_fase():
	#interrompe a o process_input da nave
	get_node("Nave").set_process_input(false)
	
	#Gira a nave o sentido inicial
	if get_node("Nave").invertida:
		get_node("Nave").inverte_nave()
	
	#para com a música atual e toca a música de missão bem-sucedida
	var musica = get_node("Musicas/Fase %d/chefe"%main.fase)
	
	musica.stop()
	
	musica = get_node("Musicas/Passar/fase")
	
	musica.play()
		
	#Nave é interrompida
	get_node("Nave").tempo_libera_especial = rand_range(20,30)/main.dificuldade
	get_node("Nave").set_process(false)
	
	get_node("lbl_passa_de_fase").text = "Missão %d concluída"%(main.fase)
	
	if main.fase<7:
		main.fase+=1
		main.fase_em_andamento = 0
				
		main.x = get_node("Nave").get_global_pos().x
		main.y = get_node("Nave").get_global_pos().y
		
		set_process(true)
		
		#verifica a distância entre o fim da tela e a pos da nave
		
		get_node("passa_de_fase").set_wait_time(10) 
		
		get_node("Animacoes").play("passa_de_fase")
		get_node("passa_de_fase").start()
		
	else:
		get_node("passa_de_fase").set_wait_time(10) 
		
		get_node("Animacoes").play("passa_de_fase")
		get_node("passa_de_fase").start()
			

	
func new_game():	
	var isentos = ["Nave","ParallaxBackground","Camera","Menu",
	"pauser","passa_de_fase","lbl_passa_de_fase","Animacoes","portal"]
	
	#reestabecimento de fase e textura
	main.fase = 1
	main.fase_em_andamento = 0
	
	var text = load("res://Sprites/Fundos/fundo_corona.png")
	get_node("ParallaxBackground/fundo/Sprite").set_texture(text)
	
	#portal é retirado
	set_process(false)
	tempo = 5
	get_node("portal").set_opacity(0)
	
	#ver o timer e as animações e o set_process da nave
	get_node("passa_de_fase").stop()
	get_node("Nave").set_process(true)
		
	
	
	for i in get_children():
		if !(i.get_name() in isentos):
			i.queue_free()
			
	get_node("Nave").set_global_pos(Vector2(80,250))
	get_node("Camera").velocidade = 100
	
	#Restaurar vida
	var vidas = get_node("Camera").get_node("HUD/HP/value")
	var add_vida = 4-vidas.get_children().size()
	
	for i in range(add_vida):
		var vida = TextureFrame.new()
		vida.set_texture(load("res://Sprites/HUD/life.png"))
		vida.set_stretch_mode(4)
		vidas.add_child(vida)
	
	get_node("Nave").vida = 4
	
	#Restaurar pontuação
	get_node("Camera").get_node("HUD/SCORE/value").text = "0"
	
	
	#retira especial
	get_node("Nave").tempo_libera_especial = rand_range(20,30)/main.dificuldade
	get_node("Nave").especial = 0
	
	#modifica intervalo oo de aparição de vidas
	get_node("Nave").tempo_libera_vida = rand_range(50,65)
	
	get_tree().set_pause(false)
	get_tree().change_scene("res://Scenes/main.tscn")
	
#Timeout do timer de passar de fase
func _on_passa_de_fase_timeout():
		
	
		get_node("Nave").propul(null)
		
		get_node("Nave").set_global_pos(Vector2(20,main.y))
		
		get_node("Nave").set_process_input(true)
			
		#portal some ao passar de fase
		get_node("portal").set_opacity(0)
		
		#animação de sair do portal
		set_process(true)
		get_node("portal").set_global_pos(get_node("Nave").get_global_pos())
		
		
		get_node("passa_de_fase").stop()
	
	
	

func _process(delta):
	tempo-=delta
	
	if tempo<=0.5 and tempo>=0:	
		#portal aparece é realocado à frente da nave
		get_node("portal").set_global_pos(get_node("Nave").get_global_pos()+ Vector2(80,0))
		get_node("portal").set_opacity(1)
	
	if (tempo<=0 and tempo>=-2) or tempo<-3:
		get_node("Nave").move_local_x(5)
		get_node("Nave").propul("propulsorRight")
			
	if tempo<=0 and tempo>=-2:	
		if int(get_node("Nave").get_global_pos().x)>=int(get_node("portal").get_global_pos().x)-6 and int(get_node("Nave").get_global_pos().x)<=int(get_node("portal").get_global_pos().x)+6:
			#nave some porque viajou no tempo
			get_node("Nave").set_opacity(0)
			tempo = -2
			
			set_process(false)
		
	if tempo<-2 and tempo>=-2-delta:
		get_node("Nave").set_process(true)
		
	if tempo<-2.5:
		get_node("portal").set_opacity(1)
		
	if tempo<-3:
		get_node("Nave").set_opacity(1)
	
	if tempo<-4:
		tempo = 5
		main.tempo = 5
		get_node("portal").set_opacity(0)
		get_node("Camera").velocidade = 100
		set_process(false)
	
		
	
	
			
			
	
		
		