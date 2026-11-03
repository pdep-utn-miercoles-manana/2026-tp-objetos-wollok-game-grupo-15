object vidas {
    var cantidad = 5
    const property position = game.at(19, 14)

    method cantidad() = cantidad

    method perder() {
        cantidad = (cantidad - 1).max(0)
    }

    method agotadas() = cantidad == 0

    // Se muestra como texto en pantalla
    method text() = "Vidas: " + cantidad.toString()
    method textColor() = "FFFFFF"
}
