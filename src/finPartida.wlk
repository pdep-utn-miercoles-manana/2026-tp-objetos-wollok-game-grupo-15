class PantallaFin {
    const property image
    const property position = game.at(0, 0)
}

object finPartida {
    method ganar() { game.addVisual(new PantallaFin(image = "victoria.png")) }
    method perder() { game.addVisual(new PantallaFin(image = "derrota.png")) }
}
