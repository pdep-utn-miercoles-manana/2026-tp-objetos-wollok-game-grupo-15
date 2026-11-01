import src.comidasComportamiento.*

object jugador {
    var property position = game.at(8, 1) 
    var property image = "jugador.png"
    var property inventarioComidas = []
    var property limiteActual = 1
    var property monedas = 10

    method arriba() {
        position = position.up(1)
    }

    method abajo() {
        position = position.down(1)
    }

    method izquierda() {
        position = position.left(1)
    }

    method derecha() {
        position = position.right(1)
    }

    method agarrar() {
         comidas.listaComidas()
        .filter({ c => c.position() == self.position().down(1) })
        .forEach({ c => self.agarrarComida(c) })
    }   

    method agarrarComida(comida) {
        console.println("jeje" + comida.tiempoCoccion().toString())
        if (inventarioComidas.size() < limiteActual && comida.tiempoCoccion() == 0) {
            console.println("je")
            const copia = comida.copiarEn(game.at(20 + inventarioComidas.size(), 4))
            inventarioComidas.add(copia)
            game.addVisual(copia)
        }

    }

    
    method iniciar() {
        game.addVisual(self)

        keyboard.up().onPressDo({ self.arriba() })
        keyboard.down().onPressDo({ self.abajo() })
        keyboard.left().onPressDo({ self.izquierda() })
        keyboard.right().onPressDo({ self.derecha() })
        
        keyboard.space().onPressDo({ self.agarrar() })
    }
    method entregar(mesa) {
    if (inventarioComidas.any({ c => mesa.quiere(c) })) {
        const comida = inventarioComidas.find({ c => mesa.quiere(c) })
        self.cobrar(mesa, comida)
    }
    }

    method cobrar(mesa, comida) {
        monedas += mesa.servir(comida)
        inventarioComidas.remove(comida)
        game.removeVisual(comida)
        self.reacomodarInventario()
    }

// al sacar una comida, las que quedan se corren para no dejar huecos
    method reacomodarInventario() {
        inventarioComidas.forEach({ c => c.position(game.at(20 + inventarioComidas.indexOf(c), 4)) })
    }

}
object cartelMonedas {
    const property position = game.at(22, 14)
    method text() = "Monedas: " + jugador.monedas().toString()
    method textColor() = "FFFFFF"
    }
