import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel2.*
import utilidades.*
import nivelEnergia.* 

object nivelBloques {
	var visualesNivel = [new Bloque(image="petardo.png"), new Bloque(image="petardo.png"), 
		new Bloque(image="petardo.png"),new Bloque(image="petardo.png"), 
		new Caramelo(image = "caramelo1.png", energia = 2), new Caramelo(image = "caramelo1.png", energia = 2), 
		new Caramelo(image = "caramelo2.png", energia = 5), new Caramelo(image = "caramelo3.png", energia = 10),
		deposito, personajeNivel1] 
		
	var posiciones = utilidadesParaJuego.crearPosicionesAleatorias(visualesNivel.size())
	
	method configurate() {
		// Agregar el fondo
		game.addVisual(new Fondo(image="fondoPrimerNivel.jpg"))
			
			
		// Agregar visuales con posicion aleatoria
		(0..(visualesNivel.size() - 1)).forEach({ i => 
			visualesNivel.get(i).position(posiciones.get(i))
			game.addVisual(visualesNivel.get(i))
		})
			
		// Agregar indicador de energia
		nivelEnergia.dibujarDigitos()

			
		keyboard.right().onPressDo({ personajeNivel1.moverDerecha() })
		keyboard.left().onPressDo({ personajeNivel1.moverIzquierda() })
		keyboard.up().onPressDo({ personajeNivel1.moverArriba() })
		keyboard.down().onPressDo({ personajeNivel1.moverAbajo() })
		keyboard.space().onPressDo({ personajeNivel1.agarrarProvision() })
	}
	
	method terminar() {
		game.clear()
		game.addVisual(new Fondo(image="complete.png"))
		game.schedule(3000, {
			game.clear()
			nivelLlaves.configurate()
		})
	}
		
}

