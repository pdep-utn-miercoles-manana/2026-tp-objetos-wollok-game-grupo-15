import src.comidasComportamiento.*
import src.vidasComportamiento.*

object jugador {
    var property position = game.at(8, 1) 
    var property image = "jugador.png"
    var property inventarioComidas = []
    var property monedas = 100
    var property comidaAgarrada = [] 

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
         comidas
        .filter({ c => c.position() == self.position().down(1) })
        .forEach({ c => self.agarrarComida(c) })
    }   

    method agarrarComida(comida) {
        if (inventarioComidas.size() < 4 && comida.tiempoCoccion() == 0) {
            const copia = comida.copiarEn(game.at(20 + inventarioComidas.size(), 4))
            inventarioComidas.add(copia)
            game.addVisual(copia)
            comida.reiniciarTiempo()
        }
    }

    method iniciar() {
        game.addVisual(self)
        vidas.reiniciarVidas()
        monedas = 100
        keyboard.up().onPressDo({ self.arriba() })
        keyboard.down().onPressDo({ self.abajo() })
        keyboard.left().onPressDo({ self.izquierda() })
        keyboard.right().onPressDo({ self.derecha() })
        
        keyboard.space().onPressDo({ self.agarrar() })

        keyboard.num1().onPressDo({ self.upgrade(0) })
        keyboard.num2().onPressDo({ self.upgrade(1) })
        keyboard.num3().onPressDo({ self.upgrade(2) })
        keyboard.num4().onPressDo({ self.upgrade(3) })
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
        inventarioComidas.size().times({ n =>
        inventarioComidas.get(n - 1).position(game.at(20 + n - 1, 4))
        })
    }

    method upgrade(indiceElegido) {
        const opcionesValidas = (0..3).filter({ i => i != indiceElegido })
        const random = opcionesValidas.anyOne()

        comidas.get(indiceElegido).bajarTiempoUpgrade()
        comidas.get(random).subirTiempoDowngrade()
        self.disminuirMonedas(comidas.get(indiceElegido))
    }
    
    method disminuirMonedas(comida){
        monedas = (monedas - comida.precio().div(2)).max(0)
    }
}
object cartelMonedas {
    const property position = game.at(21, 15)
    method text() = "Monedas: " + jugador.monedas().toString()
    method textColor() = "FFFFFF"
    }
