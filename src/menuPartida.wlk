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
        comidas.forEach({ comida =>
            
            const copia = comida.copiarEn(game.at(20 + i, 2))
            game.addVisual(copia)
            
            i +=1
        })
    }
    
}




