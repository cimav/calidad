class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :new_reminder, :create_reminder]

  # GET /documents
  # GET /documents.json
  def index
    department = Department.first
    redirect_to "/#{department.name.downcase}/documentos"
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @department = @document.department
  end

  def index_by_department
    @department = Department.find_by_name(params[:department_name])
    @documents = @department.documents
    respond_to do |format|
      format.html
      format.xls
    end
  end

  # GET /documents/new
  def new
  end

  # GET /documents/1/edit
  def edit
    @department = @document.department
    render layout: false
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html {redirect_to "/#{@document.department.name.downcase}/documentos", notice: 'Documento creado'}
        format.json {render :show, status: :created, location: @document}
      else
        format.html {render :new, alert: @document.errors}
        format.json {render json: @document.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html {redirect_to "/#{@document.department.name.downcase}/documentos", notice: 'Documento actualizado'}
        format.json {render :show, status: :ok, location: @document}
      else
        format.html {render :edit}
        format.json {render json: @document.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    respond_to do |format|
      if @document.destroy
        format.html {redirect_to "/#{@document.department.name.downcase}/documentos", notice: 'Se eliminó el documento'}
        format.json {head :no_content}
      else
        format.html {redirect_to "/#{@document.department.name.downcase}/documentos", notice: 'Error al eliminar documento'}
        format.json {head :no_content}
      end
    end
  end

  def new_reminder
    @document_owner = DocumentOwner.new
    render layout: false
  end

  def edit_reminder
    @document_owner = DocumentOwner.find(params[:id])
    render layout: false
  end

  def create_reminder
    document_owner = @document.document_owners.new
    document_owner.owner_name = params[:document_owner][:owner_name]
    document_owner.owner_email = params[:document_owner][:owner_email]

    respond_to do |format|
      if document_owner.save
        format.html {redirect_to "/#{@document.department.name.downcase}/documentos", notice: 'Recordatorio creado'}
        format.json {render :show, status: :ok, location: @document}
      else
        format.html {render :edit}
        format.json {render json: @document.errors, status: :unprocessable_entity}
      end
    end

  end

  def update_reminder
    document_owner = DocumentOwner.find(params[:id])
    document_owner.owner_name = params[:document_owner][:owner_name]
    document_owner.owner_email = params[:document_owner][:owner_email]

    respond_to do |format|
      if document_owner.save
        format.html {redirect_to "/#{document_owner.document.department.name.downcase}/documentos", notice: 'Recordatorio actualizado'}
        format.json {render :show, status: :ok, location: @document}
      else
        format.html {render :edit}
        format.json {render json: @document.errors, status: :unprocessable_entity}
      end
    end
  end

  def delete_reminder
    document_owner = DocumentOwner.find(params[:id])
    respond_to do |format|
      if document_owner.destroy
        format.html {redirect_to "/#{document_owner.document.department.name.downcase}/documentos", notice: 'Recordatorio eliminado'}
        format.json {render :show, status: :ok, location: document_owner.document}
      else
        format.html {redirect_to "/#{document_owner.document.department.name.downcase}/documentos", notice: 'Error al eliminar recordatorio'}
        format.json {render json: document_owner.errors, status: :unprocessable_entity}
      end
    end
  end

  def get_personas
    personas = {}
    Persona.all.each do |persona|
      personas[persona.nombre.split.map(&:capitalize).join(' ')] = persona.cuenta_cimav.blank? ? 'http://cimav.edu.mx/foto/default' : "http://cimav.edu.mx/foto/#{persona.cuenta_cimav}"
    end
    render json: personas
  end

  def get_email
    persona = Persona.find_by_nombre(params[:nombre])
    email = persona.cuenta_cimav.blank? ? nil : "#{persona.cuenta_cimav.downcase}@cimav.edu.mx"
    render plain: email
  end

  def master_list
    department = Department.find(params[:department_id])
    document_type = params[:document_type].to_i
    background = "#{Rails.root.to_s}/app/assets/images/hoja_membretada_lm.png"
    pdf = Prawn::Document.new(left_margin: 50,right_margin: 50, background: background, background_scale: 0.20, top_margin: 175, bottom_margin: 40)
    cimav_logo = "#{Rails.root}/app/assets/images/logo_cimav_crop.png"
    documents = department.documents.where(document_type:document_type)
    date = documents.order(:revision_date).last.revision_date rescue ''

    title_table = pdf.make_table([['', '<b>LISTADO MAESTRO</b>']], cell_style: {inline_format: true, align: :center, valign: :center,height:50, size: 20}, column_widths:[120,380]) #celda vacia para imagen
    date_table = pdf.make_table([["Fecha: #{date}"],["Responsable: #{department.manager_name rescue 'Sin definir'}"]], width:250, cell_style: {font_style: :bold, size:11})
    second_table = pdf.make_table([["De: #{Document::DOCUMENT_TYPES[document_type]}", date_table]], cell_style: {font_style: :bold, size:11}, column_widths:[250,250]) #celda de tipo de documento
    third_table = pdf.make_table([['Documento', 'Código', 'Revisión', 'Efectivo']], cell_style: {font_style: :bold, align: :center},  column_widths:[250,83.3,83.3,83.3]) #celda de tipo de documento

    pdf.repeat :all do
      # header
      pdf.canvas do
        pdf.bounding_box [pdf.bounds.left + 50, pdf.bounds.top - 36] , :width  => pdf.bounds.width do
          pdf.table([[title_table],[second_table],[third_table]], cell_style: {inline_format: true}) # Tabla cabecera
        end
      end


    end
    data_table = []
    documents.each_with_index {|document, index| data_table.push [document.name,document.code,document.revision_number,document.revision_date]}
    pdf.move_down 20
    pdf.table(data_table, column_widths:[250,83.3,83.3,83.3], cell_style:{size:10}) if !data_table.blank?

    pdf.number_pages 'Responsable del formato: CGC                              Página <page> de <total>                              Formato: CA01F04-05',  at: [pdf.bounds.left + 20, 0], size:10

    send_data pdf.render, filename: "listado-maestro.pdf", type: 'application/pdf', disposition: 'inline'
  end

  def update_department
    department = Department.find(params[:department_id])
    department.name = params[:department][:name]
    department.manager_name = params[:department][:manager_name]
    respond_to do |format|
      if department.save
        format.html {redirect_to "/#{department.name.downcase}/documentos", notice: 'Departamento actualizado'}
        format.json {render :show, status: :ok, location: @document}
      else
        format.html {redirect_to "/#{department.name.downcase}/documentos", notice: 'Error al actualizar departamento'}
        format.json {render json: @document.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def document_params
    params.require(:document).permit(:name, :code, :revision_number, :revision_date, :document_type, :department_id)
  end

end
