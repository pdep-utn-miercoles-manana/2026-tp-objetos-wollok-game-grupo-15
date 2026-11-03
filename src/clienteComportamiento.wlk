import src.estadosEspera.*

class Pedido {
    const comidaPedida

    method comidaPedida() = comidaPedida

    // Las copias que genera copiarEn mantienen la imagen, por eso se compara por ella.
    // Si más adelante agregan un atributo "nombre" a Comida, conviene comparar por nombre.
    method satisface(comida) = comida.image() == comidaPedida.image()
}

class Grupo {
    const pedidos
    var estado = verde
    
    method imagenComensal() = estado.imagenCliente()

    method estado() = estado

    method pedidos() = pedidos

    method cantidadPendiente() = pedidos.size()

    method atendido() = pedidos.isEmpty()

    method quiere(comida) = pedidos.any({ p => p.satisface(comida) })

    method esperar() {
        estado = estado.siguiente()
    }

    method seVa() = estado.seVa()

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