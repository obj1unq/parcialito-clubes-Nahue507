class ClubBarrio{
	var property socios=#{}
	var actividadesTotales=#{}
	var gastoMensual 
	var equipos=#{}
	method esEstrella(jugador)
	method sancion()
	method sancionGral(){
		actividadesTotales.foreach({actividad=>actividad.sancion()})
	}
	method esPrestigioso(){
		return equipos.any({equipo=>equipo.esExperimentado()or actividadesTotales.any({actividad=>actividad.cantidadEstrellas()>=5})})
	}
	method evaluacion(){
		return self.evaluacionBruta()/socios.size()
	}
	method evaluacionBruta()
	method sociosDestacados(){
		return socios.filter({socio=>socio.esCapitan() or socio.esOrganizador() })
	}
	method destacadoYEstrella(){
		return self.sociosDestacados().filter({socio=>socio.esEstrella()})
	}
}
class ClubProfesional inherits ClubBarrio{
	override method esEstrella(jugador){
		return jugador.valorPase()>valorParaElPase.valor()
	}
	override method evaluacionBruta(){
		return actividadesTotales.sum({actividad=>actividad.evaluacion()})*2-gastoMensual*5
	}
}
class ClubComunitario inherits ClubBarrio{
	override method esEstrella(jugador){
		return jugador.actividades().size()>3
	}
	override method evaluacionBruta(){
		return actividadesTotales.sum({actividad=>actividad.evaluacion()})
	}
}
class ClubTradicional inherits ClubBarrio{
	override method esEstrella(jugador){
		return jugador.actividades().size()>3 or jugador.valorPase()>valorParaElPase.valor()
	}
	override method evaluacionBruta(){
		return actividadesTotales.sum({actividad=>actividad.evaluacion()})-gastoMensual
	}
}
class Equipo inherits ClubBarrio{
	var property plantel=#{}
	var property tipo
	var capitan=plantel.find({jugador=>jugador.esCapitan()})
	var campeonatos
	var clubPertenencia
	var property vecesSancionado
	method reanudar()
	method esExperimentado(){
		return plantel.all({jugador=>jugador.cantidadPartidos()>=10})
	}
	override method evaluacion(){
		return if(capitan.esEstrella()){campeonatos*5+2*plantel.size()+5-20*vecesSancionado}else{campeonatos*5+2*plantel.size()-20*vecesSancionado}
		}
	override method sancion(){
		vecesSancionado=+1
	}	
	}
	
class EquipoFutbol inherits Equipo{
	override method evaluacion(){
		return plantel.count({jugador=>jugador.esEstrella()})+ if(capitan.esEstrella()){campeonatos*5+2*plantel.size()+5-30*vecesSancionado}else{campeonatos*5+2*plantel.size()-30*vecesSancionado}
	}
}
class Jugador inherits Socio{
	var property cantidadPartidos
	var property esCapitan
	var property valorPase
	var club
	override method esEstrella(jugador){
		return if(cantidadPartidos>=50){true}else{club.esEstrella(self)}
	}
	method transeferir(clubEmisor,clubReceptor,equipoNuevo){
		if(not clubEmisor.sociosDestacados().contains()and not clubEmisor == clubReceptor){
			clubEmisor.equipos().foreach({equipo=>equipo.plantel().remove(self)})
			clubEmisor.actividadesTotales().foreach({actividad=>actividad.participantes().remove(self)})
			cantidadPartidos=0
			clubEmisor.socios().remove(self)
			clubReceptor.socios().add(self)
			equipoNuevo.plantel().add(self)
			
		}
	}
}

 class ActividadSocial inherits ClubBarrio{
	var organizador
	var property participantes=#{}
	var valuacion
	var property cantidadEstrellas=participantes.count({participante=>participante.esEstrella()})
	var property estaSuspendida
	method reanudar(){
		estaSuspendida=false
	}
	override method sancion(){
		estaSuspendida=true
	}
	override method evaluacion(){
		return if(estaSuspendida){0}else{valuacion}
	}
}
class Socio inherits ClubBarrio{
	var tiempoEnInstitucion
	var property actividades=#{}
	var property esOrganizador	
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