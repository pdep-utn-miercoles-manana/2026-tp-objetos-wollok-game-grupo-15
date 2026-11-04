// Estados de espera de un grupo. Todos responden a los mismos mensajes
// (propina, siguiente, seVa), así que el cliente no necesita ningún if por color.

object verde {
    method propina() = 10
    method siguiente() = amarillo
    method seVa() = false
    method imagenCliente() = "cliente_verde.png"
}

object amarillo {
    method propina() = 6
    method siguiente() = naranja
    method seVa() = false
    method imagenCliente() = "cliente_amarillo.png"
}

object naranja {
    method propina() = 3
    method siguiente() = rojo
    method seVa() = false
    method imagenCliente() = "cliente_naranja.png"
}

object rojo {
    method propina() = 0
    method siguiente() = self
    method seVa() = true
    method imagenCliente() = "cliente_rojo.png"
}

// Cuántos segundos dura cada color antes de pasar al siguiente.
object paciencia {
    method segundosPorEstado() = 6
}
