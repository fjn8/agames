import wollok.game.*
import fondo.*
import personajes.*
import utilidades.*
import elementos.*
import utilidades.*
import nivelEnergia.*

object nivelLlaves {
	var visualesNivel = [personajeNivel2, new Enemigo(image="personaje01.png", dineroQueOtorga = 5),
		new Enemigo(image="personaje02.png", dineroQueOtorga = 10), new Enemigo(image="personaje03.png", dineroQueOtorga = 15),
		new CeldaSorpresa(), new CeldaSorpresa()]
		
	var posiciones = utilidadesParaJuego.crearPosicionesAleatorias(visualesNivel.size())
	
	method cantidadEnemigos() = visualesNivel.count({ v => v.esEnemigo()})
	
	method sacarEnemigo(enemigo) { visualesNivel.remove(enemigo)}
	
	method configurate() {
		// Agregar el fondo
		game.addVisual(new Fondo(image="fondoSegundoNivel.png"))
			
			
		// Agregar visuales con posicion aleatoria
		(0..(visualesNivel.size() - 1)).forEach({ i => 
			visualesNivel.get(i).position(posiciones.get(i))
			game.addVisual(visualesNivel.get(i))
		})
			
		// Agregar indicador de energia
		nivelEnergia.actualizarDigitos(personajeNivel2.energia())
		nivelEnergia.dibujarDigitos()
		nivelVida.actualizarDigitos(personajeNivel2.salud())
		nivelVida.dibujarDigitos()
		nivelDinero.actualizarDigitos(personajeNivel2.dinero())
		nivelDinero.dibujarDigitos()
			
		keyboard.right().onPressDo({ personajeNivel2.moverDerecha() })
		keyboard.left().onPressDo({ personajeNivel2.moverIzquierda() })
		keyboard.up().onPressDo({ personajeNivel2.moverArriba() })
		keyboard.down().onPressDo({ personajeNivel2.moverAbajo() })
	}
	
	method ganar() {
		game.clear()
		game.addVisual(new Fondo(image="complete.png"))
		game.schedule(3000, {
			game.stop()
		})
	}
	
	
}
