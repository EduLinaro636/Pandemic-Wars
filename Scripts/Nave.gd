
extends Area2D


var vida = 4

#nave invertida?
var invertida = false

#func_de inverter

func inverte_nave():
	
		invertida = not invertida
		
		#espelha no eixo horizontal
		get_node("Sprite").set_flip_h(not get_node("Sprite").is_flipped_h())
		get_node("propulsorDown").set_flip_h(not get_node("propulsorDown").is_flipped_h())
		get_node("propulsorUp").set_flip_h(not get_node("propulsorUp").is_flipped_h())
		get_node("propulsorRight").set_flip_h(not get_node("propulsorRight").is_flipped_h())
		get_node("propulsorLeft").set_flip_h(not get_node("propulsorLeft").is_flipped_h())
		
		#altera as posições
		if invertida:
			get_node("propulsorDown").set_pos(Vector2(65,-19))
			get_node("propulsorDown").set_rot(-289.5*PI/180)
			get_node("propulsorUp").set_pos(Vector2(66.5,37.5))
			get_node("propulsorUp").set_rot(104*PI/180)
			
			get_node("propulsorRight").set_pos(Vector2(82,8))
			get_node("propulsorLeft").set_pos(Vector2(84,8))
			get_node("PosTiro").set_pos(Vector2(-57,8))
		else:
			get_node("propulsorDown").set_pos(Vector2(-63,-12))
			get_node("propulsorDown").set_rot(-245.5*PI/180)
			get_node("propulsorUp").set_pos(Vector2(-61,29.5))
			get_node("propulsorUp").set_rot(74.3*PI/180)
			
			get_node("propulsorRight").set_pos(Vector2(-76,8))
			get_node("propulsorLeft").set_pos(Vector2(-74,8))
			get_node("PosTiro").set_pos(Vector2(54,8))

#Muda o texto de início de fase	
func muda_de_frase(frase):
	if frase=="info":
		if main.fase==1:
			frase = "Ano: 2019   Local: Wuhan, China"
		elif main.fase==2:
			frase = "Ano: 1918   Local: Granada, Espanha"
		elif main.fase==3:
			frase = "Ano: 1981   Local: Estados Unidos "
		elif main.fase==4:
			frase = "Ano: 1817   Local: Índia"
		elif main.fase==5:
			frase = "Ano: 70000 A.C   Local: África"
		else:
			frase = "Ano: 1348   Local: Oriente Médio"
		
		
	else:
		pass
		
	get_parent().get_node("lbl_passa_de_fase").text = frase


