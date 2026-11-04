import src.comidasComportamiento.*
import src.vidasComportamiento.*
import src.visualesSalon.*
import src.restauranteEntorno.*


object jugador {
    var property position = game.at(8, 1) 
    var property image = "jugador.png"
    var property inventarioComidas = []
    var property monedas = 100
    var property comidaAgarrada = [] 

    method puedoMoverA(posicionDestino) {
        const dentroDeRango = posicionDestino.x().between(0, 17) && 
                              posicionDestino.y().between(0, game.height() - 1)
                              
        const haySolido = game.getObjectsIn(posicionDestino).any({ obj => obj.hitbox() })

        return dentroDeRango && !haySolido
    }

    method arriba() {
        const destino = position.up(1)
        if (self.puedoMoverA(destino)) {
            position = destino
        }
    }

    method abajo() {
        const destino = position.down(1)
        if (self.puedoMoverA(destino)) {
            position = destino
        }
    }

    method izquierda() {
        const destino = position.left(1)
        if (self.puedoMoverA(destino)) {
            position = destino
        }
    }

    method derecha() {
        const destino = position.right(1)
        if (self.puedoMoverA(destino)) {
            position = destino
        }
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
        
        keyboard.space().onPressDo({ self.interactuar() })
        
        keyboard.num1().onPressDo({ self.upgrade(0) })
        keyboard.num2().onPressDo({ self.upgrade(1) })
        keyboard.num3().onPressDo({ self.upgrade(2) })
        keyboard.num4().onPressDo({ self.upgrade(3) })
    }
    method interactuar() {
        if (self.puedeEntregar() && !inventarioComidas.isEmpty()) {
            restaurante.entregar()
        } else {
            self.agarrar()
        }
    }

    method puedeEntregar() {
        return [
            game.at(4, 3),
            game.at(4, 6),
            game.at(13, 3),
            game.at(13, 6),
            game.at(4, 10),
            game.at(4, 13),
            game.at(13, 10),
            game.at(13, 13)
        ].contains(position)
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
