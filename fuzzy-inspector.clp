(deftemplate gravedad-averia
  0 10 severidad
  ((ninguna   (0 1)(2 1)(4 0))
   (moderada  (2 0)(5 1)(7 0))
   (grave     (5 0)(7 1)(9 0))
   (critica   (7 0)(9 1)(10 1)))
)

(deftemplate num-averias
  0 6 averias
  ((pocas    (0 1)(1 1)(3 0))
   (algunas  (1 0)(3 1)(5 0))
   (muchas   (3 0)(5 1)(6 1)))
)

(deftemplate descuento-precio
  0 40 porcentaje
  ((pequeno   (0 1)(5 1)(15 0))
   (moderado  (5 0)(20 1)(30 0))
   (grande    (25 0)(35 1)(40 1)))
)

(defrule FZ1-sin-averia-pocas
  (gravedad-averia ninguna)
  (num-averias pocas)
  =>
  (assert (descuento-precio pequeno))
  (printout t "[FZ1] Sin averias + pocas -> descuento pequeno" crlf)
)

(defrule FZ2-moderada-pocas
  (gravedad-averia moderada)
  (num-averias pocas)
  =>
  (assert (descuento-precio pequeno))
  (printout t "[FZ2] Moderada + pocas -> descuento pequeno" crlf)
)

(defrule FZ3-moderada-algunas
  (gravedad-averia moderada)
  (num-averias algunas)
  =>
  (assert (descuento-precio moderado))
  (printout t "[FZ3] Moderada + algunas -> descuento moderado" crlf)
)

(defrule FZ4-moderada-muchas
  (gravedad-averia moderada)
  (num-averias muchas)
  =>
  (assert (descuento-precio moderado))
  (printout t "[FZ4] Moderada + muchas -> descuento moderado" crlf)
)

(defrule FZ5-grave
  (gravedad-averia grave)
  =>
  (assert (descuento-precio grande))
  (printout t "[FZ5] Averia grave -> descuento grande" crlf)
)

(defrule FZ6-critica
  (gravedad-averia critica)
  =>
  (assert (descuento-precio grande))
  (printout t "[FZ6] Averia critica -> descuento grande" crlf)
)

(defrule FZ7-muchas
  (num-averias muchas)
  =>
  (assert (descuento-precio grande))
  (printout t "[FZ7] Muchas averias -> descuento grande" crlf)
)

(deffacts caso-A
  (gravedad-averia (7.5))
  (num-averias (4))
)
