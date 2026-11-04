class Comensal {
    const mesa
    const indice
    var property position

    method image() = mesa.imagenComensal(indice)
    method hitbox() = true
}

// Un casillero del panel de la derecha: muestra la comida que falta entregar.
class CasilleroPedido {
    const mesa
    const indice
    var property position

    method image() = mesa.imagenPedido(indice)
    method hitbox() = true
}

class VacioSolido{
    var property position 
    method hitbox() = true
    method image() = "vacio.png"
}

class LugarEntrega{
    method image() = "vacio.png"
    var property position 
}
const m3LARR = new LugarEntrega(position = game.at(4, 3))
const m3LAB = new LugarEntrega(position = game.at(4, 6))

const m1LARR = new LugarEntrega(position = game.at(13, 3))
const m1LAB = new LugarEntrega(position = game.at(13, 6))

const m2LARR = new LugarEntrega(position = game.at(4, 10))
const m2LAB = new LugarEntrega(position = game.at(4, 13))

const m4LARR = new LugarEntrega(position = game.at(13, 10))
const m4LAB = new LugarEntrega(position = game.at(13, 13))