func spawn_inimigos():	
	var texture
	
	#Tocar a música do chefe
	var chefe = get_tree().get_nodes_in_group(main.CHEFE)
	
	if chefe.size()==1:
		var musica = get_parent().get_node("Musicas/Fase %d/fase"%main.fase)
		
		if musica.is_playing():
			#Diminui o volume da música ao surgimento do chefe
			musica.set_volume(musica.get_volume()-0.01)
		
		if musica.get_volume()<=0:
			musica.stop()
			musica.set_volume(1)
				
			musica = get_parent().get_node("Musicas/Fase %d/chefe"%main.fase)
	
			musica.play()
	
	
	if not main.fase_em_andamento and main.fase<7:
		if main.fase>3 and main.fase<7:
			muda_de_frase("Missão %d: Elimine a bactéria causadora da %s"%[main.fase,main.NIVEIS[main.fase-1]])
		elif main.fase<4:
			muda_de_frase("Missão %d: Elimine o vírus causador da %s"%[main.fase,main.NIVEIS[main.fase-1]])	
	
		
		get_parent().get_node("Animacoes").play("inicio_de_fase")
		get_parent().get_node("Musicas/Fase %d/fase"%main.fase).play()
	
		
			
	elif main.fase<5:
		get_parent().get_node("ParallaxBackground/fundo").set_mirroring(Vector2(1024,0))
			
			
	if main.fase==1 and not main.fase_em_andamento:
		main.fase_em_andamento = 1
		var coronas = load("res://Scenes/Inimigos/Corona/Corona_spawner.tscn")
		coronas = coronas.instance()
		get_parent().add_child(coronas)
			
		
	elif main.fase==2 and not main.fase_em_andamento:
		texture = load("res://Sprites/Fundos/fundo_espanhola.jpg")
		get_parent().get_node("ParallaxBackground/fundo/Sprite").set_texture(texture)	
		main.fase_em_andamento = 1
		var esp
		esp = load("res://Scenes/Inimigos/Espanhola/Espanhola_spawner.tscn")
		esp = esp.instance()
		get_parent().add_child(esp)
		
	elif main.fase==3 and not main.fase_em_andamento:
		texture = load("res://Sprites/Fundos/fundo_hiv.png")
		get_parent().get_node("ParallaxBackground/fundo/Sprite").set_texture(texture)
		
		var hiv
		hiv = load("res://Scenes/Inimigos/HIV/HIV_spawner.tscn")
		hiv = hiv.instance()
		get_parent().add_child(hiv)
		
		main.fase_em_andamento = 1
		
	elif main.fase==4 and not main.fase_em_andamento:
		texture = load("res://Sprites/Fundos/fundo_colera.png")
		get_parent().get_node("ParallaxBackground/fundo/Sprite").set_texture(texture)
		
		var colera
		colera = load("res://Scenes/Inimigos/Cólera/Cólera_spawner.tscn")
		colera = colera.instance()
		get_parent().add_child(colera)
		
		main.fase_em_andamento = 1
	elif main.fase==5 and not main.fase_em_andamento:
		get_parent().get_node("ParallaxBackground/fundo").set_mirroring(Vector2(1782,0))
		
		texture = load("res://Sprites/Fundos/fundo_tuberculose.png")
		get_parent().get_node("ParallaxBackground/fundo/Sprite").set_texture(texture)
		
		var tuberculose
		tuberculose = load("res://Scenes/Inimigos/Tuberculose/Tuberculose_spawner.tscn")
		tuberculose = tuberculose.instance()
		get_parent().add_child(tuberculose)
		
		main.fase_em_andamento = 1
		
	elif main.fase==6 and not main.fase_em_andamento:
		get_parent().get_node("ParallaxBackground/fundo").set_mirroring(Vector2(1800,0))
		
		texture = load("res://Sprites/Fundos/fundo_peste_negra.png")
		get_parent().get_node("ParallaxBackground/fundo/Sprite").set_texture(texture)
		
		var peste
		peste = load("res://Scenes/Inimigos/PesteNegra/PesteNegra_spawner.tscn")
		peste = peste.instance()
		get_parent().add_child(peste)
		
		main.fase_em_andamento = 1
	elif main.fase==7 and not main.fase_em_andamento:
		get_tree().change_scene("res://Scenes/Sucesso.tscn")
	
#função que define o propulsor atual
func propul(propulsor):
	get_node("propulsorLeft").hide()
	get_node("propulsorDown").hide()
	get_node("propulsorUp").hide()
	get_node("propulsorRight").hide()
	
	if propulsor != null:
		get_node(propulsor).show()
		
		if not get_node("AnimationPlayer").is_playing():	
			if propulsor=="propulsorRight" or propulsor=="propulsorUp":
				get_node("Sample").play("movi_up_right")
			else:
				get_node("Sample").play("movi_down_left")




func movimentacao(entrada,delta):
	var x = 0
	var y = 0
	var propulsor = null
	
	
	if entrada.is_action_pressed("ui_cima"):
		y=-1
		propulsor = "propulsorUp"
		
	elif entrada.is_action_pressed("ui_baixo"):
		y=1
		propulsor = "propulsorDown"
		
	elif entrada.is_action_pressed("ui_esq"):
		x=-1
		propulsor = "propulsorLeft"
		if invertida:
			propulsor = "propulsorRight"
			
		
	elif entrada.is_action_pressed("ui_dir"):
		x=1
		propulsor = "propulsorRight"
		if invertida:
			propulsor = "propulsorLeft"
	
	
	var largura = get_node("Sprite").get_item_rect().size.x
	var altura =  get_node("Sprite").get_item_rect().size.y
	
	if get_pos().x + x*200*delta >=  1034 - largura/2 or get_pos().x + x*200*delta <= largura/2 :
		x = 0	
	if get_pos().y + y*200*delta >=  630 - altura/2 or get_pos().y + y*200*delta <= altura/3 :
		y = 0
	
	set_pos(get_pos() + Vector2(x,y) * 200 * delta)
	propul(propulsor)

	
		
var disparo = 0

