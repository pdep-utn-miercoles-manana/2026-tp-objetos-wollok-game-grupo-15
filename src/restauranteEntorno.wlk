import src.comidasComportamiento.*
import src.vidasComportamiento.*
import src.personajeComportamiento.*
import src.clienteComportamiento.*
import src.visualesSalon.*
import src.temporizador.*
import src.finPartida.*

class Mesa {
    var property position
    var grupo = null

    method capacidad() = 4

    method image() = "mesaGrande.png"

    method grupo() = grupo

    method ocupada() = grupo != null

    method hayPersona(indice) = self.ocupada() && indice < grupo.cantidadPendiente()

    method imagenComensal(indice) = if (self.hayPersona(indice)) grupo.imagenComensal() else "vacio.png"

    method imagenPedido(indice) = if (self.hayPersona(indice)) grupo.pedidos().get(indice).comidaPedida().image() else "vacio.png"

    method sentar(nuevoGrupo) {
        if (self.ocupada()) {
            throw new DomainException(message = "La mesa ya está ocupada")
        }
        if (nuevoGrupo.cantidadPendiente() > self.capacidad()) {
            throw new DomainException(message = "No entran tantas personas en la mesa")
        }
        grupo = nuevoGrupo
    }

    method liberar() {
        grupo = null
    }

    method esperar() {
        if (self.ocupada()) {
            grupo.esperar()
        }
    }

    method grupoSeFue() = self.ocupada() && grupo.seVa()

    method quiere(comida) = self.ocupada() && grupo.quiere(comida)

    method servir(comida) {
        if (!self.ocupada()) {
            throw new DomainException(message = "No hay nadie en la mesa")
        }
        const propina = grupo.atender(comida)
        if (grupo.atendido()) {
            self.liberar()
        }
        return propina
    }

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
    const intervaloLlegada = 10000   // llega un grupo cada 10 segundos
    const intervaloEspera = 1000     // cada segundo cada grupo cuenta su propia paciencia

    method iniciar() {
        mesas.clear()
        self.agregarMesa(3, 11, 19, 12)
        self.agregarMesa(3, 4, 19, 8)
        self.agregarMesa(12, 11, 23, 12)
        self.agregarMesa(12, 4, 23, 8)

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
        game.onTick(intervaloLlegada, "llegadaClientes", { self.llegadaClientes() })
        game.onTick(intervaloEspera, "esperaClientes", { self.pasarEspera() })
    }
    method entregar() {
        mesas
            .filter({ m => m.estaCerca(jugador.position()) })
            .forEach({ m => jugador.entregar(m) })
    }

    method nuevoGrupo() {
    const cantidad = [1, 2, 2, 3].anyOne()
    const pedidos = (1..cantidad).map({ i =>
        new Pedido(comidaPedida = comidas.anyOne())
    })
    return new Grupo(pedidos = pedidos)
    }

    method llegadaClientes() {
    const libres = mesas.filter({ m => !m.ocupada() })
    if (!libres.isEmpty()) {
        const mesa = libres.anyOne()
        const grupo = self.nuevoGrupo()
        mesa.sentar(grupo)
    }
    }

    method pasarEspera() {
        mesas.forEach({ m =>
            if (m.grupoSeFue()) {
                m.liberar()
                self.perderVida()
            } else {
                m.esperar()
            }
        })
    }

    

    method perderVida() {
        vidas.perder()
        if (vidas.agotadas()) {
            self.detenerClientes()
            temporizador.detener()
            finPartida.perder()
        }
    }

    method detenerClientes() {
        game.removeTickEvent("llegadaClientes")
        game.removeTickEvent("esperaClientes")
    }

    // (x, y) es la celda de abajo a la izquierda de la mesa.
    // (xPanel, yPanel) es la celda de abajo a la izquierda de su ventana en el panel.
    method agregarMesa(x, y, xPanel, yPanel) {
        const mesa = new Mesa(position = game.at(x, y))
        mesas.add(mesa)
        game.addVisual(mesa)

        self.agregarVisuales(self.cuatroCeldas(x, y, 2), { i, p => new Comensal(mesa = mesa, indice = i, position = p) })
        self.agregarVisuales(self.cuatroCeldas(xPanel, yPanel, 1), { i, p => new CasilleroPedido(mesa = mesa, indice = i, position = p) })
    }
    // Crea un visual por cada celda. "crear" recibe el número (0 a 3) y la posición.
    method agregarVisuales(celdas, crear) {
        (0..3).forEach({ i => game.addVisual(crear.apply(i, celdas.get(i))) })
    }

 // Cuatro celdas en rectángulo: arriba-izquierda, arriba-derecha, abajo-izquierda, abajo-derecha.
    method cuatroCeldas(x, y, separacion) = [game.at(x, y + 1), game.at(x + separacion, y + 1), game.at(x, y), game.at(x + separacion, y)]
}