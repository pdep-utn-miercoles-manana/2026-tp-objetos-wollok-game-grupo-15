object vidas {
    var cantidad = 3
    const property position = game.at(19, 15)

    method cantidad() = cantidad

    method perder() {
        cantidad = (cantidad - 1).max(0)
    }

    method agotadas() = cantidad == 0
    method reiniciarVidas() {
        cantidad = 5
    }

    // Se muestra como texto en pantalla
    method text() = "Vidas: " + cantidad.toString()
    method textColor() = "FFFFFF"
}
