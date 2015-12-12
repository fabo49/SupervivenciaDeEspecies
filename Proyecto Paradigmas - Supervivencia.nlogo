
;                         Universidad de Costa Rica
;
;                   Escuela de Computación e Informática
;
;                        Paradigmas Computacionales
;
;                        Profesor: Alvaro de la Ossa
;
;                        Estudiantes:
;
;                              Fabián Rodríguez Obando       B25695
;
;                              José Pablo Ureña Gutiérrez    B16692
;
;
;                      Ciudad Universitaria Rodrigo Facio



to setup

  clear-all
  setup-patches
  setup-individuals
  set num_generation 1
  reset-ticks
  set global-badpoints (list)                                 ; Pizarra de agentes para la comunicacion y transmicion de informacion sobre los lugares peligrosos

end

to go

 move-turtles
 life-status
 individual-poisoned
 ; reproduce-turtles

  check-ticks
  if (ticks >= 1500)[
    set-info
    stop
    ]

end

to set-info ; Se recolectan las estadisticas de esa generacion
    let alive  count turtles with [shape = "bug" and color = black]
    let deads count turtles with [shape = "bug" and color = red]
    output-print (word "-- Fin de la generacion " num_generation " --")
    output-print (word "* Hormigas vivas: " alive)
    output-print (word "* Hormigas muertas: " deads)
    output-print "----------------------------"
    set-current-plot "Comportamiento de las generaciones"
    set-current-plot-pen "Vivas"
    plotxy num_generation alive
    set-current-plot-pen "Muertas"
    plotxy num_generation deads
end

; ------------------------------------------------------------------------------

;         Variables de las tortugas

; Los individuos poseen una vida, la cantidad de alimento consumido, coordenadas donde hay veneno y la cantidad de ticks que llevan vivos.
turtles-own [life food number_ticks_alive priority]                                
globals[num_generation global-badpoints]


; ------------------------------------------------------------------------------

;         Creacion de los elementos


to setup-individuals                                           ; Se crean los individuos del ambiente LA PRIMERA VEZ

  create-turtles  300                                           ; Número de individuos, siempre van a ser 300

  ask turtles with [ shape != "plant" and shape != "leaf" and shape != "tree" and shape != "flower" ]
  [

     set color black

     set shape "bug"

     set life life + 50

     set food 0
     
     set priority 0
     
     set number_ticks_alive 0                                                     ; Esto hay que ponerlo en 0 otra vez en cada generacion

     setxy 20 -15                                                                 ; Posicion de los individuos

     set size 1
  ]

  create-turtles 1 [ setxy 21 -16 set shape "bug" set size 3 set color 47 ]



  ;ask turtles [ pen-down ]

  ;ask turtles [ set memory list [ [ 0 0 ] [ 0 0 ] [ 0 0 ] ] ]                    ; Recuerdo de tres coordenadas peligrosas para el individuo

end


to setup-patches

 ask patches [ set pcolor brown ]
 draw-sky
 draw-grass
 grow-flowers
 create-food-space
 create-poison-space
 setup-queen

  create-turtles 1 [ setxy -17 -2 set shape "leaf" ]
  create-turtles 1 [ setxy -16 -3 set shape "leaf" ]
  create-turtles 1 [ setxy 14 5 set shape "leaf" ]
  create-turtles 1 [ setxy 15 4 set shape "leaf" ]
  create-turtles 1 [ setxy -18 8 set shape "plant" ]
  create-turtles 1 [ setxy -17 7 set shape "plant" ]
  create-turtles 1 [ setxy -2 0 set shape "plant" ]
  create-turtles 1 [ setxy -3 -1 set shape "plant" ]
  create-turtles 1 [ setxy -15 -14 set shape "plant" ]
  create-turtles 1 [ setxy -16 -15 set shape "plant" ]


end

