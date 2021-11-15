import personajes.*
import wollok.game.*

// Buscarle la vuelta para instanciar
object nivelEnergia {
	var digitos = [new PrimerDigito(y=1), new SegundoDigito(y=1)]
	
	method dibujarDigitos() {
		game.addVisual(iconoRayo)
		digitos.forEach({ d => 
			game.addVisual(d)
		})
	}
	
	method actualizarDigitos(energia) { digitos.forEach({ d => d.actualizar(energia) }) }
	
}

object nivelVida {
	var digitos = [new PrimerDigito(y=2), new SegundoDigito(y=2)]
	
	method dibujarDigitos() {
		game.addVisual(iconoPulso)
		digitos.forEach({ d => 
			game.addVisual(d)
		})
	}
	
	method actualizarDigitos(energia) { digitos.forEach({ d => d.actualizar(energia) }) }
	
}

object nivelDinero {
	var digitos = [new PrimerDigito(y=3), new SegundoDigito(y=3)]
	
	method dibujarDigitos() {
		game.addVisual(iconoDinero)
		digitos.forEach({ d => 
			game.addVisual(d)
		})
	}
	
	method actualizarDigitos(energia) { digitos.forEach({ d => d.actualizar(energia) }) }
	
}

class Digito {
	var property y = 0
	method colisionarConPersonaje(personaje) { }
	method guardar(elemento) { }
	method energia() = 0
}

object iconoRayo {
	var property position = game.at(0, game.height() - 1)
	var property image = "rayo.png"
}
object iconoPulso {
	var property position = game.at(0, game.height() - 2)
	var property image = "pulso.png"
}

object iconoDinero {
	var property position = game.at(0, game.height() - 3)
	var property image = "dinero.png"
}

class PrimerDigito inherits Digito {
	var property position = game.at(1, game.height() - y)
	var property image = personajeNivel1.energia().div(10).stringValue() + ".png"
	
	method actualizar(energia) { image = energia.div(10).stringValue() + ".png" }
}

class SegundoDigito inherits Digito {
	var property position = game.at(2, game.height() - y)
	var property image = (personajeNivel1.energia() % 10).toString() + ".png"
	
	method actualizar(energia) { image = (energia % 10).toString() + ".png" }
}






/*
object nivelEnergia {
	var digitos = [primerDigito, segundoDigito]

	method dibujarDigitos() {
		game.addVisual(iconoRayo)
		digitos.forEach({ d => 
			game.addVisual(d)
		})
	}
	
	method actualizarDigitos(energia) { digitos.forEach({ d => d.actualizar(energia) }) }
	
}

class Digito {
	method colisionarConPersonaje(personaje) { }
	method guardar(elemento) { }
	method energia() = 0
}

object iconoRayo  {
	var property position = game.at(0, game.height() - 1)
	var property image = "rayo.png"
}
object primerDigito inherits Digito {
	var property position = game.at(1, game.height() - 1)
	var property image = personajeNivel1.energia().div(10).stringValue() + ".png"
	
	method actualizar(energia) { image = energia.div(10).stringValue() + ".png" }
}

object segundoDigito inherits Digito {
	var property position = game.at(2, game.height() - 1)
	var property image = (personajeNivel1.energia() % 10).toString() + ".png"
	
	method actualizar(energia) { image = (energia % 10).toString() + ".png" }
}
  */
*/