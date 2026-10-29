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
        const comidaEncontrada = comidas.listaComidas().filter({ c => c.position() == self.position().down(1) })
        
        if (comidaEncontrada != null) {
            self.agarrarComida(comidaEncontrada.first())
        }
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

}
