// Estados de espera de un cliente. Todos responden a los mismos mensajes
// (propina, siguiente, seVa), así que el cliente no necesita ningún if por color.

object verde {
    method propina() = 10
    method siguiente() = amarillo
    method seVa() = false
}

object amarillo {
    method propina() = 6
    method siguiente() = naranja
    method seVa() = false
}

object naranja {
    method propina() = 3
    method siguiente() = rojo
    method seVa() = false
}

object rojo {
    method propina() = 0
    method siguiente() = self
    method seVa() = true
}
