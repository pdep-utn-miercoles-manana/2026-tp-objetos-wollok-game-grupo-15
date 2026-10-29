import src.comidasComportamiento.*

object menu {
    var property position = game.at(18, 0) 
    var property image = "menu.png"
    var i = 0
    method iniciar(){
        game.addVisual(self)
        self.dibujarComida()
        
    }

    method dibujarComida() {
        comidas.listaComidas().forEach({ comida =>
            
            const copia = comida.copiarEn(game.at(20 + i, 2))
            game.addVisual(copia)
            
            const textotiempo = new TextoTiempo(
                position = copia.position().down(1),
                comidaAsociada = comida
            )
            game.addVisual(textotiempo)

            const nombreTick = "cocinando " + i.toString()
            self.iniciarContador(1000, nombreTick, comida)
            
            i +=1
        })
    }

    method iniciarContador(tiempo, nombre, comida){
        game.onTick(tiempo, nombre, {
                comida.decrementarTiempo()
                
                if (comida.tiempoCoccion() == 0) {
                    game.removeTickEvent(nombre) 
                }
            })
    }
    
}

class TextoTiempo {
    var property position
    const comidaAsociada

    method text() = comidaAsociada.tiempoCoccion().toString() + "s"
    method textColor() = "FFFFFFFF" 
}


