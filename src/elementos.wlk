import wollok.game.*
import nivel1.*
import utilidades.*
import personajes.*
import nivelEnergia.*
import nivel2.*

// Elementos del tablero que el personaje puede mover
class Bloque {
	var property image
	var property position = 0

	method colisionarConPersonaje(personaje) {
		const movimientoX = personaje.posicionAnterior().x() - personaje.position().x()
		const movimientoY = personaje.posicionAnterior().y() - personaje.position().y()
		
		// si no esta en algun borde
		self.position(game.at(position.x() - movimientoX, position.y() - movimientoY))
		
		if(utilidadesParaJuego.hayColision(self)) {
			game.onCollideDo(self, { e => e.guardar(self)})
		}
	}
	
	method energia() = 0
	method guardar(elemento) { }
}

//class Petardo inherits Bloque {
//	var property image = "petardo.png"
//}
//
//object encendedor inherits Bloque {
//	var property image = "encendedor.png"
//}

// Alcantarilla donde se acumulan los elementos
object deposito {
	var property position = 0
	const property image = "alcantarilla.png"
	var property bloquesGuardados = 0
	
	method colisionarConPersonaje(personaje) { }
	
	method guardar(elemento) {
		game.removeVisual(elemento)
		bloquesGuardados += 1
		if(bloquesGuardados == 4) {
			const encendedor = new Bloque(image="encendedor.png")
			encendedor.position(utilidadesParaJuego.posicionArbitraria())
			game.addVisual(encendedor)
		}
		
		if(bloquesGuardados == 5) { 
			game.sound("explosion.mp3").play()
			game.schedule(2500, {
				nivelBloques.terminar()
			})
		}
	}
	
	method energia() = 0
}

// Provisiones que suman energia
class Caramelo {
	var property position = 0
	var property image 
	var property energia
	
	method colisionarConPersonaje(personaje) { }
	
	method guardar(elemento) { }
}

// Objetos nivel 2
class Enemigo {
	var property position = 0
	var property image
	var property dineroQueOtorga
	
	method colisionarConPersonaje(personaje) {
		console.println("Salud anterior: " + personaje.salud())
		console.println("Dinero anterior: " + personaje.dinero())
		self.darDinero(personaje)
		self.quitarSalud(personaje)
		nivelDinero.actualizarDigitos(personaje.dinero())
		nivelVida.actualizarDigitos(personaje.salud())
		game.removeVisual(self)
		nivelLlaves.sacarEnemigo(self)
		console.println("Salud ahora: " + personaje.salud())
		console.println("Dinero ahora: " + personaje.dinero())
		console.println("------------")
		console.println(nivelLlaves.cantidadEnemigos())
		if(nivelLlaves.cantidadEnemigos() == 0){
			const puerta = new Bloque(image="puerta.png")
			puerta.position(utilidadesParaJuego.posicionArbitraria())
			game.addVisual(puerta)
		}
		
	} 
	
	method esEnemigo() = true
	
	method quitarSalud(personaje) {
		personaje.salud(personaje.salud() - dineroQueOtorga.div(dineroQueOtorga)*3)
	}
	
	method darDinero(personaje) {
		personaje.dinero(personaje.dinero() + dineroQueOtorga)
	}
}

class CeldaSorpresa {
	var property position = 0
	var property image = "caja.png"
	var property saludQueOtorga = -10.randomUpTo(5)
	var property energiaQueOtorga = -10.randomUpTo(5)
	
	method colisionarConPersonaje(personaje) {
		console.println("Salud anterior: " + personaje.salud())
		console.println("Energia anterior: " + personaje.energia())
		personaje.salud(personaje.salud() + 10)
		personaje.energia(personaje.energia() + 10)
		game.removeVisual(self)
		console.println("Salud ahora: " + personaje.salud())
		console.println("Energia ahora: " + personaje.energia())
		console.println("------------")
	}
	
	method esEnemigo() = false
}