import src.estadosEspera.*

class Pedido {
    const comidaPedida

    method comidaPedida() = comidaPedida


    method satisface(comida) = comida.image() == comidaPedida.image()
}

class Grupo {
    const pedidos
    var estado = verde
    var segundosEnEstado = 0
    
    method imagenComensal() = estado.imagenCliente()

    method estado() = estado

    method pedidos() = pedidos

    method cantidadPendiente() = pedidos.size()

    method atendido() = pedidos.isEmpty()

    method quiere(comida) = pedidos.any({ p => p.satisface(comida) })

    // Pasó 1 segundo: el grupo cuenta su propio tiempo
    method esperar() {
        segundosEnEstado += 1
        if (segundosEnEstado >= paciencia.segundosPorEstado() && !estado.seVa()) {
            self.avanzarEstado()
        }
    }

    // Cambia de color y vuelve a contar desde cero
    method avanzarEstado() {
        estado = estado.siguiente()
        segundosEnEstado = 0
    }

    // Se va cuando está en rojo y ya agotó su tiempo en rojo
    method seVa() = estado.seVa() && segundosEnEstado >= paciencia.segundosPorEstado()

    method propinaActual() = estado.propina()

    method atender(comida) {
        if (!self.quiere(comida)) {
            throw new DomainException(message = "El grupo no pidió esto")
        }
        const pedido = pedidos.find({ p => p.satisface(comida) })
        pedidos.remove(pedido)
        return self.propinaActual()
    }
}