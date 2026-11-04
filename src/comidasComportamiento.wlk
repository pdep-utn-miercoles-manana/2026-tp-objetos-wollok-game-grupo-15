import src.temporizador.*
class Comida {
    var property position
    var property tiempoCoccion
    const tiempoOriginal = tiempoCoccion
    var property tiempoMaximo = tiempoCoccion
    var property precio
    var property image
    
    method copiarEn(nuevaPosicion) {
        return new Comida(
            position = nuevaPosicion,
            tiempoCoccion = tiempoCoccion,
            precio = precio,
            image = image
        )
    }
    method reiniciar() {
        tiempoMaximo = tiempoOriginal
        tiempoCoccion = tiempoOriginal
    }

    method decrementarTiempo() {
        tiempoCoccion = (tiempoCoccion - 1).max(0)
    }

    method bajarTiempoUpgrade(){
        tiempoMaximo = (tiempoMaximo - 1).max(1)
    }
    method subirTiempoDowngrade(){
        tiempoMaximo = tiempoMaximo + 1
    }
    method reiniciarTiempo() {
        tiempoCoccion = tiempoMaximo
    }

}

const carne = new Comida(
    position = game.at(7, 0), 
    tiempoCoccion = 10, 
    precio = 10,
    image = "carne.png"
)

const cerdo = new Comida(
    position = game.at(8, 0), 
    tiempoCoccion = 10, 
    precio = 10,
    image = "cerdo.png"
)

const pollo = new Comida(
    position = game.at(9, 0), 
    tiempoCoccion = 12, 
    precio = 12,
    image = "pollo.png"
)

const manzanaDorada = new Comida(
    position = game.at(10, 0), 
    tiempoCoccion = 15, 
    precio = 20,
    image = "manzanadorada.png"
)

const comidas = [carne, cerdo, pollo, manzanaDorada]