to draw-sky
  let bigX 22
  let smallX -22

  while [ smallX <= bigX ]
  [

    create-turtles 1 [ setxy smallX 17 ]                       ; Tortuga encargada de pintar el cielo en primera linea

    ask turtles [

      if pcolor = brown [

        set pcolor 85
        die
      ]

    ]

    set smallX smallX + 1

  ]

  set smallX -22

  while [ smallX <= bigX ]
  [

    create-turtles 1 [ setxy smallX 16 ]                       ; Tortuga encargada de pintar el cielo en segunda linea

    ask turtles [

      if pcolor = brown [

        set pcolor 85
        die
      ]

    ]

    set smallX smallX + 1

  ]

  set smallX -22

  while [ smallX <= bigX ]
  [

    create-turtles 1 [ setxy smallX 15 ]                       ; Tortuga encargada de pintar el cielo en tercera linea

    ask turtles [

      if pcolor = brown [

        set pcolor 85
        die
      ]

    ]

    set smallX smallX + 1

  ]


end

to draw-grass                                                  ; Procedimiento encargado de dibujar la linea de cesped
  let bigX 22                                                  ; Variables de posicion para dibujo del terreno superior
  let smallX -22

  while [ smallX <= bigX ]
  [

    create-turtles 1 [ setxy smallX 14 ]                       ; Tortuga encargada de pintar el terreno

    ask turtles [

      if pcolor = brown [
        set pcolor 65
        die
      ]

    ]

    set smallX smallX + 1

  ]


   set bigX 22                                                            ; Se dibuja el limite del cesped con la tierra
   set smallX -22

  while [ smallX <= bigX ]
  [

    create-turtles 1 [ setxy smallX 13 ]                                  ; Tortuga encargada de pintar el limite del terreno

    ask turtles [

      if pcolor = brown [
        set pcolor 34
        die
      ]

    ]

    set smallX smallX + 1

  ]




end


to grow-flowers
  let loopA 0
  let loopB 0

  while [ loopA <= 5  ]                                        ; Se crean algunas flores
  [
    create-turtles 1 [ setxy random-xcor 15 set shape "flower" set size 2 ]
    set loopA loopA + 1
  ]


  while [ loopB <= 3  ]                                        ; Se crean algunos arboles
  [
    create-turtles 1 [ setxy random-xcor 16 set shape "tree" set size 3 set color green]
    set loopB loopB + 1
  ]

end


to setup-queen                                                 ; Se dibuja el sitio que alberga el individuo reina
  let bigX 22
  let smallX 17
  let bigY -12
  let smallY -17

  while [ bigY >= smallY ]
  [
    set smallX 17
    while [ smallX <= bigX ]
    [
       create-turtles 1 [ setxy smallX bigY ]
       ask turtles[
         if pcolor = brown[
           set pcolor 6
           die
         ]
       ]

       set smallX smallX + 1
     ]
    set bigY bigY - 1
  ]

  create-turtles 1 [ setxy 17 -12 ]
  create-turtles 1 [ setxy 18 -12 ]
  create-turtles 1 [ setxy 17 -13 ]

  ask turtles[
         if pcolor = 6[
           set pcolor brown
           die
         ]
  ]


end






; ----------------------------------------------------------------------------------

;                          Movimiento y vida de los agentes


to move-turtles
  ask turtles with [ shape != "plant" and shape != "leaf" and shape != "tree" and shape != "flower" and color != red and color != 47 ] [                 ; Los individuos muertos o la reina no se mueven

    constructive-path-algorithm


    if food > 0[                                  ; El movimiento del individuo consume alimento

      set food food - 1

     ]

  ]
end

