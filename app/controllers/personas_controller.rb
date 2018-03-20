class PersonasController  < ApplicationController

  # GET /personas
  # GET /personas.json
  def index
    @personas = Persona.all
  end

  # GET /personas/1
  # GET /personas/1.json
  def show
  end

  def email
    @persona = Persona.where("cuenta_cimav like '%#{params[:cuenta_cimav]}%'").first
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_persona
    @persona = Asistente.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def persona_params
    params.require(:persona).permit(:id, :tipo, :nombre, :cuenta_cimav)
  end

end