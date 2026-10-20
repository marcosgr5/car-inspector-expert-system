(defrule inicio
  (declare (salience 100))
  =>
  (printout t crlf)
  (printout t "============================================" crlf)
  (printout t "   INSPECTOR DE COCHES DE SEGUNDA MANO     " crlf)
  (printout t "============================================" crlf)
  (printout t " Responde con las opciones entre           " crlf)
  (printout t " parentesis y pulsa INTRO.                 " crlf)
  (printout t "============================================" crlf crlf)
  (printout t "Tipo de combustible (gasolina/diesel): ")
  (bind ?r (read))
  (assert (tipo-combustible ?r))
  (assert (fase fluidos))
)

(defrule preguntar-fluidos
  (declare (salience 90))
  ?f <- (fase fluidos)
  =>
  (printout t crlf)
  (printout t "-- FASE 1: FLUIDOS (motor apagado) ---------" crlf crlf)
  (printout t "Color del aceite en la varilla" crlf)
  (printout t "  (ambar / negro / beige-cremoso): ")
  (assert (color-aceite (read)))
  (printout t "Textura del aceite (normal / espesa): ")
  (assert (textura-aceite (read)))
  (printout t "Color del refrigerante" crlf)
  (printout t "  (verde-normal / marron-turbio): ")
  (assert (color-refrigerante (read)))
  (printout t "Nivel liquido de frenos (correcto / bajo): ")
  (assert (nivel-frenos (read)))
  (printout t "Color liquido de frenos" crlf)
  (printout t "  (amarillo-claro / marron-oscuro): ")
  (assert (color-liquido-frenos (read)))
  (retract ?f)
  (assert (fase carroceria))
)

(defrule preguntar-carroceria
  (declare (salience 90))
  ?f <- (fase carroceria)
  =>
  (printout t crlf)
  (printout t "-- FASE 2: CARROCERIA Y CHASIS -------------" crlf crlf)
  (printout t "Textura de la pintura" crlf)
  (printout t "  (lisa-uniforme / rugosa): ")
  (assert (textura-pintura (read)))
  (printout t "Uniformidad del color entre paneles" crlf)
  (printout t "  (uniforme / diferencias-de-tono): ")
  (assert (uniformidad-color (read)))
  (printout t "Holgura al cerrar las puertas" crlf)
  (printout t "  (normal / excesiva): ")
  (bind ?hol (read))
  (assert (holgura-puerta ?hol))
  (if (eq ?hol excesiva)
    then
      (printout t "Sonido al cerrar la puerta (normal / hueco): ")
      (assert (sonido-puerta (read)))
    else
      (assert (sonido-puerta normal))
  )
  (retract ?f)
  (assert (fase dinamica))
)

(defrule preguntar-dinamica
  (declare (salience 90))
  ?f <- (fase dinamica)
  =>
  (printout t crlf)
  (printout t "-- FASE 3: PRUEBA DINAMICA (motor en marcha)" crlf crlf)
  (printout t "Color del humo de escape" crlf)
  (printout t "  (incoloro / blanco / azul / negro): ")
  (bind ?hum (read))
  (assert (color-humo ?hum))
  (if (eq ?hum blanco)
    then
      (printout t "Temperatura del motor en este momento" crlf)
      (printout t "  (fria / caliente): ")
      (assert (temperatura-motor (read)))
    else
      (assert (temperatura-motor caliente))
  )
  (printout t "Sonido del motor" crlf)
  (printout t "  (silencioso / golpeteo-metalico / silbido): ")
  (bind ?son (read))
  (assert (sonido-motor ?son))
  (if (or (eq ?son golpeteo-metalico) (eq ?son silbido))
    then
      (printout t "Momento del sonido (ralenti / aceleracion): ")
      (assert (momento-sonido (read)))
    else
      (assert (momento-sonido ninguno))
  )
  (printout t "Vibracion del chasis (normal / excesiva): ")
  (bind ?vib (read))
  (assert (vibracion-chasis ?vib))
  (if (eq ?vib excesiva)
    then
      (printout t "A que velocidad vibra (baja / alta): ")
      (assert (velocidad (read)))
    else
      (assert (velocidad normal))
  )
  (retract ?f)
  (assert (fase diagnostico))
)

(defrule R1-junta-culata
  (fase diagnostico)
  (color-aceite beige-cremoso)
  (textura-aceite espesa)
  =>
  (assert (diagnostico junta-culata-rota CRITICA))
)

(defrule R2-aceite-degradado
  (fase diagnostico)
  (color-aceite negro)
  (textura-aceite normal)
  =>
  (assert (diagnostico aceite-muy-degradado GRAVE))
)

(defrule R3-refrigerante-contaminado
  (fase diagnostico)
  (color-refrigerante marron-turbio)
  =>
  (assert (diagnostico refrigerante-contaminado GRAVE))
)

(defrule R4-frenos-desgastados
  (fase diagnostico)
  (nivel-frenos bajo)
  (color-liquido-frenos marron-oscuro)
  =>
  (assert (diagnostico frenos-muy-desgastados GRAVE))
)

(defrule R5-repintado-golpe
  (fase diagnostico)
  (textura-pintura rugosa)
  =>
  (assert (diagnostico golpe-reparado-repintado MODERADA))
)