to constructive-path-algorithm                           

  ;                        Etapas de movimiento del individuo:
  
  ; 1- Se propone una futura posicion
  ; 2- Se verifica si dicha posicion es peligrosa o no
  ; 2.1 - Si es peligrosa, se propone una nueva
  ; 2.2 - Si es desconocida, se mueve a ese punto
  ; 3- Se verifica si la nueva posicion es peligrosa o no
  ; 3.1- Si es peligrosa, se agrega a la lista y se devuelve a su posicion anterior, vuelve a proponer una nueva posicion
  ; 3.2- Si no es peligrosa, se queda alli

 let continue true
 let future-left 0
 let future-right 0
 let sub-list [ ]                                 ; Posicion a la que se movera el individuo  
 
 while [ continue ]
 
 [
 
  ;-------------- 1. Se propone una futura posicion --------------------
 
    set future-left random 360
    set future-right random 360 
 
    set sub-list[]
    set sub-list list (future-left) (future-right) 
 
  ;-------------- 2. Se verifica si la futura posicion es peligrosa o no --------------------
 
    ifelse member? sub-list global-badpoints[
      
  ;-------------- 2.1. Futura posicion peligrosa --------------------
      
      ; Dummy
    ]
    
    [
      
  ;-------------- 2.2. Futura posicion desconocida --------------------
        
       left future-left
       right future-right
       forward 1
       set continue false
       
  ;-------------- 3. Se verifica la nueva posicion --------------------    
  
     ifelse pcolor = 17 [
        
        ; El individuo esta en veneno, se queda quieto
        set continue false
     ]
     
     [
       
       let danger false
       
       ask other turtles in-radius 1 [                          ; Se verifica el radio del individuo 
         
         if color = red[                                        ; Hay un individuo envenenado
           
           set danger true
           
           ]
         
        ]
      
  ;-------------- 3.1 La nueva posicion es peligrosa --------------------          
      
      ifelse danger[
        
        set sub-list []
        set sub-list list (future-left) (future-right) 
        set global-badpoints fput sub-list global-badpoints                   ; Se agrega a las posiciones peligrosas
        forward -1
        set continue true                                                     ; Vuelve a escoger nueva futura posicion        
      ]
      [
        
  ;-------------- 3.2 La nueva posicion es segura --------------------              
        
        set continue false
       ] 
       
       
     ]; Fin else
     
         
      
    ] ; Fin de else
 
 ]; Fin de While
 
 ; Se evita el cesped por parte de los individuos
 
 if pcolor = 34 [
   forward -1
   left 2
 ]

end



to reproduce-turtles

  if random 10 > 8 [

   create-turtles  10  [ setxy 20 -15 ]                                            ; Número de individuos iniciales

   ask turtles with [ shape != "plant" and shape != "leaf" and shape != "bug" and shape != "tree" and shape != "flower" and color != 47  ]
   [

     set color black

     set shape "bug"

     set life life + 50

     set food 0

     set size 1
   ]

  ]
end


to life-status                          ; La vida del individuo se ve aumentada o reducida

  ask turtles
  [

      if food = 0[                        ; Cada vez que el individuo no posea alimento, su vida se reduce

        set life life - 2

      ]

      if food > 5[                        ; Su vida mejora con una buena cantidad de alimento

        set life life + 1
        set food food - 1

      ]

   ]

  ;ask turtles with [ life = 0 ]
  ;[
  ;  set color red
  ;]

end


to individual-poisoned                   ; El individuo se posa sobre un patch o alimento envenenado

  ask turtles-on patches with[ pcolor = 56 ]     ; Individuos  sobre alimento
  [
    set food food + 1
   ]

  ask turtles-on patches with[ pcolor = 17 ]     ; Individuos  sobre veneno
  [
    set food 0
    set life 0
    set color red

   ]

end

; ----------------------------------------------------------------------------------

;                          Funciones de cambios generacionales

to check-ticks ; Se encarga de actualizar las posiciones de las hormigas y de "revivirlas"
  
  ifelse ticks >= 1500
  [; Lo hace el if (fin de una generacion)
    change-generation
  ]
  [; Lo hace en el else
    tick
    ]
end

to change-generation ; Se encarga de hacer el cambio de generacion, revive las hormigas muertas (tambien les vacia su memoria) y a las que sobrevivieron les incrementa la prioridad
    set-current-plot "Comportamiento de la generación actual" 
    clear-plot
    set num_generation num_generation + 1
    ; Vuelve las hormigas a la posicion de salida y las "revive"
    ask turtles with [shape = "bug" and (color = red or color = black)][
      ask turtles with [shape = "bug" and color = black][
        set priority priority + 1 ; Como sobrevivio, entonces incrementamos su prioridad en 1
        ]
      set color black
      ; ***** OJO ***** Antes de setear esto en 0, hay que elegir los que tienen mas "number_ticks_alive" para clonarlos para la siguiente generación
      set number_ticks_alive 0
      setxy 20 -15
      ]
    reset-ticks
end

; ----------------------------------------------------------------------------------

;                          Ajustes del ambiente



