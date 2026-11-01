import src.estadosEspera.*

class Pedido {
    const comidaPedida

    method comidaPedida() = comidaPedida

    // Las copias que genera copiarEn mantienen la imagen, por eso se compara por ella.
    // Si más adelante agregan un atributo "nombre" a Comida, conviene comparar por nombre.
    method satisface(comida) = comida.image() == comidaPedida.image()
}

class Cliente {
    const property pedido
    var estado = verde

    method estado() = estado

    method esperar() {
        estado = estado.siguiente()
    }

    method seVa() = estado.seVa()

    method propinaActual() = estado.propina()
    method quiere(comida) = pedido.satisface(comida)
    // Devuelve la propina que deja si le sirven lo que pidió.
    method atender(comida) {
        if (!self.quiere(comida)) {
            throw new DomainException(message = "El cliente no pidió esto")
        }
        return self.propinaActual()
    }
    
}