(defrule R6-chasis-doblado
  (fase diagnostico)
  (holgura-puerta excesiva)
  (sonido-puerta hueco)
  =>
  (assert (diagnostico chasis-doblado CRITICA))
)

(defrule R7-reparacion-chapa
  (fase diagnostico)
  (uniformidad-color diferencias-de-tono)
  =>
  (assert (diagnostico reparacion-de-chapa MODERADA))
)

(defrule R8-motor-quema-aceite
  (fase diagnostico)
  (color-humo azul)
  =>
  (assert (diagnostico motor-quemando-aceite CRITICA))
)

(defrule R9-condensacion-normal
  (fase diagnostico)
  (color-humo blanco)
  (temperatura-motor fria)
  =>
  (assert (diagnostico condensacion-normal NINGUNA))
)

(defrule R10-fuga-refrigerante
  (fase diagnostico)
  (color-humo blanco)
  (temperatura-motor caliente)
  =>
  (assert (diagnostico fuga-refrigerante-motor CRITICA))
)

(defrule R11-mezcla-rica
  (fase diagnostico)
  (color-humo negro)
  =>
  (assert (diagnostico mezcla-rica-combustible MODERADA))
)

(defrule R12-desgaste-bielas
  (fase diagnostico)
  (sonido-motor golpeteo-metalico)
  (momento-sonido ralenti)
  =>
  (assert (diagnostico desgaste-bielas-cojinetes CRITICA))
)

(defrule R13-turbo-deteriorado
  (fase diagnostico)
  (sonido-motor silbido)
  (momento-sonido aceleracion)
  (tipo-combustible diesel)
  =>
  (assert (diagnostico turbo-deteriorado GRAVE))
)

(defrule R14-problemas-suspension
  (fase diagnostico)
  (vibracion-chasis excesiva)
  (velocidad baja)
  =>
  (assert (diagnostico problema-suspension MODERADA))
)

(defrule diagnostico-completo
  (declare (salience -1))
  (fase diagnostico)
  (not (sintesis-lista))
  =>
  (assert (sintesis-lista))
)

(defrule cabecera-informe
  (declare (salience 50))
  (sintesis-lista)
  (not (cabecera-mostrada))
  =>
  (assert (cabecera-mostrada))
  (printout t crlf)
  (printout t "============================================" crlf)
  (printout t "          INFORME DE DIAGNOSTICO           " crlf)
  (printout t "============================================" crlf)
  (printout t "Averias detectadas:" crlf)
)

(defrule mostrar-critica
  (declare (salience 45))
  (sintesis-lista)
  (diagnostico ?av CRITICA)
  (not (mostrada ?av))
  =>
  (assert (mostrada ?av))
  (printout t "  [!!CRITICA]  " ?av crlf)
)

(defrule mostrar-grave
  (declare (salience 44))
  (sintesis-lista)
  (diagnostico ?av GRAVE)
  (not (mostrada ?av))
  =>
  (assert (mostrada ?av))
  (printout t "  [! GRAVE ]  " ?av crlf)
)

(defrule mostrar-moderada
  (declare (salience 43))
  (sintesis-lista)
  (diagnostico ?av MODERADA)
  (not (mostrada ?av))
  =>
  (assert (mostrada ?av))
  (printout t "  [  MOD.  ]  " ?av crlf)
)

(defrule mostrar-ninguna
  (declare (salience 43))
  (sintesis-lista)
  (diagnostico ?av NINGUNA)
  (not (mostrada ?av))
  =>
  (assert (mostrada ?av))
  (printout t "  [  OK    ]  " ?av crlf)
)

(defrule R15-no-comprar
  (declare (salience 30))
  (sintesis-lista)
  (diagnostico ? CRITICA)
  (not (recomendacion ?x))
  =>
  (assert (recomendacion NO-COMPRAR))
  (printout t crlf)
  (printout t "--------------------------------------------" crlf)
  (printout t " RECOMENDACION: NO COMPRAR                 " crlf)
  (printout t " Hay al menos una averia critica.          " crlf)
  (printout t " No proceda a la compra de este vehiculo.  " crlf)
  (printout t "============================================" crlf crlf)
)

(defrule R16-negociar-precio
  (declare (salience 20))
  (sintesis-lista)
  (not (diagnostico ? CRITICA))
  (diagnostico ? GRAVE)
  (not (recomendacion ?x))
  =>
  (assert (recomendacion NEGOCIAR-PRECIO))
  (printout t crlf)
  (printout t "--------------------------------------------" crlf)
  (printout t " RECOMENDACION: NEGOCIAR PRECIO            " crlf)
  (printout t " No hay averias criticas pero si graves.   " crlf)
  (printout t " Exija una reduccion de precio.            " crlf)
  (printout t "============================================" crlf crlf)
)

(defrule R17-compra-viable
  (declare (salience 10))
  (sintesis-lista)
  (not (diagnostico ? CRITICA))
  (not (diagnostico ? GRAVE))
  (not (recomendacion ?x))
  =>
  (assert (recomendacion COMPRA-VIABLE))
  (printout t crlf)
  (printout t "--------------------------------------------" crlf)
  (printout t " RECOMENDACION: COMPRA VIABLE              " crlf)
  (printout t " No se detectaron averias criticas ni      " crlf)
  (printout t " graves. La compra parece razonable.       " crlf)
  (printout t "============================================" crlf crlf)
)
