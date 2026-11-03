class Comensal {
    const mesa
    const indice
    var property position

    method image() = mesa.imagenComensal(indice)
}

// Un casillero del panel de la derecha: muestra la comida que falta entregar.
class CasilleroPedido {
    const mesa
    const indice
    var property position

    method image() = mesa.imagenPedido(indice)
}