to create-food-space                       ; Se crea el lugar de alimento para los individuos

  let bigX -15                             ; Estacion 1 de alimento para individuos
  let smallX -18
  let bigY -1
  let smallY -4

  while [ bigY >= smallY ]
  [
    set smallX -18
    while [ smallX <= bigX ]
    [
       create-turtles 1 [ setxy smallX bigY ]
       ask turtles[
         if pcolor = brown[
           set pcolor 56
           die
         ]
       ]

       set smallX smallX + 1
     ]
    set bigY bigY - 1
  ]

  set bigX 16                                  ; Estacion 2 de alimento para individuos
  set smallX 13
  set bigY 6
  set smallY 3

  while [ bigY >= smallY ]
  [
    set smallX 13
    while [ smallX <= bigX ]
    [
       create-turtles 1 [ setxy smallX bigY ]
       ask turtles[
         if pcolor = brown[
           set pcolor 56
           die
         ]
       ]

       set smallX smallX + 1
     ]
    set bigY bigY - 1
  ]


end



to create-poison-space                         ; Se crea veneno en el ambiente

  let bigX -16                                 ; Estacion 1 de veneno para individuos
  let smallX -19
  let bigY 9
  let smallY 6

  while [ bigY >= smallY ]
  [
    set smallX -19
    while [ smallX <= bigX ]
    [
       create-turtles 1 [ setxy smallX bigY ]
       ask turtles[
         if pcolor = brown[
           set pcolor 17
           die
         ]
       ]

       set smallX smallX + 1
     ]
    set bigY bigY - 1
  ]

  set bigX -1                                  ; Estacion 2 de veneno para individuos
  set smallX -4
  set bigY 1
  set smallY -2

  while [ bigY >= smallY ]
  [
    set smallX -4
    while [ smallX <= bigX ]
    [
       create-turtles 1 [ setxy smallX bigY ]
       ask turtles[
         if pcolor = brown[
           set pcolor 17
           die
         ]
       ]

       set smallX smallX + 1
     ]
    set bigY bigY - 1
  ]

  set bigX -14                                  ; Estacion 3 de veneno para individuos
  set smallX -17
  set bigY -13
  set smallY -16

  while [ bigY >= smallY ]
  [
    set smallX -17
    while [ smallX <= bigX ]
    [
       create-turtles 1 [ setxy smallX bigY ]
       ask turtles[
         if pcolor = brown[
           set pcolor 17
           die
         ]
       ]

       set smallX smallX + 1
     ]
    set bigY bigY - 1
  ]

end

@#$#@#$#@
GRAPHICS-WINDOW
115
14
774
549
22
17
14.422222222222222
1
10
1
1
1
0
0
0
1
-22
22
-17
17
0
0
1
ticks
30.0

BUTTON
32
100
95
133
NIL
GO
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

BUTTON
31
179
98
212
NIL
SETUP
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1063
58
1168
103
Hormigas vivas
count turtles with [shape = \"bug\" and color = black]
17
1
11

MONITOR
799
60
912
105
Hormigas muertas
count turtles with [color = red and shape = \"bug\"]
17
1
11

PLOT
797
120
1167
278
Comportamiento de la generación actual
Tiempo (ticks)
Hormigas
0.0
1500.0
0.0
300.0
true
false
"" ""
PENS
"Hormigas vivas" 1.0 2 -13840069 true "" "plot count turtles with [shape = \"bug\" and color = black]"
"Hormigas muertas" 1.0 2 -2674135 true "" "plot count turtles with [shape = \"bug\" and color = red]"

TEXTBOX
1191
211
1326
245
Hormigas muertas
14
15.0
1

TEXTBOX
1189
167
1305
189
Hormigas vivas
14
65.0
1

OUTPUT
797
328
1045
547
12

PLOT
1056
330
1369
546
Comportamiento de las generaciones
Generación
Hormigas
0.0
10.0
0.0
300.0
true
false
"" ""
PENS
"Muertas" 1.0 0 -2674135 true "" ""
"Vivas" 1.0 0 -13840069 true "" ""

TEXTBOX
800
26
950
44
Generación actual
14
0.0
1

TEXTBOX
800
296
1067
314
Historial de las generaciones pasadas
14
0.0
1

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
