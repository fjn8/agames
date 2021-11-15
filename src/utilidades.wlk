import wollok.game.*
import nivel1.*
import personajes.*
import elementos.*
import fondo.*
import nivelEnergia.* 

object utilidadesParaJuego {
	method posicionArbitraria() {
		return game.at(
			1.randomUpTo(game.width() - 1).truncate(0), 1.randomUpTo(game.height() - 1).truncate(0)
		)
	}
	
	method hayColision(elemento) {
		return game.colliders(elemento) != []
	}
	
	method perder() {
		game.schedule(0, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="perdiste.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				// y arranco el siguiente nivel
				nivelBloques.configurate()
				personajeSimple.energia(30)
				nivelEnergia.actualizarDigitos(personajeSimple.energia())
				deposito.cajasGuardadas(0)
				deposito.position(self.posicionArbitraria())
			})
		})
	}
	
	method crearPosicionesAleatorias(n) {
		var posiciones = []
		
		n.times({ i =>  self.agregarPosicionAleatoria(posiciones) })
		
		return posiciones
	}
	
	method agregarPosicionAleatoria(lista) {
		var posicion = self.posicionArbitraria()
		
		if(lista.contains(posicion)) {
			self.agregarPosicionAleatoria(lista)
		} else {
			lista.add(posicion)
		}
	}
}

