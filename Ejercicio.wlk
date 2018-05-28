class ClubBarrio{
	var perfil
	method esEstrella()
	
}
class Equipo inherits ClubBarrio{
	var plantel=#{}
	var capitan
	
	}
class Jugador inherits Socio{
	var cantidadPartidos
	var valorPase
	override method esEstrella(){
		return cantidadPartidos>=50
	}
}

 class ActividadSocial inherits ClubBarrio{
	var organizador
	var participantes=#{}
}
class Socio inherits ClubBarrio{
	var tiempoEnInstitucion
	var actividades=#{}	
	override method esEstrella(){
		return tiempoEnInstitucion>20
	}
}
object valorParaElPase{
	var property valor
	method cambiarValor(numero){
		valor=numero
	}
//