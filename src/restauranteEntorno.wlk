import src.comidasComportamiento.*
import src.vidasComportamiento.*
import src.personajeComportamiento.*
import src.clienteComportamiento.*

class Mesa {
    var property position
    var cliente = null

    method image() = "mesaGrande.png"

    method cliente() = cliente

    method ocupada() = cliente != null

    method sentar(nuevoCliente) {
        if (self.ocupada()) {
            throw new DomainException(message = "La mesa ya está ocupada")
        }
        cliente = nuevoCliente
    }

    method liberar() {
        cliente = null
    }

    method esperar() {
        if (self.ocupada()) {
            cliente.esperar()
        }
    }

    method clienteSeFue() = self.ocupada() && cliente.seVa()

    method servir(comida) {
        if (!self.ocupada()) {
            throw new DomainException(message = "No hay nadie en la mesa")
        }
        const propina = cliente.atender(comida)
        self.liberar()
        return propina
    }
    method quiere(comida) = self.ocupada() && cliente.quiere(comida)

// la mesa ocupa 3x2 celdas desde su posición; "cerca" es esa zona más un borde de una celda
    method estaCerca(posicion) =
        posicion.x().between(position.x() - 1, position.x() + 3) &&
        posicion.y().between(position.y() - 1, position.y() + 2)
}

class Cocina {
    var property position
    method image() = "cocina.png"
}

object restaurante {
    const property mesas = []

    method iniciar() {
        self.agregarMesa(3, 11)
        self.agregarMesa(3, 4)
        self.agregarMesa(12, 11)
        self.agregarMesa(12, 4)

        //cocinas
        game.addVisual(new Cocina(position = game.at(7, 0)))
        game.addVisual(new Cocina(position = game.at(8, 0)))
        game.addVisual(new Cocina(position = game.at(9, 0)))
        game.addVisual(new Cocina(position = game.at(10, 0)))

        game.addVisual(carne)
        game.addVisual(cerdo)
        game.addVisual(pollo)
        game.addVisual(manzanaDorada)
        keyboard.e().onPressDo({ self.entregar() })
    }
    method entregar() {
        mesas
            .filter({ m => m.estaCerca(jugador.position()) })
            .forEach({ m => jugador.entregar(m) })
    }

    

    method perderVida() {
        vidas.perder()
        if (vidas.agotadas()) {
            game.say(jugador, "¡Perdiste!")
            game.schedule(2000, { game.stop() })
        }
    }

    // (x, y) es la celda de abajo a la izquierda de la mesa
    method agregarMesa(x, y) {
        const mesa = new Mesa(position = game.at(x, y))
        mesas.add(mesa)
        game.addVisual(mesa)
    }
}