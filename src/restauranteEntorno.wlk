import src.comidasComportamiento.*

class Mesa {
    var property position
    method image() = "pared.png"
}

class Cocina {
    var property position
    method image() = "cocina.png"
}


object restaurante {
    method iniciar() {
        //izquierda
        game.addVisual(new Mesa(position = game.at(3, 12)))
        game.addVisual(new Mesa(position = game.at(4, 12)))
        game.addVisual(new Mesa(position = game.at(5, 12)))
        game.addVisual(new Mesa(position = game.at(3, 11)))
        game.addVisual(new Mesa(position = game.at(4, 11)))
        game.addVisual(new Mesa(position = game.at(5, 11)))
        
        game.addVisual(new Mesa(position = game.at(3, 5)))
        game.addVisual(new Mesa(position = game.at(4, 5)))
        game.addVisual(new Mesa(position = game.at(5, 5)))
        game.addVisual(new Mesa(position = game.at(3, 4)))
        game.addVisual(new Mesa(position = game.at(4, 4)))
        game.addVisual(new Mesa(position = game.at(5, 4)))

        //derecha
        game.addVisual(new Mesa(position = game.at(14, 12)))
        game.addVisual(new Mesa(position = game.at(13, 12)))
        game.addVisual(new Mesa(position = game.at(12, 12)))
        game.addVisual(new Mesa(position = game.at(14, 11)))
        game.addVisual(new Mesa(position = game.at(13, 11)))
        game.addVisual(new Mesa(position = game.at(12, 11)))

        game.addVisual(new Mesa(position = game.at(14, 5)))
        game.addVisual(new Mesa(position = game.at(13, 5)))
        game.addVisual(new Mesa(position = game.at(12, 5)))
        game.addVisual(new Mesa(position = game.at(14, 4)))
        game.addVisual(new Mesa(position = game.at(13, 4)))
        game.addVisual(new Mesa(position = game.at(12, 4)))

        //cocinas
        game.addVisual(new Cocina(position = game.at(7, 0)))
        game.addVisual(new Cocina(position = game.at(8, 0)))
        game.addVisual(new Cocina(position = game.at(9, 0)))
        game.addVisual(new Cocina(position = game.at(10, 0)))
            
        game.addVisual(carne)
        game.addVisual(cerdo)
        game.addVisual(pollo)
        game.addVisual(manzanaDorada)
    }
    
}