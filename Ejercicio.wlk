class ClubBarrio{
	method esEstrella(jugador)
	
}
class ClubProfesional inherits ClubBarrio{
	override method esEstrella(jugador){
		return jugador.valorPase()>valorParaElPase.valor()
	}
}
class ClubComunitario inherits ClubBarrio{
	override method esEstrella(jugador){
		return jugador.actividades().size()>3
	}
}
class Equipo inherits ClubBarrio{
	var plantel=#{}
	var capitan
	
	}
class Jugador inherits Socio{
	var cantidadPartidos
	var property valorPase
	override method esEstrella(jugador){
		return cantidadPartidos>=50
	}
}

 class ActividadSocial inherits ClubBarrio{
	var organizador
	var participantes=#{}
}
class Socio inherits ClubBarrio{
	var tiempoEnInstitucion
	var property actividades=#{}	
	override method esEstrella(jugador){
		return tiempoEnInstitucion>20
	}
}
object valorParaElPase{
	var property valor
	method cambiarValor(numero){
		valor=numero
		}
	}