import src.comidasComportamiento.*
import src.finPartida.*

object temporizador {
    var property tiempoRestante = 180

    method iniciar() {
        self.contadorTiempoJuego()
        self.contadorComidas()
    }


    method contadorComidas(){
        var i = 0
        comidas.forEach({ comida =>
            const textotiempo = new TextoTiempoComida(position = game.at(20 + i, 1), comidaAsociada = comida)
            game.addVisual(textotiempo)
            const nombreTick = "cocinando " + i.toString()
            game.onTick(1000, nombreTick, {comida.decrementarTiempo()})
            
            i +=1
        })
    }

    method contadorTiempoJuego(){
        const textoTiempo = new TextoTiempoJuego(position = game.at(24, 15))
        game.addVisual(textoTiempo)
        self.reiniciar()
        game.onTick(1000, "cuenta_regresiva_juego", {
            self.descontarSegundo()
        })
    }

    method descontarSegundo() {
        tiempoRestante = (tiempoRestante - 1).max(0)
        
        if (tiempoRestante == 0) {
            self.detener()
            finPartida.ganar()
        }
    }

    method detener() {
        game.removeTickEvent("cuenta_regresiva_juego")
        var i = 0
        comidas.forEach({ comida =>
            game.removeTickEvent("cocinando " + i.toString())
            i += 1
        })
    }
    method reiniciar() {
        tiempoRestante = 180
        comidas.forEach({ comida => comida.reiniciar() })
    }


}

class TextoTiempoComida {
    var property position
    const comidaAsociada

    method text() = comidaAsociada.tiempoCoccion().toString() + "s"
    method textColor() = "FFFFFFFF" 
}

class TextoTiempoJuego {
    var property position

    method text() {
        const minutos = temporizador.tiempoRestante().div(60)
        const segundos = temporizador.tiempoRestante() % 60

        const minTexto = minutos.toString()
        const segTexto = if (segundos < 10)
            "0" + segundos.toString()
        else
            segundos.toString()

        return minTexto + ":" + segTexto
    }

    method textColor() = "FFFFFFFF"
}