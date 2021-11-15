import wollok.game.*
import utilidades.*
import nivel1.*
import elementos.*
import fondo.*
import nivelEnergia.* 

class Personaje {
	var property position = game.at(10,8)
	var property energia = 50
	
	method cambiarPosicion(pos) {
		self.position(pos)
		if(utilidadesParaJuego.hayColision(self)) {
			game.onCollideDo(self, { e => e.colisionarConPersonaje(self) })
		}
		
		energia -= 1
		nivelEnergia.actualizarDigitos(energia)
		
		if(energia == 0) {
			utilidadesParaJuego.perder()
		}
	}
	
	method moverDerecha() { 
		if(position.x() < game.width() - 1) {
			self.cambiarPosicion(position.right(1))
		} else {
			self.cambiarPosicion(game.at(0, position.y()))
		}
	}
	
	method moverIzquierda() { 
		if(position.x() != 0) {
			self.cambiarPosicion(position.left(1))
		} else {
			self.cambiarPosicion(game.at(game.width() - 1, position.y()))
		}
	}
	
	method moverArriba() { 
		if(position.y() < game.height() - 1) {
			self.cambiarPosicion(position.up(1))
		} else {
			self.cambiarPosicion(game.at(position.x(), 0))
		}
	}
	
	method moverAbajo() { 
		if(position.y() != 0) {
			self.cambiarPosicion(position.down(1))
		} else {
			self.cambiarPosicion(game.at(position.x(), game.height() - 1))
		}
	}	
}

object personajeNivel1 inherits Personaje {
	const property image = "edys.png"
	var property posicionAnterior = 0
	
	override method cambiarPosicion(pos) {
		self.posicionAnterior(self.position())
		super(pos)
	}
	
	method agarrarProvision() {
		if(self.hayProvisionesAlrededor()) {
			self.provisionesAlrededor().forEach({ p => 
				energia += p.energia()
				game.say(self, "Este caramelo me dio " + p.energia() + " de energía!")
				game.removeVisual(p)
			})
			nivelEnergia.actualizarDigitos(energia)
		}
	}
	
	method hayProvisionesAlrededor() {
		return not self.provisionesAlrededor().isEmpty()
	}
	
	method provisionesAlrededor() {
		var objetosAlrededor = []
		game.getObjectsIn(position.right(1)).forEach({ p => objetosAlrededor.add(p) })
		game.getObjectsIn(position.left(1)).forEach({ p => objetosAlrededor.add(p) })
		game.getObjectsIn(position.up(1)).forEach({ p => objetosAlrededor.add(p) })
		game.getObjectsIn(position.down(1)).forEach({ p => objetosAlrededor.add(p) })
		
		return objetosAlrededor.filter({ o => o.energia() > 0 })
	}
}

object personajeNivel2 inherits Personaje {
	var property salud = 40
	var property dinero = 0
	var property image = "edys.png"
	
	override method cambiarPosicion(pos) {
		super(pos)
		if(salud == 0) {
			utilidadesParaJuego.perder()
		}
	}
	
	method esEnemigo() = false
	
}