#Variáveis responsáveis por controlar o disparo especial
var especial = 0
var tempo_especial = 30
var tempo_libera_especial = rand_range(20,30)/main.dificuldade

				
func dispara_tiro():
		var tiro = load("res://Scenes/Tiro.tscn")
		
		var inst = tiro.instance()
		
		if especial:
			inst.velocidade = 700
			
			#muda a textura
			
			var texture = load("res://Sprites/tiro_rapido.png")
			
			inst.get_node("Sprite").set_texture(texture)
			
			
		if invertida:
			inst.velocidade = -inst.velocidade
		
		var largura = get_node("Sprite").get_item_rect().size.width
				
		largura = Vector2(largura/2,0)
		
		var postiro = get_node("PosTiro").get_global_pos()
		
		inst.set_global_pos(postiro)
		
		var main = get_parent()
		main.add_child(inst)
	
#Variáveis responsáveis pelo aumento de vida
var nova_vida = 0			
var tempo_libera_vida = rand_range(50,60)/main.dificuldade
					
	
func _ready():
	add_to_group("jogador")
	set_process(true)
	set_process_input(true)
	connect("area_enter",self,"_on_area_enter")

	
	
	

func _process(delta):
	var entrada = Input
	
	if entrada.is_action_pressed("ui_tecla"):
		if main.tempo==5:
			movimentacao(entrada,delta)
	else:
		propul(null)
	if entrada.is_action_pressed("ui_tiro"):
		if disparo<=0:
			dispara_tiro()
			if especial:
				disparo = 0.15
			else:
				disparo = 0.30
	disparo-=delta
	
	
	#controle do especial
	var chefe = get_tree().get_nodes_in_group(main.CHEFE).size()
	
	if especial==0:
		if not chefe:
			tempo_libera_especial-=delta
			if tempo_libera_especial<=0:
				#solta o especial
				var esp = load("res://Scenes/Objetos/AumentaTiro.tscn")
				esp = esp.instance()
				
				get_parent().add_child(esp)				
				tempo_libera_especial=rand_range(20,30)/main.dificuldade
		
				
	else:
		tempo_especial-=delta
		
		if tempo_especial<=0:
			especial = 0
			tempo_especial = 30
			
	#Aumento de vida
	if nova_vida==0:
		if not chefe and main.fase>1:
			tempo_libera_vida-=delta
			if tempo_libera_vida<=0:
				#solta o especial
				var v = load("res://Scenes/Objetos/AumentaVida.tscn")
				v = v.instance()
				
				get_parent().add_child(v)				
				tempo_libera_vida=rand_range(50,60)/main.dificuldade
				
				nova_vida = 1
		
				
	
		
		
	
	#função que spawna inimigos de acordo com a fase
	spawn_inimigos()
	
	
func leva_dano(dano):
		var verihit = 0
		
		if get_node("AnimationPlayer").is_playing():
			verihit = 1
		else:
			#Muda o hud
			var vidas = get_parent().get_node("Camera/HUD/HP/value").get_children()
			for i in range(dano):
				if vidas.size()>0:
					vidas[-1].queue_free()	
					vidas.pop_back()			
			vida-=dano
		
		if vida<=0 and verihit==0:
			#Remove o a nave do grupo jogador para não ser atingido por inimigos novamente
			remove_from_group("jogador")
			
			#muda o texto padrão para gameover
			muda_de_frase("Game Over")
			
			#para a música
			get_parent().get_node("Musicas/Fase %d/fase"%(main.fase)).stop()
			get_parent().get_node("Musicas/Fase %d/chefe"%(main.fase)).stop()
			
			get_parent().get_node("Animacoes").play("passa_de_fase")
			get_node("AnimationPlayer").play("morte")
			get_node("Sample").play("explosion_jogador")
			get_node("Restart").start()
			propul(null)
			set_process(false)
		else:
			if not verihit:
				set_global_pos(Vector2(80,250))
				get_node("AnimationPlayer").play("hit")
				get_node("Sample").play("hit_jogador")
						
func _on_area_enter(area):
	if main.INIMIGOS in area.get_groups() or main.CHEFE in area.get_groups():
		if get_tree().get_nodes_in_group("jogador").size()!=0:
			leva_dano(1)
	

			
	
func _on_Restart_timeout():
	get_node("Restart").stop()
	get_node("Sprite").set_opacity(1)
	get_node("Particles2D").set_emitting(false)
	set_process(true)
	get_parent().new_game()
	
func _input(event):
	if not event.is_echo():
		if event.is_action_pressed("ui_inverte"):
			inverte_nave()
		
